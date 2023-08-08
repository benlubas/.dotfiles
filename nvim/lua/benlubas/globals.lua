-- prints and returns the thing as a string
P = function(thing)
  print(vim.inspect(thing))
  return thing
end

-- reloads the given modules.
R = function(...)
  return require("plenary.reload").reload_module(...)
end

function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end
