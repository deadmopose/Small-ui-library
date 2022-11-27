# Creating a window

```lua
local window = loadstring(game:HttpGet("https://raw.githubusercontent.com/deadmopose/Small-ui-library/main/Script.lua"))("example_window_name")
```

# Creating a tab

```lua
local tab = window:new_tab("tab_name")
```

# Creating a section

```lua
local section = tab.new_section("section_name")
```

# Creating elements

```lua
section.new_button("button_info", function()
    -- Something
end)

section.new_toggle("toggle_info", function(state)
    -- Something
end)

section.new_text_box("text_box_info", function(value)
    -- Something
end)

section.new_key_bind("key_bind_info" , "RightControl", function(value)
    -- Something
end)

section.new_slider("slider_info", 0, 100, function(value)
    -- Something
end)

section.new_dropdown("dropdown_info", {1, 2, 3}, function(value)
    -- Something
end)

section.new_dropdown2("dropdown2_info", {1, 2, 3}, function(value)
    -- Something
end)
```

# Example of use

```lua
local window = loadstring(game:HttpGet("https://raw.githubusercontent.com/deadmopose/Small-ui-library/main/Script.lua"))("example_window_name")

local tab = window:new_tab("tab_name")

local section = tab.new_section("section_name")


section.new_toggle("Info", function(state)
    print("New state: " .. tostring(state))
end)
```

# Dropdown auto update use example

```lua
local function get_table()
    return {1, 2, 3}
end

section.new_dropdown("Info", get_table, function(value) -- Put function that returns a table instead of a table
    -- Something
end)
```

# Customizing the color scheme example

```lua
getgenv().color_schemes = {
	white_orange = { -- Original
		header_color = Color3.fromRGB(45, 49, 66),
		mid_color = Color3.fromRGB(191, 192, 192),
		hover_color = Color3.fromRGB(45, 49, 66),
		standard_color = Color3.fromRGB(79, 93, 117),
		enabled_color = Color3.fromRGB(239, 131, 84),
		scroll_bar_color = Color3.fromRGB(0, 0, 0),
		text_labels_color = Color3.fromRGB(255, 255, 255),
		background_color = Color3.fromRGB(255, 255, 255)
	},
	
	custom = { -- Dark theme pog?
		header_color = Color3.fromRGB(40, 40, 40),
		mid_color = Color3.fromRGB(50, 50, 50),
		hover_color = Color3.fromRGB(40, 40, 40),
		standard_color = Color3.fromRGB(70, 70, 70),
		enabled_color = Color3.fromRGB(239, 131, 84),
		scroll_bar_color = Color3.fromRGB(255, 255, 255),
		text_labels_color = Color3.fromRGB(255, 255, 255),
		background_color = Color3.fromRGB(35, 35, 35)
	}
}

getgenv().color_scheme = getgenv().color_schemes.custom


-- Create a window with a new color scheme

local window = loadstring(game:HttpGet("https://raw.githubusercontent.com/deadmopose/Small-ui-library/main/Script.lua"))("example_window_name")
```
