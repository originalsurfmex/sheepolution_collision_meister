--! file: entity.lua

Entity = Object:extend()

function Entity:new(x, y, image_path)
    self.x = x
    self.y = y
    self.image = love.graphics.newImage(image_path)
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    --start tracking the previous locations for collisions
    self.last = {}
    self.last.x = self.x
    self.last.y = self.y

    --set a strength to figure out who pushes who in a collision
    --also a temporary strength for if a weaker object is against a "wall"
    self.strength = 0
    self.tempStrength = 0
end

function Entity:update(dt)
    self.last.x = self.x
    self.last.y = self.y

    --reset strength
    self.tempStrength = self.strength
end

function Entity:draw()
   love.graphics.draw(self.image, self.x, self.y)
end

function Entity:checkCollision(e)
    return self.x + self.width > e.x
    and self.x < e.x + e.width
    and self.y + self.height > e.y
    and self.y < e.y + e.height
end

--do some boolean checks for which collision would apply based
--on whether its colliding from the side or the top
function Entity:wasVerticallyAligned(e)
    return self.last.y < e.last.y + e.height and self.last.y + self.height > e.last.y
end
function Entity:wasHorizontallyAligned(e)
    return self.last.x < e.last.x + e.width and self.last.x + self.width > e.last.x
end

--move back to previous spot if there is a collision, filtered into whether the collision
--is from the x or z axis
function Entity:resolveCollision(e)
    --end the function if 'self' is "stronger" than the entity
    if self.strength > e.strength then
        e:resolveCollision(self)
        return
    end

    --end the function if there is a mis-balance on tempstrength
    if self.tempStrength > e.tempStrength then
        e:resolveCollision(self)
        return
    end

    if self:checkCollision(e) then
        --pass on the strength of a stronger object to a weaker object here
        self.tempStrength = e.tempStrength

        if self:wasVerticallyAligned(e) then
            if self.x + self.width/2 < e.x + e.width/2 then
                local pushback = self.x + self.width - e.x
                self.x = self.x - pushback
            else
                local pushback = e.x + e.width - self.x
                self.x = self.x + pushback
            end
        elseif self:wasHorizontallyAligned(e) then
            if self.y + self.height/2 < e.y + e.height/2 then
                local pushback = self.y + self.height - e.y
                self.y = self.y - pushback
            else
                local pushback = e.y + e.height - self.y
                self.y = self.y + pushback
            end
        end
        -- resolve the collision end the function
        return true
    end
    --instead of returning nil, if there is no collision return false
    return false
end

