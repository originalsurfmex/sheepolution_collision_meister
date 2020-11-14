--! file: box.lua

Box = Entity:extend()

function Box:new(x, y)
    Box.super.new(self, x, y, "box.png")
    self.strength = 9
end