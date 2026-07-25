return {
  "mrcjkb/rustaceanvim",
  opts = function(_, opts)
    local sysroot = vim.fn.trim(vim.fn.system("rustup run stable rustc --print sysroot"))
    opts.server = opts.server or {}
    opts.server.default_settings = opts.server.default_settings or {}
    opts.server.default_settings["rust-analyzer"] = vim.tbl_deep_extend(
      "force",
      opts.server.default_settings["rust-analyzer"] or {},
      {
        cargo = { sysroot = sysroot },
      }
    )
    return opts
  end,
}
