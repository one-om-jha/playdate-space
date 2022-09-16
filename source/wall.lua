import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics

class('Wall').extends(gfx.sprite)

function Wall:init(x)
    self:setCenter(0, 0)
    self:setSize(16, 480)
    self:moveTo(x, -120)
end

function Wall:draw()
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0, 0, self:getSize())
end

function Wall:update()
    if not gameStopped then
        Wall.super.update(self)

        local moveY = -120 - drawOffsetY
        self:moveTo(self.x, moveY)
    end
end