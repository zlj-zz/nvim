-- theme switcher with persistence (nightfox family only)
local themes = {
	"nordfox",
	"nightfox",
	"carbonfox",
}
local default_theme = "nordfox"

local state_file = vim.fn.stdpath("state") .. "/theme.txt"

local function apply_theme(name, persist)
	vim.opt.background = "dark"
	vim.cmd.colorscheme(name)
	if persist then
		local f = io.open(state_file, "w")
		if f then
			f:write(name)
			f:close()
		end
	end
end

-- restore last theme if still in the allow-list; unknown names fall back to default
local chosen = default_theme
local f = io.open(state_file, "r")
if f then
	local saved = f:read("*l")
	f:close()
	if saved and vim.tbl_contains(themes, saved) then
		chosen = saved
	end
end
apply_theme(chosen, false)
if chosen ~= default_theme then
	vim.notify("Theme restored: " .. chosen, vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>tc", function()
	local current = vim.g.colors_name or default_theme
	for i, name in ipairs(themes) do
		if name == current then
			local next_theme = themes[i % #themes + 1]
			apply_theme(next_theme, true)
			vim.notify("Theme: " .. next_theme)
			return
		end
	end
	apply_theme(themes[1], true)
end, { desc = "Cycle colorscheme" })
