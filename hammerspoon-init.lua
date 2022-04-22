local winSizePrefix = {"alt", "cmd"}
local winMovePrefix = {"ctrl", "alt", "cmd"}

local leftHalf = {0, 0, 0.5, 1}
local rightHalf = {0.5, 0, 0.5, 1}
local topHalf = {0, 0, 1, 0.5}
local bottomHalf = {0, 0.5, 1, 0.5}

--- Window sizing ---

hs.hotkey.bind(winSizePrefix, "f", function()
  hs.window.focusedWindow():maximize()
end)

hs.hotkey.bind(winSizePrefix, "c", function()
  hs.window.focusedWindow():centerOnScreen()
end)

hs.hotkey.bind(winSizePrefix, "left", function()
  hs.window.focusedWindow():move(leftHalf)
end)

hs.hotkey.bind(winSizePrefix, "right", function()
  hs.window.focusedWindow():move(rightHalf)
end)

hs.hotkey.bind(winSizePrefix, "up", function()
  hs.window.focusedWindow():move(topHalf)
end)

hs.hotkey.bind(winSizePrefix, "down", function()
  hs.window.focusedWindow():move(bottomHalf)
end)

--- Window movement ---

hs.hotkey.bind(winMovePrefix, "left", function()
  hs.window.focusedWindow():moveOneScreenWest()
end)

hs.hotkey.bind(winMovePrefix, "right", function()
  hs.window.focusedWindow():moveOneScreenEast()
end)
