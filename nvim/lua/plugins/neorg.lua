require("neorg").setup {
  load = {
    ["core.defaults"] = {}, -- Loads default behaviour
    ["core.concealer"] = { -- Adds pretty icons to your documents
        config = {
            icon_preset = "diamond",
        },
    }, 
    ["core.dirman"] = { -- Manages Neorg workspaces
        config = {
            workspaces = {
      	        notes = "~/neorg/notes",
            },
            index = "index.norg",
            default_workspace = "notes"
        },
    },
    ["core.ui.calendar"] = {},
  },
}
