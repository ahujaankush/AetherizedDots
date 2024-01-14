local notes = os.getenv "HOME" .. "/Documents/"
return {
  config = {
    workspaces = {
      default = notes .."/_Organizer",
      journal = notes .. "/_Journal",
      wiki = notes .. "/_Organizer",
    },
  },
}
