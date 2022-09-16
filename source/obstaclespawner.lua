import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics

class('ObstacleSpawner').extends(gfx.sprite)

import "obstacle"

local obstacleTimer = nil

local function resetTimer()
    obstacleTimer = playdate.timer.new(1000, 1000, 0, playdate.easingFunctions.linear)
end

function ObstacleSpawner:init()
    resetTimer()
end

function ObstacleSpawner:update()

    if not gameStopped then
        ObstacleSpawner.super.update(self)

        if obstacleTimer.value == 0 then
            spawnObstacle()
            resetTimer()
        end
    end
end
