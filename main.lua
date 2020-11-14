--! file: main.lua

function love.load()
    Object = require "classic"
    require "entity"
    require "player"
    require "wall"
    require "box"

    player = Player(100, 100)
    wall = Wall(200, 100)
    box = Box(400, 150)

    objects = {}
    table.insert(objects, player)
    table.insert(objects, wall)
    table.insert(objects, box)
end

function love.update(dt)
    --update all objects (player, wall, box...)
    for i,v in ipairs(objects) do
        v:update(dt)
    end

    local loop = true
    local limit = 0

    while loop do
        --initial setting assumes no collisions
        loop = false

        limit = limit + 1
        if limit > 100 then
            --prevent infinite caca
            break
        end

        --check each object for a collision by checking the object next to it
        --a simple double for loop would also check the object with itself,
        --wasting computation
        for i=1,#objects-1 do
            for j=i+1,#objects do
                local collision = objects[i]:resolveCollision(objects[j])
                if collision then
                    loop = true
                end
            end
        end
    end
end

function love.draw()
    --player:draw()
    --wall:draw()
    for i,v in ipairs(objects) do
        v:draw()
    end
end