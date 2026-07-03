package.path = package.path .. ";/savedata0/?.lua"
Menu = require("menu")

Songs = {}

local function play(n)
	Menu.selected = Songs[n]
	Menu.selected_i = n
	Menu.selected:play()
end

local function play_or_toggle()
	if Menu.selected ~= nil then
		if Menu.i == Menu.selected_i then
			if Menu.selected:isPlaying() then
				Menu.selected:pause()
			end
			if Menu.selected:isPaused() then
				Menu.selected:resume()
			end
			return
		end
		if Menu.selected:isPlaying() then
			Menu.selected:stop()
		end
	end
	play(Menu.i)
end

local function stop_and_play(n)
	if Menu.selected ~= nil then
		Menu.selected:stop()
		play(n)
	end
end

local gpd = love.gamepadpressed
function love.gamepadpressed(joystick, button)
	gpd(joystick, button)
	if button == "leftstick" then
		Menu.display = not Menu.display
	end
	if Menu.display and #Menu.items > 0 then
		if button == "dpup" then
			Menu.i = Menu.dec(Menu.i)
		elseif button == "dpdown" then
			Menu.i = Menu.inc(Menu.i)
		elseif button == "dpleft" then
			local n = Menu.dec(Menu.selected_i)
			stop_and_play(n)
		elseif button == "dpright" then
			local n = Menu.inc(Menu.selected_i)
			stop_and_play(n)
		elseif button == "rightstick" then
			play_or_toggle()
		end
	end
end

local u = love.update
function love.update(dt)
	u(dt)
	if Menu.selected ~= nil then
		if Menu.selected:isStopped() then
			local n = Menu.inc(Menu.selected_i)
			play(n)
		end
	end
end

local d = love.draw
function love.draw()
	d()
	Menu.draw()
end

local function main()
	local items = love.filesystem.getDirectoryItems(".")
	for _, item in ipairs(items) do
		if item:match("^.+%.(.+)$") == "ogg" then
			Menu.append(item)
			local song = love.audio.newSource(item, "stream")
			table.insert(Songs, song)
		end
	end
end

main()

return {
	["version"] = "1.0.1o-FULL",
	["paused"] = false,
	["QUEUED_CHANGE"] = {},
	["COMP"] = { ["prev_name"] = "", ["name"] = "", ["score"] = 89775 },
	["colourblind_option"] = false,
	["play_button_pos"] = 2,
	["CUSTOM_DECK"] = {
		["Collabs"] = {
			["Spades"] = "default_Spades",
			["Hearts"] = "default_Hearts",
			["Diamonds"] = "default_Diamonds",
			["Clubs"] = "default_Clubs",
		},
	},
	["colour_palettes"] = { ["Spades"] = "lc", ["Hearts"] = "lc", ["Diamonds"] = "lc", ["Clubs"] = "lc" },
	["crashreports"] = false,
	["language"] = "en-us",
	["profile"] = 1,
	["WINDOW"] = {
		["vsync"] = 0,
		["display_names"] = { [1] = "1" },
		["screenmode"] = "Borderless",
		["DISPLAYS"] = {
			[1] = {
				["screen_resolutions"] = {
					["strings"] = { [1] = "1280 X 800" },
					["values"] = { [1] = { ["w"] = 1280, ["h"] = 800 } },
				},
				["screen_res"] = { ["w"] = 1920, ["h"] = 1080 },
				["DPI_scale"] = 1,
				["MONITOR_DIMS"] = { ["height"] = 800, ["width"] = 1280 },
			},
		},
		["selected_display"] = 1,
	},
	["run_stake_stickers"] = false,
	["GAMESPEED"] = 4,
	["SOUND"] = { ["volume"] = 50, ["music_volume"] = 100, ["game_sounds_volume"] = 100 },
	["music_control"] = { ["current_track"] = "", ["desired_track"] = "", ["lerp"] = 1 },
	["ACHIEVEMENTS_EARNED"] = {
		["legendary"] = true,
		["ante_upper"] = true,
		["heads_up"] = true,
		["retrograde"] = true,
		["ante_up"] = true,
		["_10k"] = true,
	},
	["screenshake"] = 50,
	["current_setup"] = "New Run",
	["tutorial_complete"] = true,
	["ambient_control"] = {
		["ambientFire1"] = { ["per"] = 1.1, ["vol"] = 0 },
		["ambientOrgan1"] = { ["per"] = 0.7, ["vol"] = 0 },
		["ambientFire2"] = { ["per"] = 1.05, ["vol"] = 0 },
		["ambientFire3"] = { ["per"] = 1, ["vol"] = 0 },
	},
	["DEMO"] = {
		["win_CTA_shown"] = true,
		["quit_CTA_shown"] = true,
		["timed_CTA_shown"] = true,
		["total_uptime"] = 20.73529185452,
	},
	["GRAPHICS"] = { ["texture_scaling"] = 2, ["crt"] = 15.310682565075, ["shadows"] = "On", ["bloom"] = 1 },
}
