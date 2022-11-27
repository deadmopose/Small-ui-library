-- Setup

makefolder("small_library")


-- Variables

local players = game:GetService("Players")
local tween_service = game:GetService("TweenService")
local user_input_service = game:GetService("UserInputService")
local http_service = game:GetService('HttpService')
local core_gui = game:GetService("CoreGui")

local local_player = players.LocalPlayer

local mouse = local_player:GetMouse()

local color_schemes = {
	white_orange = {
		header_color = Color3.fromRGB(45, 49, 66),
		mid_color = Color3.fromRGB(191, 192, 192),
		hover_color = Color3.fromRGB(45, 49, 66),
		standard_color = Color3.fromRGB(79, 93, 117),
		enabled_color = Color3.fromRGB(239, 131, 84),
		scroll_bar_color = Color3.fromRGB(0, 0, 0),
		text_labels_color = Color3.fromRGB(255, 255, 255),
		background_color = Color3.fromRGB(255, 255, 255)
	}
}

local color_scheme = color_schemes.white_orange






-- Setup window

local function create_window(window_info)
	-- Variables

	local self = {}

	self.tab_buttons_locked = false

	self.window_name = math.random(1, 3e8)





	-- Setup

	if isfile("small_library/last_window_name" .. "_" .. local_player.Name .. ".txt") then
		-- Variables

		local last_window_name = readfile("small_library/last_window_name" .. "_" .. local_player.Name .. ".txt")



		if core_gui:FindFirstChild(last_window_name) and last_window_name ~= self.window_name then
			core_gui[last_window_name]:Destroy()
		end
	end



	writefile("small_library/last_window_name" .. "_" .. local_player.Name .. ".txt", http_service:JSONEncode(self.window_name))






	-- Create instances

	self.small = Instance.new("ScreenGui")

	self.holder = Instance.new("Frame")
	self.TextLabel = Instance.new("TextLabel")
	local ui_corner = Instance.new("UICorner")

	self.tabs_frame = Instance.new("Frame")
	self.tabs_scrolling_frame = Instance.new("ScrollingFrame")
	local UICorner = Instance.new("UICorner")
	local UIListLayout = Instance.new("UIListLayout")

	self.frame = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")





	-- Properties

	self.small.Name = self.window_name
	self.small.DisplayOrder = 3e8
	self.small.ResetOnSpawn = false
	self.small.Parent = local_player.PlayerGui

	if syn and syn.protect_gui then
		syn.protect_gui(self.small)
	end


	self.holder.BackgroundColor3 = color_scheme.header_color
	self.holder.BorderSizePixel = 0
	self.holder.Position = UDim2.new(0.235937506, 0, 0.150925919, 0)
	self.holder.Size = UDim2.new(0, 470, 0, 32)
	self.holder.ZIndex = 2
	self.holder.Parent = self.small

	self.TextLabel.BackgroundTransparency = 1.000
	self.TextLabel.Position = UDim2.new(0.0189541429, 0, 0.14257431, 0)
	self.TextLabel.Size = UDim2.new(0, 255, 0, 21)
	self.TextLabel.ZIndex = 2
	self.TextLabel.Font = Enum.Font.Gotham
	self.TextLabel.Text = window_info or "small"
	self.TextLabel.TextColor3 = color_scheme.text_labels_color
	self.TextLabel.TextScaled = true
	self.TextLabel.TextSize = 14.000
	self.TextLabel.TextWrapped = true
	self.TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	self.TextLabel.Parent = self.holder

	ui_corner.Parent = self.holder




	self.tabs_frame.BackgroundColor3 = color_scheme.mid_color
	self.tabs_frame.BorderSizePixel = 0
	self.tabs_frame.Size = UDim2.new(0, 163, 0, 291)
	self.tabs_frame.Parent = self.holder

	UICorner.Parent = self.tabs_frame

	self.tabs_scrolling_frame.Active = true
	self.tabs_scrolling_frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.tabs_scrolling_frame.BackgroundTransparency = 1.000
	self.tabs_scrolling_frame.BorderColor3 = Color3.fromRGB(27, 42, 53)
	self.tabs_scrolling_frame.BorderSizePixel = 0
	self.tabs_scrolling_frame.Position = UDim2.new(0, 0, 0.134020612, 0)
	self.tabs_scrolling_frame.Size = UDim2.new(1, 0, 0, 252)
	self.tabs_scrolling_frame.ScrollBarThickness = 4
	self.tabs_scrolling_frame.ScrollBarImageColor3 = color_scheme.scroll_bar_color
	self.tabs_scrolling_frame.CanvasSize = UDim2.fromOffset(0, 0)
	self.tabs_scrolling_frame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
	self.tabs_scrolling_frame.Parent = self.tabs_frame

	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 8)
	UIListLayout.Parent = self.tabs_scrolling_frame




	self.frame.BackgroundColor3 = color_scheme.background_color
	self.frame.BorderSizePixel = 0
	self.frame.Size = UDim2.new(0, 470, 0, 291)
	self.frame.ZIndex = 0
	self.frame.Parent = self.holder

	UICorner_2.Parent = self.frame






	-- Connections

	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		self.tabs_scrolling_frame.CanvasSize = UDim2.fromOffset(0, 0)
		
		
		if not self.tab_buttons_locked and self.tabs_scrolling_frame.Visible then
			self.tabs_scrolling_frame.Size = UDim2.new(1, 0, 0, math.clamp(UIListLayout.AbsoluteContentSize.Y, 0, 252))
		end
	end)
	
	
	

	self.holder.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputState == Enum.UserInputState.Begin then
			-- Variables

			local frame_start_position = self.holder.Position


			-- Connections

			local move_connection = mouse.Move:Connect(function()
				local delta = UDim2.fromOffset(mouse.X - input.Position.X, mouse.Y - input.Position.Y)

				tween_service:Create(self.holder, TweenInfo.new(0.04, Enum.EasingStyle.Linear), {Position = frame_start_position + delta}):Play()
			end)


			-- Disconnect

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					move_connection:Disconnect()
				end
			end)
		end
	end)





	return self
