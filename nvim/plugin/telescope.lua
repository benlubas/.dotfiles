local ts = require('telescope')

ts.setup {
  pickers = {
    find_files = {
      hidden = true
    }
  }
}

ts.load_extension('neoclip')
