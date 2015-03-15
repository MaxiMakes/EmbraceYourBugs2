local player = {}
local mt = {__index = player}
function player.new()
	local t = {}
	setmetatable(t, mt)
	t.density = 50
	t.x = 30
	t.y = 200
	t.size = 20 
	t.body = love.physics.newBody(world, t.x, t.y, "dynamic")
	t.shape = love.physics.newRectangleShape(t.x, t.y, t.size, t.size)
	t.fix = love.physics.newFixture(t.body, t.shape, t.density)
	t.colliders = 0
	return t
	

end


function player:update(dt)
	if love.keyboard.isDown('right') then
		self.body:applyForce(400, 0)
 	end
 	if love.keyboard.isDown('left')  then
		self.body:applyForce(-400, 0)
 	end
 	if love.keyboard.isDown('up') then
		self.body:applyForce(0, 30)
 	end
end

function player:draw()
			--print(self)
			--print(player)
			love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints( )))
end

function player:move(dt)

end


return player
