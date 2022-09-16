import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics

import "player"
import "wall"
import "obstaclespawner"
import "obstacle"

drawOffsetX, drawOffsetY = 0, 0
gameStopped = false

local results
local resultsAnimator
local resultsY

local function initialize()
	math.randomseed(playdate.getSecondsSinceEpoch())

	local player = Player()
	player:add()

	local wallLeft = Wall(0)
	wallLeft:add()

	local wallRight = Wall(400-16)
	wallRight:add()

	local obstaclespawner = ObstacleSpawner()
	obstaclespawner:add()

	results = gfx.sprite.new(resultsImage)
	results:add()
	resultsY = 0
	resultsAnimator = gfx.animator.new(2000, -10000, -10000)

	local backgroundImage = gfx.image.new("images/background")
	gfx.sprite.setBackgroundDrawingCallback(
		function(x, y, width, height)
			gfx.setClipRect(x, y, width, height)
			backgroundImage:draw(0, 0)
			gfx.clearClipRect()
		end
	)
end

initialize()

function playdate.update()
	drawOffsetX, drawOffsetY = gfx.getDrawOffset()

	results:moveTo(200, resultsAnimator:currentValue())


	if gameStopped then
		gfx.setDrawOffset(0, 0)
	end

	print(gfx.getDrawOffset())
	playdate.timer.updateTimers()
	gfx.sprite.update()
end

function gameover()
	local resultsImage = gfx.image.new(400, 240, gfx.kColorWhite)
	gfx.pushContext(resultsImage)
	gfx.setColor(gfx.kColorBlack)
	gfx.drawText("Game Over", 200, 120)
	gfx.drawTextAligned("Score: " .. drawOffsetY, 200, 140)
	gfx.popContext()
	results:setImage(resultsImage)

	gameStopped = true
	resultsstart()
end

function resultsstart()
	resultsAnimator = gfx.animator.new(300, -120, 120, playdate.easingFunctions.inOutCubic)
end

function spawnObstacle()
	local obstacle = Obstacle(math.random(0, 400), -drawOffsetY)
	obstacle:add()
end