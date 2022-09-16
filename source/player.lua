import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics

class('Player').extends(gfx.sprite)

import "obstacle"

local xVel = 0
local yVel = 0
local accel = 0

local yOffset = 210

local flySpeed = 10
local speed = 1

function Player:init()
    local playerImage = gfx.image.new("images/ship")
    self:setImage(playerImage)
    self:setCollideRect(0, 0, self:getSize())

    self.x = 200
    self.y = 210
    self:moveTo(self.x, self.y)
end

function Player:update()
    if not gameStopped then
        Player.super.update(self)

        if playdate.buttonIsPressed(playdate.kButtonLeft) then
            accel = -speed
        elseif playdate.buttonIsPressed(playdate.kButtonRight) then
            accel = speed
        end

        xVel = xVel + accel
        yVel = -flySpeed

        self.x = self.x + xVel
        self.y = self.y + yVel

        if self.x < 0 or self.x > 400 then
            self.x = self.x - xVel
            xVel = 0
            gameover()
        end
        
        self:moveWithCollisions(self.x, self.y)

        gfx.setDrawOffset(0, -math.floor(self.y) + yOffset)
    end
end

function Player:collisionResponse(other)
    if other:isa(Obstacle) then
        gameover()
    end
    return 'overlap'
end