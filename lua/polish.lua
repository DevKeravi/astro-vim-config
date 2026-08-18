-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}

-- polish.lua
-- 코드 참조 복사 함수 (수정된 버전)
local function copy_code_reference()
  local file = vim.fn.expand('%:.')
  local start_line, end_line

  -- 현재 모드 확인
  local mode = vim.api.nvim_get_mode().mode

  if mode == 'v' or mode == 'V' or mode == '' then
    -- 비주얼 모드: 선택 영역의 시작과 끝 라인
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true),
'nx', false)
    start_line = vim.fn.line("'<")
    end_line = vim.fn.line("'>")
  else
    -- 노멀 모드: 현재 커서 라인
    start_line = vim.fn.line('.')
    end_line = start_line
  end

  local reference = file .. ':' .. start_line
  if start_line ~= end_line then
    reference = reference .. '-' .. end_line
  end

  vim.fn.setreg('+', reference)
  vim.notify("Copied: " .. reference, vim.log.levels.INFO)
end

-- 키맵핑 추가
vim.keymap.set('n', '<leader>cy', copy_code_reference, {desc = "Copy code reference"})
vim.keymap.set('x', '<leader>cy', copy_code_reference, {desc = "Copy code reference"})

