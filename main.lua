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
    box2 = Box(600, 300)

    objects = {}
    table.insert(objects, player)
    --table.insert(objects, wall)
    table.insert(objects, box)
    table.insert(objects, box2)

    walls = {}

    map = {
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
    }

    for i,v in ipairs(map) do
        for j,w in ipairs(v) do
            if w == 1 then
                table.insert(walls, Wall((j-1)*50, (i-1)*50))
            end
        end
    end
end

function love.keypressed(key)
    if key == "up" then
        player:jump()
    end
end

function love.update(dt)
    --update all objects (player, wall, box...)
    for i,v in ipairs(objects) do
        v:update(dt)
    end

    for i,v in ipairs(walls) do
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

        for i,wall in ipairs(walls) do
            for j,object in ipairs(objects) do
                local collision = object:resolveCollision(wall)
                if collision then
                    loop = true
                end
            end
        end
    end
end

function love.draw()
    for i,v in ipairs(objects) do
        v:draw()
    end

    for i,v in ipairs(walls) do
        v:draw()
    end
end