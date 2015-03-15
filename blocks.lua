local blocks = {}

local mt = {__index = blocks}
blocks.size = 20
blocks.density = 200000

function blocks.new(x, y, i)
	local tab = {}
	setmetatable(tab, mt)
	tab.x = x
	tab.y = y
	tab.vel = 0
	tab.body = love.physics.newBody(world, x, y, "dynamic")
	tab.shape = love.physics.newRectangleShape(x, y, blocks.size, blocks.size)
	tab.fix = love.physics.newFixture(tab.body, tab.shape, blocks.density)
	
	tab.id = i
	id = id+1
	return tab
end


function blocks.load()




end

function blocks.update(dt)



end


function blocks:draw()
		love.graphics.setColor( 40*self.id, 10*self.id, 35*self.id)
		love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints( )))
end

return blocks
