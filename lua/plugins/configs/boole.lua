require('boole').setup({
  mappings = {
    increment = '<C-a>',
    decrement = '<C-x>'
  },
  -- User defined loops
  additions = {
    {'true', 'false'},
    -- Examples
    -- {'Foo', 'Bar'},
    -- {'tic', 'tac', 'toe'}
  },
  allow_caps_additions = {
    {'increment', 'decrement'},
    {'enable', 'disable'},
    -- enable → disable
    -- Enable → Disable
    -- ENABLE → DISABLE
  }
})
