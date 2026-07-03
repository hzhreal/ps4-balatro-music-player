Menu = {}
Menu.items = {}
Menu.display = false
Menu.i = 1
Menu.selected = nil
Menu.selected_i = nil

function Menu.append(...)
	local parts = {}
	for _, v in ipairs({ ... }) do
		table.insert(parts, tostring(v))
	end
	local a = table.concat(parts, " ")

	table.insert(Menu.items, a)
end

function Menu.clear()
	Menu.items = {}
end

function Menu.draw()
	if not Menu.display then
		return
	end
	if #Menu.items == 0 then
		return
	end

	local PADDING = 8
	local LINEHEIGHT = 16
	local WIDTH = 400
	local HEIGHT = PADDING * 2 + (#Menu.items * LINEHEIGHT)
	local height = math.max(HEIGHT, LINEHEIGHT + PADDING * 2)

	love.graphics.push("all")
	love.graphics.setColor(0, 0, 0, 0.6)
	love.graphics.rectangle("fill", 0, 0, WIDTH, height)

	love.graphics.setColor(1, 1, 1, 1)
	for i, item in ipairs(Menu.items) do
		if i ~= Menu.i then
			love.graphics.print(item, PADDING, PADDING + (i - 1) * LINEHEIGHT)
		end
	end
	love.graphics.setColor(0, 1, 0, 1)
	love.graphics.print(Menu.items[Menu.i], PADDING, PADDING + (Menu.i - 1) * LINEHEIGHT)
	love.graphics.pop()
end

function Menu.inc(n)
	n = n + 1
	if n == #Menu.items + 1 then
		n = 1
	end
	return n
end

function Menu.dec(n)
	n = n - 1
	if n == 0 then
		n = #Menu.items
	end
	return n
end

return Menu
