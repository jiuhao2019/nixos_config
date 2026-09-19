local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local icons_path = gears.filesystem.get_configuration_dir() .. "keybind-widget/icons/"

local keybind_icon = wibox.widget({
	widget = wibox.widget.imagebox,
	resize = true,
})

-- =========================
-- popup 内容容器
-- =========================
local rows = wibox.layout.fixed.vertical()
local ptr = 0
local max_visible = 10

rows:connect_signal("button::press", function(_, _, _, button)
	if button == 4 then
		if ptr > 0 then
			rows.children[ptr].visible = true
			ptr = ptr - 1
		end
	elseif button == 5 then
		if ptr < #rows.children and ((#rows.children - ptr) > max_visible) then
			ptr = ptr + 1
			rows.children[ptr].visible = false
		end
	end
end)

-- =========================
-- popup
-- =========================
local popup = awful.popup({
	visible = false,
	ontop = true,
	shape = gears.shape.rounded_rect,
	border_width = 1,
	border_color = "#777777",
	widget = {},
})
popup:setup({
	{
		{
			rows,
			margins = 10,
			layout = wibox.container.margin,
		},
		strategy = "exact",
		height = 800,
		width = 800,
		widget = wibox.container.constraint,
	},
	layout = wibox.container.background,
})

-- =========================
-- 点击 icon 显示 popup
-- =========================
keybind_icon:buttons(awful.util.table.join(awful.button({}, 1, function()
	popup.visible = not popup.visible
	if popup.visible then
		popup:move_next_to(_G.mouse.current_widget_geometry)
	end
end)))

local icon = "kkk1.jpeg"
keybind_icon.image = icons_path .. icon
-- =========================
-- 外部 API：更新列表内容
-- =========================
local M = {}

function M.set_items(list)
	rows:reset()

	for i, v in ipairs(list or {}) do
		local row = wibox.widget({
			{
				text = tostring(i),
				widget = wibox.widget.textbox,
			},
			{
				text = tostring(v),
				widget = wibox.widget.textbox,
			},

			layout = wibox.layout.ratio.horizontal,
		})
		-- 第一列 占0%，第2列100% 宽度
		row:ajust_ratio(2, 0.0, 1.00, 0)
		rows:add(row)
	end

	ptr = 0
	if button == 4 then
		if ptr > 0 then
			rows.children[ptr].visible = true
			ptr = ptr - 1
		end
	elseif button == 5 then
		if ptr < #rows.children and ((#rows.children - ptr) > max_visible) then
			ptr = ptr + 1
			rows.children[ptr].visible = false
		end
	end
end

return {
	widget = keybind_icon,
	set_items = M.set_items,
}
