local fs, fn, uv = vim.fs, vim.fn, vim.uv

local function get_angular_core_version(root_dir)
  local package_json = fs.joinpath(root_dir, 'package.json')
  if not uv.fs_stat(package_json) then
    return ''
  end
  
  local ok, f = pcall(io.open, package_json, 'r')
  if not ok or not f then
    return ''
  end
  
  local json = vim.json.decode(f:read('*a')) or {}
  f:close()

  -- Check both dependencies and devDependencies
  local version = (json.dependencies or {})['@angular/core']
    or (json.devDependencies or {})['@angular/core']
    or ''
  return version:match('%d+%.%d+%.%d+') or ''
end

return {
  cmd = function(dispatchers, config)
    local root_dir = config.root_dir or config.root or fn.getcwd()

    -- Debug: uncomment to verify version detection
    -- vim.notify('angularls root: ' .. root_dir .. ' | version: ' .. get_angular_core_version(root_dir), vim.log.levels.INFO)
    
    -- Hardcode known paths, to prevent expensive fs operations
    local ngserver_path = fn.stdpath('data') .. '/mason/packages/angular-language-server/node_modules/@angular/language-server/bin/ngserver'
    local mason_node_modules = fn.stdpath('data') .. '/mason/packages/angular-language-server/node_modules'
    local project_node_modules = root_dir .. '/node_modules'
    
    -- Just concatenate the two paths - project first (for version match), then Mason (fallback)
    local ts_probe = project_node_modules .. ',' .. mason_node_modules .. '/@angular/language-server/node_modules'
    local ng_probe = project_node_modules .. ',' .. mason_node_modules .. '/@angular/language-server/node_modules'
    
    local cmd = {
      'node',
      ngserver_path,
      '--stdio',
      '--tsProbeLocations',
      ts_probe,
      '--ngProbeLocations',
      ng_probe,
      '--angularCoreVersion',
      get_angular_core_version(root_dir),
    }
    
    return vim.lsp.rpc.start(cmd, dispatchers)
  end,
  
  filetypes = { 'typescript', 'html', 'htmlangular' },

  root_dir = function(bufnr, on_dir)
    local util = require('lspconfig.util')
    local fname = vim.api.nvim_buf_get_name(bufnr)

    -- First, try standard upward search for angular.json
    local standard_root = util.root_pattern('angular.json', 'nx.json')(fname)
    if standard_root then
      on_dir(standard_root)
      return
    end

    -- Fallback: search upward for a dir containing frontend/webapp/angular.json
    local dir = vim.fs.dirname(fname)
    while dir and dir ~= '/' do
      local angular_path = dir .. '/frontend/webapp/angular.json'
      if vim.uv.fs_stat(angular_path) then
        on_dir(dir .. '/frontend/webapp')
        return
      end
      dir = vim.fs.dirname(dir)
    end
  end,
}
