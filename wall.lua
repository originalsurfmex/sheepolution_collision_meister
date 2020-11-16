--! file: wall.lua

Wall = Entity:extend()

function Wall:new(x, y)
    Wall.super.new(self, x, y, "wall.png")
    self.strength = 20
    --weight 0 so it doesnt fall
    self.weight = 0
end