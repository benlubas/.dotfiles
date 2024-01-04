-- prints and returns the thing as a string
P = function(...)
  for _, v in ipairs({...}) do
    print(vim.inspect(v))
  end
  return ...
end

-- reloads the given modules.
R = function(...)
  return require("plenary.reload").reload_module(...)
end

Border = { "▄", "▄", "▄", "█", "▀", "▀", "▀", "█" }

IsLinux = function()
  return jit.os == "Linux"
end

MarkdownMode = function()
  return vim.g.started_by_firenvim or vim.env["MD_MODE"] == "1"
end

function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  ---@diagnostic disable-next-line: param-type-mismatch
  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end