end



-- Set window

local window = create_window()





-- Window functions

function window:new_tab(tab_info)
	-- Variables

	local tab_functions = {}




	-- Functions

	local function button_animation(button)
		-- Variables

		local original_size_x = button.Size.X.Offset




		tween_service:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {Size = UDim2.fromOffset(0, button.Size.Y.Offset)}):Play()

		tween_service:Create(button.TextLabel, TweenInfo.new(0.05, Enum.EasingStyle.Sine), {TextTransparency = 1}):Play()


		task.delay(0.3, function()
			tween_service:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {Size = UDim2.fromOffset(original_size_x, button.Size.Y.Offset)}):Play()

			tween_service:Create(button.TextLabel, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {TextTransparency = 0}):Play()
		end)
	end


	local function connect_hover_effect(hover_on_frame, frame_to_color)
		hover_on_frame.MouseEnter:Connect(function()
			if not frame_to_color:GetAttribute("hover_effect_locked") then
				tween_service:Create(frame_to_color, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {BackgroundColor3 = frame_to_color:GetAttribute("hover_color")}):Play()
			end
		end)

		hover_on_frame.MouseLeave:Connect(function()
			if not frame_to_color:GetAttribute("hover_effect_locked") then
				tween_service:Create(frame_to_color, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {BackgroundColor3 = frame_to_color:GetAttribute("color")}):Play()
			end
		end)
	end





	-- Create instances

	local ScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")

	local button = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local TextLabel = Instance.new("TextLabel")





	-- Properties


	ScrollingFrame.Active = true
	ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingFrame.BackgroundTransparency = 1.000
	ScrollingFrame.BorderColor3 = Color3.fromRGB(27, 42, 53)
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Position = UDim2.new(0.347, 0, 0.134020612, 0)
	ScrollingFrame.Size = UDim2.new(0, 307, 0, 0)
	ScrollingFrame.ScrollBarImageColor3 = color_scheme.scroll_bar_color
	ScrollingFrame.ScrollBarThickness = 7
	ScrollingFrame.Visible = false
	ScrollingFrame.CanvasSize = UDim2.fromOffset(0, 0)
	ScrollingFrame.Parent = self.frame

	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 8)
	UIListLayout.Parent = ScrollingFrame




	button.BackgroundColor3 = color_scheme.standard_color
	button.Position = UDim2.new(0.0460122712, 0, 0, 0)
	button.Size = UDim2.new(0, 152, 0, 30)
	button.Parent = self.tabs_scrolling_frame
	button:SetAttribute("color", button.BackgroundColor3)
	button:SetAttribute("hover_color", color_scheme.hover_color)

	connect_hover_effect(button, button)


	UICorner.Parent = button

	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.Position = UDim2.new(0, 0, 0.150000006, 0)
	TextLabel.Size = UDim2.new(1, 0, 0.699999988, 0)
	TextLabel.ZIndex = 2
	TextLabel.Font = Enum.Font.Gotham
	TextLabel.Text = tab_info or "small"
	TextLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
	TextLabel.TextScaled = true
	TextLabel.TextSize = 14.000
	TextLabel.TextWrapped = true
	TextLabel.Parent = button




	-- Connections

	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if UIListLayout.AbsoluteContentSize.Y > 252 then
			ScrollingFrame.CanvasSize = UDim2.fromOffset(0, UIListLayout.AbsoluteContentSize.Y + 10)
		else
			ScrollingFrame.CanvasSize = UDim2.fromOffset(0, 0)
		end


		if not self.tab_buttons_locked and ScrollingFrame.Visible then
			ScrollingFrame.Size = UDim2.fromOffset(ScrollingFrame.Size.X.Offset, math.clamp(UIListLayout.AbsoluteContentSize.Y, 0, 252))
		end
	end)




	button.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputState == Enum.UserInputState.Begin and not self.tab_buttons_locked then
			-- Setup

			self.tab_buttons_locked = true





			-- (Open or Close) tab

			if not ScrollingFrame.Visible then
				-- Disable every tab button

				for _, v in pairs(self.tabs_scrolling_frame:GetChildren()) do
					if v:IsA("Frame") and v:GetAttribute("color") == color_scheme.enabled_color then
						v:SetAttribute("color", color_scheme.standard_color)


						tween_service:Create(v, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {BackgroundColor3 = color_scheme.standard_color}):Play()
					end
				end



				-- Enable tab button

				button:SetAttribute("color", color_scheme.enabled_color)


				tween_service:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {BackgroundColor3 = color_scheme.enabled_color}):Play()




				-- Close all scrolling frames

				for _, v in pairs(self.frame:GetChildren()) do
					if v:IsA("ScrollingFrame") and v.Visible then
						tween_service:Create(v, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {Size = UDim2.fromOffset(v.Size.X.Offset, 0)}):Play()


						task.delay(0.3, function()
							v.Visible = false
						end)
					end
				end




				-- Open scrolling frame

				task.delay(0.3, function()
					ScrollingFrame.Visible = true

					tween_service:Create(ScrollingFrame, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {Size = UDim2.fromOffset(ScrollingFrame.Size.X.Offset, math.clamp(UIListLayout.AbsoluteContentSize.Y + 10, 0, 252))}):Play()
				end)
			else
				-- Disable tab button

				button:SetAttribute("color", color_scheme.standard_color)


				tween_service:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {BackgroundColor3 = color_scheme.standard_color}):Play()



				-- Close scrolling frame

				tween_service:Create(ScrollingFrame, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {Size = UDim2.fromOffset(ScrollingFrame.Size.X.Offset, 0)}):Play()


				task.delay(0.3, function()
					ScrollingFrame.Visible = false
				end)
			end




			-- Button animation

			button_animation(button)



			-- Debounce end

			task.delay(0.6, function()
				self.tab_buttons_locked = false
			end)
		end
	end)






	-- Functions

	function tab_functions.new_section(section_info)
		-- Variables

		local section_functions = {}

		local section_button_busy = false

		local auto_resize_enabled = false




		-- Create instances

		local section_button = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local TextLabel = Instance.new("TextLabel")
		local ImageButton = Instance.new("ImageButton")

		local section_content = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local Frame = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")




		-- Properties

		section_button.BackgroundColor3 = color_scheme.standard_color
		section_button.Position = UDim2.new(0.0374592841, 0, 0, 0)
		section_button.Size = UDim2.new(0, 295, 0, 34)
		section_button.Parent = ScrollingFrame
		section_button:SetAttribute("color", button.BackgroundColor3)
		section_button:SetAttribute("hover_color", color_scheme.hover_color)

		connect_hover_effect(section_button, section_button)


		UICorner.Parent = section_button

		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.Position = UDim2.new(0.0281690136, 0, 0.220999822, 0)
		TextLabel.Size = UDim2.new(0.971830964, 0, 0.558000088, 0)
		TextLabel.ZIndex = 2
		TextLabel.Font = Enum.Font.Gotham
		TextLabel.Text = section_info
		TextLabel.TextColor3 = color_scheme.text_labels_color
		TextLabel.TextScaled = true
		TextLabel.TextSize = 14.000
		TextLabel.TextWrapped = true
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel.Parent = section_button

		ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageButton.BackgroundTransparency = 1.000
		ImageButton.BorderSizePixel = 0
		ImageButton.Position = UDim2.new(0.899999976, 0, 0.125, 0)
		ImageButton.Size = UDim2.new(0.0850000009, 0, 0.75, 0)
		ImageButton.ZIndex = 2
		ImageButton.Image = "rbxassetid://3926305904"
		ImageButton.ImageRectOffset = Vector2.new(404, 283)
		ImageButton.ImageRectSize = Vector2.new(36, 36)
		ImageButton.ImageColor3 = color_scheme.text_labels_color
		ImageButton.Parent = section_button




		section_content.BackgroundColor3 = color_scheme.mid_color
		section_content.Position = UDim2.new(0.0195439737, 0, -1.14285719, 0)
		section_content.Size = UDim2.new(0, 295, 0, 0)
		section_content.Visible = false
		section_content.BorderSizePixel = 0
		section_content.ClipsDescendants = true
		section_content.Parent = ScrollingFrame

		UICorner_2.CornerRadius = UDim.new(0, 5)
		UICorner_2.Parent = section_content

		Frame.BackgroundTransparency = 1.000
		Frame.Position = UDim2.new(0.00999999978, 0, 0, 6)
		Frame.Size = UDim2.new(0.980000019, 0, 1, 0)
		Frame.Parent = section_content

		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 8)
		UIListLayout.Parent = Frame



		-- Connections

		UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			if not section_button_busy and section_content.Visible then
				section_content.Size = UDim2.fromOffset(section_content.Size.X.Offset, UIListLayout.AbsoluteContentSize.Y + 12)
			end
		end)




		section_button.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputState == Enum.UserInputState.Begin and not section_button_busy then
				-- Setup

				section_button_busy = true



				-- Variables

				local speed = math.clamp(0.25 * (UIListLayout.AbsoluteContentSize.Y / 210), 0, 1.5)




				-- (Open or Close) section

				if not section_content.Visible then
					section_content.Visible = true


					tween_service:Create(section_content, TweenInfo.new(speed, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(section_content.Size.X.Offset, UIListLayout.AbsoluteContentSize.Y + 12)}):Play()

					tween_service:Create(ImageButton, TweenInfo.new(speed, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Rotation = 180}):Play()
				else
					tween_service:Create(section_content, TweenInfo.new(speed, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(section_content.Size.X.Offset, 0)}):Play()

					tween_service:Create(ImageButton, TweenInfo.new(speed, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Rotation = 0}):Play()


					task.delay(speed, function()
						section_content.Visible = false
					end)
				end




				-- Debounce end

				task.delay(speed, function()
					section_button_busy = false	
				end)
			end
		end)





		-- Functions

		function section_functions.new_button(button_info, callback)
			-- Variables

			local button_busy = false


			-- Create instances

			local button = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")




			-- Properties

			button.BackgroundColor3 = color_scheme.standard_color
			button.Position = UDim2.new(0.0278449934, 0, 0.940730989, 0)
			button.Size = UDim2.new(0, 284, 0, 26)
			button.Parent = Frame
			button:SetAttribute("color", button.BackgroundColor3)
			button:SetAttribute("hover_color", color_scheme.hover_color)

			connect_hover_effect(button, button)


			UICorner.Parent = button

			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.Position = UDim2.new(0, 0, 0.150000006, 0)
			TextLabel.Size = UDim2.new(1, 0, 0.699999988, 0)
			TextLabel.ZIndex = 2
			TextLabel.Font = Enum.Font.Gotham
			TextLabel.Text = button_info
			TextLabel.TextColor3 = color_scheme.text_labels_color
			TextLabel.TextScaled = true
			TextLabel.TextSize = 14.000
			TextLabel.TextWrapped = true
			TextLabel.Parent = button



			-- Connections

			button.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputState == Enum.UserInputState.Begin and not button_busy then
					-- Setup

					button_busy = true


					-- Callback

					callback()


					-- Button animation

					button_animation(button)



					-- Debounce end

					task.delay(0.6, function()
						button_busy = false
					end)
				end
			end)
		end



		function section_functions.new_toggle(toggle_info, callback)
			-- Variables

			local toggle_busy = false

			local state = false


			-- Create instances

			local toggle = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")
			local disabled = Instance.new("ImageButton")
			local enabled = Instance.new("ImageButton")



			-- Properties

			toggle.BackgroundColor3 = color_scheme.standard_color
			toggle.Position = UDim2.new(0.0278449934, 0, 0.829019189, 0)
			toggle.Size = UDim2.new(0, 284, 0, 30)
			toggle.Parent = Frame
			toggle:SetAttribute("color", button.BackgroundColor3)
			toggle:SetAttribute("hover_color", color_scheme.hover_color)

			connect_hover_effect(toggle, toggle)


			UICorner.Parent = toggle

			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.Position = UDim2.new(0.0333367996, 0, 0.182999671, 0)
			TextLabel.Size = UDim2.new(0.856663227, 0, 0.633000016, 0)
			TextLabel.ZIndex = 2
			TextLabel.Font = Enum.Font.Gotham
			TextLabel.Text = toggle_info
			TextLabel.TextColor3 = color_scheme.text_labels_color
			TextLabel.TextScaled = true
			TextLabel.TextSize = 14.000
			TextLabel.TextWrapped = true
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.Parent = toggle

			disabled.BackgroundColor3 = color_scheme.text_labels_color
			disabled.BackgroundTransparency = 1.000
			disabled.BorderSizePixel = 0
			disabled.Position = UDim2.new(0.910000026, 0, 0.174999997, 0)
			disabled.Size = UDim2.new(0.074000001, 0, 0.649999976, 0)
			disabled.ZIndex = 3
			disabled.Image = "rbxassetid://3926309567"
			disabled.ImageRectOffset = Vector2.new(628, 420)
			disabled.ImageRectSize = Vector2.new(48, 48)
			disabled.Parent = toggle

			enabled.BackgroundTransparency = 1.000
			enabled.Position = UDim2.new(0.910000026, 0, 0.174999997, 0)
			enabled.Size = UDim2.new(0.074000001, 0, 0.649999976, 0)
			enabled.ImageTransparency = 1
			enabled.ZIndex = 2
			enabled.Image = "rbxassetid://3926309567"
			enabled.ImageColor3 = color_scheme.enabled_color
			enabled.ImageRectOffset = Vector2.new(784, 420)
			enabled.ImageRectSize = Vector2.new(48, 48)
			enabled.Parent = toggle



			-- Connections

			toggle.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputState == Enum.UserInputState.Begin and not toggle_busy then
					-- Setup

					toggle_busy = true


					-- Change state

					state = not state


					-- Callback

					callback(state)


					-- Stop hover

					tween_service:Create(toggle, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {BackgroundColor3 = color_scheme.standard_color}):Play()



					-- (Enable or Disable) toggle

					if enabled.ImageTransparency == 1 then
						tween_service:Create(disabled, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {ImageTransparency = 1}):Play()

						tween_service:Create(enabled, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {ImageTransparency = 0}):Play()
					else
						tween_service:Create(disabled, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {ImageTransparency = 0}):Play()

						tween_service:Create(enabled, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {ImageTransparency = 1}):Play()
					end



					-- Debounce end

					task.delay(0.3, function()
						toggle_busy = false
					end)
				end
			end)
		end



		function section_functions.new_text_box(text_box_info, callback)
			-- Create instances

			local text_box = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")
			local Frame_1 = Instance.new("Frame")
			local TextBox = Instance.new("TextBox")
			local UICorner_2 = Instance.new("UICorner")




			-- Properties

			text_box.BackgroundColor3 = color_scheme.standard_color
			text_box.Position = UDim2.new(0.0416810364, 0, 0.443395734, 0)
			text_box.Size = UDim2.new(0, 284, 0, 30)
			text_box.Parent = Frame

			UICorner.Parent = text_box

			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.Position = UDim2.new(0.0333368219, 0, 0.182999671, 0)
			TextLabel.Size = UDim2.new(0.445494711, 0, 0.633000016, 0)
			TextLabel.Font = Enum.Font.Gotham
			TextLabel.Text = text_box_info
			TextLabel.TextColor3 = color_scheme.text_labels_color
			TextLabel.TextScaled = true
			TextLabel.TextSize = 14.000
			TextLabel.TextWrapped = true
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.Parent = text_box

			Frame_1.BackgroundColor3 = color_scheme.header_color
			Frame_1.Position = UDim2.new(0.513000011, 0, 0.100000001, 0)
			Frame_1.Size = UDim2.new(0.477999985, 0, 0.800000012, 0)
			Frame_1.Parent = text_box

			TextBox.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
			TextBox.BackgroundTransparency = 1.000
			TextBox.Position = UDim2.new(0.0323472507, 0, 0.150999993, 0)
			TextBox.Size = UDim2.new(0.936999977, 0, 0.698000014, 0)
			TextBox.ClearTextOnFocus = false
			TextBox.Font = Enum.Font.Gotham
			TextBox.Text = ""
			TextBox.TextColor3 = color_scheme.text_labels_color
			TextBox.TextScaled = true
			TextBox.TextSize = 14.000
			TextBox.TextWrapped = true
			TextBox.Parent = Frame_1

			UICorner_2.CornerRadius = UDim.new(0, 10)
			UICorner_2.Parent = Frame_1




			-- Connections

			TextBox.Focused:Connect(function()
				tween_service:Create(Frame_1, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {BackgroundColor3 = color_scheme.enabled_color}):Play()
			end)


			TextBox.FocusLost:Connect(function(enter_pressed)
				if enter_pressed then
					-- Callback

					callback(TextBox.Text)


					-- Tween backgroundcolor3 back

					tween_service:Create(Frame_1, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {BackgroundColor3 = color_scheme.header_color}):Play()
				end
			end)
		end



		function section_functions.new_key_bind(key_bind_info, key, callback)
			-- Setup

			assert(key and Enum.KeyCode[key], "Incorrect key name")



			-- Variables

			local key_bind_busy = false



			-- Create instances

			local key_bind = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local key_bind_label = Instance.new("TextLabel")
			local info_label = Instance.new("TextLabel")



			-- Properties

			key_bind.BackgroundColor3 = color_scheme.standard_color
			key_bind.Position = UDim2.new(0.0278449934, 0, 0.717307389, 0)
			key_bind.Size = UDim2.new(0, 284, 0, 30)
			key_bind.Parent = Frame
			key_bind:SetAttribute("color", key_bind.BackgroundColor3)
			key_bind:SetAttribute("hover_color", color_scheme.hover_color)
			key_bind:SetAttribute("hover_effect_locked", false)

			connect_hover_effect(key_bind, key_bind)


			UICorner.Parent = key_bind

			key_bind_label.Parent = key_bind
			key_bind_label.BackgroundTransparency = 1.000
			key_bind_label.Position = UDim2.new(0.478831559, 0, 0.182999671, 0)
			key_bind_label.Size = UDim2.new(0.494135886, 0, 0.633000016, 0)
			key_bind_label.ZIndex = 2
			key_bind_label.Font = Enum.Font.Gotham
			key_bind_label.Text = key
			key_bind_label.TextColor3 = color_scheme.text_labels_color
			key_bind_label.TextScaled = true
			key_bind_label.TextSize = 14.000
			key_bind_label.TextWrapped = true
			key_bind_label.TextXAlignment = Enum.TextXAlignment.Right

			info_label.BackgroundTransparency = 1.000
			info_label.Position = UDim2.new(0.0333367996, 0, 0.182999671, 0)
			info_label.Size = UDim2.new(0.479663253, 0, 0.633000016, 0)
			info_label.ZIndex = 2
			info_label.Font = Enum.Font.Gotham
			info_label.Text = key_bind_info
			info_label.TextColor3 = color_scheme.text_labels_color
			info_label.TextScaled = true
			info_label.TextSize = 14.000
			info_label.TextWrapped = true
			info_label.TextXAlignment = Enum.TextXAlignment.Left
			info_label.Parent = key_bind



			-- Connections

			key_bind.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputState == Enum.UserInputState.Begin and not key_bind_busy then
					-- Setup

					key_bind:SetAttribute("hover_effect_locked", true)

					key_bind_busy = true


					-- Tween color

					tween_service:Create(key_bind, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {BackgroundColor3 = color_scheme.enabled_color}):Play()
				end
			end)


			user_input_service.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.Keyboard then
					if not key_bind_busy and input.KeyCode.Name == key_bind_label.Text then
						callback(key_bind_label.Text)
					elseif key_bind_busy then
						-- Set new key

						key_bind_label.Text = input.KeyCode.Name


						-- Tween color back to normal

						tween_service:Create(key_bind, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {BackgroundColor3 = color_scheme.standard_color}):Play()


						-- Debounce end

						key_bind_busy = false

						key_bind:SetAttribute("hover_effect_locked", false)
					end
				end
			end)
		end



		function section_functions.new_slider(slider_info, min_value, max_value, callback)
			-- Create instances

			local slider = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")

			local value_label = Instance.new("TextLabel")
			local info_label = Instance.new("TextLabel")

			local bar = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local fill = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")





			-- Properties

			slider.BackgroundColor3 = color_scheme.standard_color
			slider.Position = UDim2.new(0.0278449934, 0, 0.55267942, 0)
			slider.Size = UDim2.new(0, 284, 0, 48)
			slider.Parent = Frame

			UICorner.Parent = slider

			value_label.BackgroundTransparency = 1.000
			value_label.Position = UDim2.new(0.697183073, 0, 0.182999924, 0)
			value_label.Size = UDim2.new(0.275784343, 0, 0.385880917, 0)
			value_label.ZIndex = 2
			value_label.Font = Enum.Font.Gotham
			value_label.Text = min_value
			value_label.TextColor3 = color_scheme.text_labels_color
			value_label.TextScaled = true
			value_label.TextSize = 14.000
			value_label.TextWrapped = true
			value_label.TextXAlignment = Enum.TextXAlignment.Right
			value_label.Parent = slider

			info_label.BackgroundTransparency = 1.000
			info_label.Position = UDim2.new(0.0333367996, 0, 0.182999924, 0)
			info_label.Size = UDim2.new(0.63141793, 0, 0.385880917, 0)
			info_label.ZIndex = 2
			info_label.Font = Enum.Font.Gotham
			info_label.Text = slider_info
			info_label.TextColor3 = color_scheme.text_labels_color
			info_label.TextScaled = true
			info_label.TextSize = 14.000
			info_label.TextWrapped = true
			info_label.TextXAlignment = Enum.TextXAlignment.Left
			info_label.Parent = slider

			bar.BackgroundColor3 = color_scheme.header_color
			bar.BorderColor3 = Color3.fromRGB(255, 255, 255)
			bar.BorderSizePixel = 0
			bar.Position = UDim2.new(0.0333369859, 0, 0.699999809, 0)
			bar.Size = UDim2.new(0.93963027, 0, 0.115000002, 0)
			bar.ZIndex = 2
			bar.Parent = slider

			UICorner_2.CornerRadius = UDim.new(0, 100)
			UICorner_2.Parent = bar

			fill.BackgroundColor3 = color_scheme.enabled_color
			fill.BorderColor3 = Color3.fromRGB(255, 255, 255)
			fill.BorderSizePixel = 0
			fill.Size = UDim2.new(0, 0, 1, 0)
			fill.ZIndex = 2
			fill.Parent = bar

			UICorner_3.CornerRadius = UDim.new(0, 100)
			UICorner_3.Parent = fill



			-- Functions

			local function fill_1()
				-- Variables

				local delta = math.clamp((mouse.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)


				-- Callback

				callback(math.clamp(delta * max_value, min_value, max_value))


				-- Change value

				value_label.Text = math.ceil(delta * max_value)


				-- Fill

				tween_service:Create(fill, TweenInfo.new(0.04, Enum.EasingStyle.Linear), {Size = UDim2.fromScale(delta, 1)}):Play()
			end



			-- Connections

			bar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputState == Enum.UserInputState.Begin then
					-- Setup

					fill_1()


					-- Connections

					local move_connection = mouse.Move:Connect(function()
						fill_1()
					end)


					-- Disconnect

					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							move_connection:Disconnect()
						end
					end)
				end
			end)
		end



		function section_functions.new_dropdown(dropdown_info, array, callback)
			-- Variables

			local dropdown_busy = false

			local selected_element




			-- Create instances

			local dropdown_button = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")
			local ImageButton = Instance.new("ImageButton")

			local dropdown_content = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local UIPadding = Instance.new("UIPadding")
			local UIListLayout = Instance.new("UIListLayout")



			-- Properties

			dropdown_button.BackgroundColor3 = color_scheme.standard_color
			dropdown_button.Position = UDim2.new(-0.0102041233, 0, 0, 0)
			dropdown_button.Size = UDim2.new(0, 284, 0, 26)
			dropdown_button.Parent = Frame
			dropdown_button:SetAttribute("color", dropdown_button.BackgroundColor3)
			dropdown_button:SetAttribute("hover_color", color_scheme.hover_color)

			connect_hover_effect(dropdown_button, dropdown_button)


			UICorner.Parent = dropdown_button

			TextLabel.BackgroundTransparency = 1.000
			TextLabel.Position = UDim2.new(0.0281690136, 0, 0.149999768, 0)
			TextLabel.Size = UDim2.new(0.871830881, 0, 0.699999928, 0)
			TextLabel.ZIndex = 2
			TextLabel.Font = Enum.Font.Gotham
			TextLabel.Text = dropdown_info
			TextLabel.TextColor3 = color_scheme.text_labels_color
			TextLabel.TextScaled = true
			TextLabel.TextSize = 14.000
			TextLabel.TextWrapped = true
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.Parent = dropdown_button

			ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageButton.BackgroundTransparency = 1.000
			ImageButton.BorderSizePixel = 0
			ImageButton.Position = UDim2.new(0.899999976, 0, 0, 0)
			ImageButton.Size = UDim2.new(0.0939999968, 0, 0.99999994, 0)
			ImageButton.ZIndex = 2
			ImageButton.Image = "rbxassetid://3926305904"
			ImageButton.ImageRectOffset = Vector2.new(404, 283)
			ImageButton.ImageColor3 =  color_scheme.text_labels_color
			ImageButton.ImageRectSize = Vector2.new(36, 36)
			ImageButton.Parent = dropdown_button




			dropdown_content.BackgroundColor3 = color_scheme.header_color
			dropdown_content.Position = UDim2.new(0.0278449934, 0, 0.099952668, 0)
			dropdown_content.Size = UDim2.new(0, 284, 0, 0)
			dropdown_content.ClipsDescendants = true
			dropdown_content.Visible = false
			dropdown_content.Parent = Frame

			UICorner_2.CornerRadius = UDim.new(0, 5)
			UICorner_2.Parent = dropdown_content

			UIPadding.PaddingTop = UDim.new(0, 5)
			UIPadding.Parent = dropdown_content

			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 5)
			UIListLayout.Parent = dropdown_content





			-- Functions

			local function change_state(state)
				-- Setup

				dropdown_busy = true


				-- Variables

				local speed = math.clamp(0.25 * (UIListLayout.AbsoluteContentSize.Y / 108), 0, 0.75)


				-- (Open or Close) dropdown				

				if not state then
					tween_service:Create(dropdown_content, TweenInfo.new(speed, Enum.EasingStyle.Sine), {Size = UDim2.fromOffset(dropdown_content.Size.X.Offset, 0)}):Play()

					tween_service:Create(ImageButton, TweenInfo.new(speed, Enum.EasingStyle.Sine), {Rotation = 0}):Play()


					task.delay(speed, function()
						dropdown_content.Visible = false


						-- Delete all buttons

						for _, v in pairs(dropdown_content:GetChildren()) do
							if v:IsA("Frame") then
								v:Destroy()
							end
						end
					end)
				else
					dropdown_content.Visible = true


					tween_service:Create(dropdown_content, TweenInfo.new(speed, Enum.EasingStyle.Sine), {Size = UDim2.fromOffset(dropdown_content.Size.X.Offset, UIListLayout.AbsoluteContentSize.Y + 10)}):Play()

					tween_service:Create(ImageButton, TweenInfo.new(speed, Enum.EasingStyle.Sine), {Rotation = 180}):Play()
				end



				-- Debounce end

				task.delay(speed, function()
					dropdown_busy = false	
				end)
			end


			local function add_buttons(array)
				for _, v in pairs(array) do
					-- Create instances

					local button = Instance.new("Frame")
					local UICorner_2 = Instance.new("UICorner")
					local TextLabel = Instance.new("TextLabel")



					-- Properties

					button.BackgroundColor3 = selected_element == v and color_scheme.enabled_color or color_scheme.standard_color
					button.Position = UDim2.new(0.0334507041, 0, 0, 0)
					button.Size = UDim2.new(0, 276, 0, 23)
					button.BorderSizePixel = 0
					button.Parent = dropdown_content
					button:SetAttribute("color", button.BackgroundColor3)
					button:SetAttribute("hover_color", color_scheme.hover_color)

					connect_hover_effect(button, button)


					UICorner_2.CornerRadius = UDim.new(0, 5)
					UICorner_2.Parent = button

					TextLabel.BackgroundTransparency = 1.000
					TextLabel.Position = UDim2.new(0, 0, 0.150000006, 0)
					TextLabel.Size = UDim2.new(1, 0, 0.699999988, 0)
					TextLabel.ZIndex = 2
					TextLabel.Font = Enum.Font.Gotham
					TextLabel.Text = v
					TextLabel.TextColor3 = color_scheme.text_labels_color
					TextLabel.TextScaled = true
					TextLabel.TextSize = 14.000
					TextLabel.TextWrapped = true
					TextLabel.Parent = button



					-- Connections

					button.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputState == Enum.UserInputState.Begin and not dropdown_busy then
							-- Disable past selected element

							if selected_element and v ~= selected_element then
								for _, v in pairs(dropdown_content:GetChildren()) do
									if v:IsA("Frame") and v.TextLabel.Text == tostring(selected_element) then
										v:SetAttribute("hover_effect_locked", true)

										tween_service:Create(v, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {BackgroundColor3 = color_scheme.standard_color}):Play()
									end
								end
							end


							-- Setup

							button:SetAttribute("hover_effect_locked", true)

							selected_element = v ~= selected_element and v or nil


							-- Callback and stuff

							callback(selected_element)

							change_state(false)
						end
					end)
				end
			end





			-- Connections

			dropdown_button.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputState == Enum.UserInputState.Begin and not dropdown_busy then
					if not dropdown_content.Visible then
						add_buttons(type(array) == "function" and array() or array)
					end


					change_state(not dropdown_content.Visible)
				end
			end)
		end



		function section_functions.new_dropdown2(dropdown_info, array, callback)
			-- Variables

			local dropdown_busy = false

			local selected_elements = {}




			-- Create instances

			local dropdown_button = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")
			local ImageButton = Instance.new("ImageButton")

			local dropdown_content = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local UIPadding = Instance.new("UIPadding")
			local UIListLayout = Instance.new("UIListLayout")



			-- Properties

			dropdown_button.BackgroundColor3 = color_scheme.standard_color
			dropdown_button.Position = UDim2.new(-0.0102041233, 0, 0, 0)
			dropdown_button.Size = UDim2.new(0, 284, 0, 26)
			dropdown_button.Parent = Frame
			dropdown_button:SetAttribute("color", dropdown_button.BackgroundColor3)
			dropdown_button:SetAttribute("hover_color", color_scheme.hover_color)

			connect_hover_effect(dropdown_button, dropdown_button)


			UICorner.Parent = dropdown_button

			TextLabel.BackgroundTransparency = 1.000
			TextLabel.Position = UDim2.new(0.0281690136, 0, 0.149999768, 0)
			TextLabel.Size = UDim2.new(0.871830881, 0, 0.699999928, 0)
			TextLabel.ZIndex = 2
			TextLabel.Font = Enum.Font.Gotham
			TextLabel.Text = dropdown_info
			TextLabel.TextColor3 = color_scheme.text_labels_color
			TextLabel.TextScaled = true
			TextLabel.TextSize = 14.000
			TextLabel.TextWrapped = true
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.Parent = dropdown_button

			ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageButton.BackgroundTransparency = 1.000
			ImageButton.BorderSizePixel = 0
			ImageButton.Position = UDim2.new(0.899999976, 0, 0, 0)
			ImageButton.Size = UDim2.new(0.0939999968, 0, 0.99999994, 0)
			ImageButton.ZIndex = 2
			ImageButton.Image = "rbxassetid://3926305904"
			ImageButton.ImageRectOffset = Vector2.new(404, 283)
			ImageButton.ImageColor3 =  color_scheme.text_labels_color
			ImageButton.ImageRectSize = Vector2.new(36, 36)
			ImageButton.Parent = dropdown_button




			dropdown_content.BackgroundColor3 = color_scheme.header_color
			dropdown_content.Position = UDim2.new(0.0278449934, 0, 0.099952668, 0)
			dropdown_content.Size = UDim2.new(0, 284, 0, 0)
			dropdown_content.ClipsDescendants = true
			dropdown_content.Visible = false
			dropdown_content.Parent = Frame

			UICorner_2.CornerRadius = UDim.new(0, 5)
			UICorner_2.Parent = dropdown_content

			UIPadding.PaddingTop = UDim.new(0, 5)
			UIPadding.Parent = dropdown_content

			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 5)
			UIListLayout.Parent = dropdown_content





			-- Functions

			local function change_state(state)
				-- Setup

				dropdown_busy = true


				-- Variables

				local speed = math.clamp(0.25 * (UIListLayout.AbsoluteContentSize.Y / 108), 0, 0.75)


				-- (Open or Close) dropdown				

				if not state then
					tween_service:Create(dropdown_content, TweenInfo.new(speed, Enum.EasingStyle.Sine), {Size = UDim2.fromOffset(dropdown_content.Size.X.Offset, 0)}):Play()

					tween_service:Create(ImageButton, TweenInfo.new(speed, Enum.EasingStyle.Sine), {Rotation = 0}):Play()


					task.delay(speed, function()
						dropdown_content.Visible = false


						-- Delete all buttons

						for _, v in pairs(dropdown_content:GetChildren()) do
							if v:IsA("Frame") then
								v:Destroy()
							end
						end
					end)
				else
					dropdown_content.Visible = true


					tween_service:Create(dropdown_content, TweenInfo.new(speed, Enum.EasingStyle.Sine), {Size = UDim2.fromOffset(dropdown_content.Size.X.Offset, UIListLayout.AbsoluteContentSize.Y + 10)}):Play()

					tween_service:Create(ImageButton, TweenInfo.new(speed, Enum.EasingStyle.Sine), {Rotation = 180}):Play()
				end



				-- Debounce end

				task.delay(speed, function()
					dropdown_busy = false	
				end)
			end


			local function add_buttons(array)
				for i, v in pairs(array) do
					-- Create instances

					local button = Instance.new("Frame")
					local UICorner_2 = Instance.new("UICorner")
					local TextLabel = Instance.new("TextLabel")



					-- Properties

					button.BackgroundColor3 = table.find(selected_elements, v) and color_scheme.enabled_color or color_scheme.standard_color
					button.Position = UDim2.new(0.0334507041, 0, 0, 0)
					button.Size = UDim2.new(0, 276, 0, 23)
					button.BorderSizePixel = 0
					button.Parent = dropdown_content
					button:SetAttribute("color", button.BackgroundColor3)
					button:SetAttribute("hover_color", color_scheme.hover_color)

					connect_hover_effect(button, button)


					UICorner_2.CornerRadius = UDim.new(0, 5)
					UICorner_2.Parent = button

					TextLabel.BackgroundTransparency = 1.000
					TextLabel.Position = UDim2.new(0, 0, 0.150000006, 0)
					TextLabel.Size = UDim2.new(1, 0, 0.699999988, 0)
					TextLabel.ZIndex = 2
					TextLabel.Font = Enum.Font.Gotham
					TextLabel.Text = v
					TextLabel.TextColor3 = color_scheme.text_labels_color
					TextLabel.TextScaled = true
					TextLabel.TextSize = 14.000
					TextLabel.TextWrapped = true
					TextLabel.Parent = button



					-- Connections

					button.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputState == Enum.UserInputState.Begin and not dropdown_busy then
							-- (Remove or Add) selected element

							if not table.find(selected_elements, v) then
								table.insert(selected_elements, v)


								button:SetAttribute("color", color_scheme.enabled_color)

								tween_service:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {BackgroundColor3 = color_scheme.enabled_color}):Play()
							else
								table.remove(selected_elements, table.find(selected_elements, v))


								button:SetAttribute("color", color_scheme.standard_color)

								tween_service:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {BackgroundColor3 = color_scheme.standard_color}):Play()
							end



							-- Callback and stuff

							callback(selected_elements)
						end
					end)
				end
			end





			-- Connections

			dropdown_button.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputState == Enum.UserInputState.Begin and not dropdown_busy then
					if not dropdown_content.Visible then
						add_buttons(type(array) == "function" and array() or array)
					end


					change_state(not dropdown_content.Visible)
				end
			end)
		end





		return section_functions
	end





	return tab_functions
end



return window
