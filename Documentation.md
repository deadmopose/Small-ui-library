# Creating window

```lua
local window = loadstring(game:HttpGet("https://raw.githubusercontent.com/deadmopose/Small-ui-library/main/Script.lua"))("example_window_name")
```

# Creating tab

```lua
local tab = window:new_tab("tab_name")
```

# Creating section

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
    print(value)
end)
```
