-- auto pairs only for (), [], {}
return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
  },
}
