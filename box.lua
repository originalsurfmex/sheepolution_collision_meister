--! file: box.lua

Box = Entity:extend()

function Box:new(x, y)
    Box.super.new(self, x, y, "box.png")
    self.strength = 5
end

function Box:update(dt)
    --this is needed otherwise the last.x and last.y items wont work
    --since these are connected to the collisions, then tempStrength
    --also won't work without this
    Box.super.update(self, dt)
end