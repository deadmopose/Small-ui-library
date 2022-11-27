# Creating window

```lua
local window = loadstring(game:HttpGet("https://raw.githubusercontent.com/deadmopose/Small-ui-library/main/Script.lua"))()
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
section.new_button("Info", function()
    -- Something
end)

section.new_toggle("Info", function(state)
    -- Something
end)

section.new_text_box("Info", function(value)
    -- Something
end)

section.new_key_bind("Info" , "RightControl", function(value)
    -- Something
end)

section.new_slider("Info", 0, 100, function(value)
    -- Something
end)

section.new_dropdown("Info", {1, 2, 3}, function(value)
    -- Something
end)

section.new_dropdown2("Info", {1, 2, 3}, function(value)
    -- Something
end)
```
