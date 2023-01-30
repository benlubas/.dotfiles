-- prints and returns the thing as a string
P = function(thing)
  print(vim.inspect(thing))
  return thing
end

-- reloads the given modules.
R = function(...)
  return require('plenary.reload').reload_module(...)
end
