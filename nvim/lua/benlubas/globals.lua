-- prints and returns the thing as a string
P = function(...)
  local thing = nil
  for _, v in ipairs({...}) do
    if thing == nil then
      thing = v
    end
    print(vim.inspect(v))
  end
  return thing
end

-- reloads the given modules.
R = function(...)
  return require("plenary.reload").reload_module(...)
end

IsLinux = function()
  return jit.os == "Linux"
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
