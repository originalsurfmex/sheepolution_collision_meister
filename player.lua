--! file: player.lua

Player = Entity:extend()

function Player:new(x, y)
    Player.super.new(self, x, y, "player.png")
    self.strength = 10
end

function Player:update(dt)
    --use super to call Entity:update(dt) which is used to update
    --the self.last{} table every dt with the x and y positions
    Player.super.update(self, dt)

    if love.keyboard.isDown("left") then
        self.x = self.x - 200 * dt
    elseif love.keyboard.isDown("right") then 
        self.x = self.x + 200 * dt
    end

    if love.keyboard.isDown("up") then
        self.y = self.y - 200 * dt
    elseif love.keyboard.isDown("down") then 
        self.y = self.y + 200 * dt
    end
end