-- a file with some utility functions that I'm using through out my config

M = {}

-- thanks https://stackoverflow.com/questions/9790688/escaping-strings-for-gsub
M.escape_gsub = function(s)
  return (
    s:gsub("%%", "%%%%")
      :gsub("^%^", "%%^")
      :gsub("%$$", "%%$")
      :gsub("%(", "%%(")
      :gsub("%)", "%%)")
      :gsub("%.", "%%.")
      :gsub("%[", "%%[")
      :gsub("%]", "%%]")
      :gsub("%*", "%%*")
      :gsub("%+", "%%+")
      :gsub("%-", "%%-")
      :gsub("%?", "%%?")
  )
end
