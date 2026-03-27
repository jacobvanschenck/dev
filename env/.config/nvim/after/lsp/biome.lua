return {
	single_file_support = false,
	root_dir = function(fname)
		local util = require("lspconfig.util")
		-- Prioritize .git to lock to the monorepo root
		-- If no .git is found, look for biome.json
		return util.root_pattern(".git")(fname) or util.root_pattern("biome.json", "biome.jsonc")(fname)
	end,
}
