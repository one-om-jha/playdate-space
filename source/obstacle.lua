import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics

class('Obstacle').extends(gfx.sprite)

function Obstacle:init(x, y)
    local obstacleImage = gfx.image.new("images/obstacle")
    self:setImage(obstacleImage)
    self:setCollideRect(0, 0, self:getSize())
    self:moveTo(x, y)
end

function Obstacle:update()
    if not gameStopped then
        Obstacle.super.update(self)

        if self.y > drawOffsetY + 480 then
            self:remove()
        end
    end
end