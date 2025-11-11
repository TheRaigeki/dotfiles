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
  
  local version = (json.dependencies or {})['@angular/core'] or ''
  return version:match('%d+%.%d+%.%d+') or ''
end

return {
  cmd = function(dispatchers, config)
    local root_dir = config.root or fn.getcwd()
    
    -- Hardcode known paths - no searching needed!
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
  root_markers = { 'angular.json', 'nx.json' },
}
