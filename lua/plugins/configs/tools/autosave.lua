return function()
  require('auto-save').setup({
    enabled = true,
    -- execution_message = "Auto-saving...",
    -- events = {"InsertLeave", "TextChanged"},
    -- conditions = {
    --   exists = true,
    --   filename_is_not = {},
    --   filetype_is_not = {},
    --   modifiable = true
    -- },
    -- write_all_buffers = false,
    -- on_off_commands = true,
    -- clean_command_line_interval = 0,
    -- debounce_delay = 135,
    -- Custom write function to avoid triggering formatters
    write_fn = function()
      local buf = vim.api.nvim_get_current_buf()
      -- Save the buffer without triggering formatters
      vim.api.nvim_buf_call(buf, function()
        vim.cmd('noautocmd w')
      end)
    end,
  })
end
