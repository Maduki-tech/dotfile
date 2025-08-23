-- Module to manage the floating window
local Floaterminal = {}

-- Variables to track the floating window and its buffer
Floaterminal.win_id = nil
Floaterminal.buf_id = nil

-- Function to toggle the floating terminal
Floaterminal.toggle = function(width_percent, height_percent)
  width_percent = width_percent or 80
  height_percent = height_percent or 80

  if Floaterminal.win_id and vim.api.nvim_win_is_valid(Floaterminal.win_id) then
    -- Close the floating window, but keep the buffer
    vim.api.nvim_win_close(Floaterminal.win_id, true)
    Floaterminal.win_id = nil
  else
    -- Reuse the buffer if it exists and is valid, otherwise create a new one
    if not Floaterminal.buf_id or not vim.api.nvim_buf_is_valid(Floaterminal.buf_id) then
      Floaterminal.buf_id = vim.api.nvim_create_buf(false, true)
    end

    -- Get the dimensions of the editor
    local width = math.floor(vim.o.columns * (width_percent / 100))
    local height = math.floor(vim.o.lines * (height_percent / 100))
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Create the floating window
    Floaterminal.win_id = vim.api.nvim_open_win(Floaterminal.buf_id, true, {
      relative = 'editor',
      width = width,
      height = height,
      row = row,
      col = col,
      style = 'minimal',
      border = 'rounded',
    })

    -- If it's the first time opening the buffer, set it up as a terminal
    if vim.fn.bufname(Floaterminal.buf_id) == '' then
      vim.fn.termopen(vim.o.shell)

      -- Terminal mode keymap to close the terminal
      vim.api.nvim_buf_set_keymap(Floaterminal.buf_id, 't', '<C-q>', '<C-\\><C-n>:Floaterminal<CR>', { noremap = true, silent = true })
    end

    -- Enter insert mode automatically
    vim.cmd 'startinsert'
  end
end

-- Create a user command to toggle the floating terminal
vim.api.nvim_create_user_command('Floaterminal', function(args)
  local width = tonumber(args.fargs[1]) or nil
  local height = tonumber(args.fargs[2]) or nil
  Floaterminal.toggle(width, height)
end, { nargs = '*' })

return Floaterminal
