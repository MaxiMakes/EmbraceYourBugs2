local blocks = require 'blocks'
local player = require 'player'
local bList = {}
local floor = {}
local p = {}
local won = false
local lost = false
width, height = 400, 800 
id = 0
i = 0

function love.load()
	source = love.audio.newSource( "Jump2.ogg", "static" )
	love.window.setTitle("Embrace Your Bugs 2.0 -- Fuck Box2D")
	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 9.81*64, false)
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)
	floor.body = love.physics.newBody(world, 30, 300, "static")
	floor.shape = love.physics.newRectangleShape(floor.body:getX(), floor.body:getY(), 4000, 20)
	floor.fix = love.physics.newFixture(floor.body, floor.shape, blocks.density)
	--bList ={blocks.new(20,20, 0)}
	
	--table.insert(bList, blocks.new(40,40, 2))
	table.insert(p, player.new())
end

function love.update(dt)
	--i = i + 30
	--table.insert(bList, blocks.new(i,10, id))
	for i,v in ipairs(bList) do 
		v.update(dt)
	end
	--player
	--[[for i,v in pairs(p) do
		v:update(dt)
	end]]--
	world:update(dt)
	for i, v in ipairs(p) do
		if love.keyboard.isDown('right') then
			v.body:applyForce(400000*dt, 0)
			print(v.body)
			print("popo")
	 	end
	 	if love.keyboard.isDown('left')  then
			v.body:applyForce(-400000*dt, 0)
	 	end
	 	
	 	if love.keyboard.isDown('up') and p[1].colliders > 0 then
			love.audio.play( source )
			v.body:applyForce(0, -600000*dt)
			
	 	end
	end
end

function beginContact(a, b, coll)
  	if(a == p[1].fix)then
			print("arsch")
			aufsMaul(a,b,coll)
		end
		if(b == p[1].fix)then
			print("arsch")
			aufsMaul(b,a,coll)
		end
end
function endContact(a,b,coll)
  	if(a == p[1].fix)then
			print("arsch+")
			ausMaul(a,b,coll)
		end
		if(b == p[1].fix)then
			print("arsch+")
			ausMaul(b,a,coll)
		end

end
function ausMaul(a,b,coll)
		p[1].colliders = p[1].colliders - 1
		print(p[1].colliders)
end
function aufsMaul(a,b,coll)
	p[1].colliders = p[1].colliders + 1
	print(p[1].colliders)
	local x, y = b:getBody():getLinearVelocity( )
	if y >= 1 then
		print("TOTTTTT")
		lost = true
	else
		print("leeeebem")
	end

end

function love.keypressed(key)
   if key == "escape" then
      love.event.quit()
   elseif(key == "1")then
   		table.insert(bList, blocks.new(p[1].body:getX()- blocks.size*5,-20, id))
   elseif(key == "2")then
   		table.insert(bList, blocks.new(p[1].body:getX()-blocks.size*4,-20, id))
   elseif(key == "3")then
   		table.insert(bList, blocks.new(p[1].body:getX()-blocks.size*3,-20, id))
   elseif(key == "4")then
   		table.insert(bList, blocks.new(p[1].body:getX()-blocks.size*2,-20, id))
	 elseif(key == "5")then
   		table.insert(bList, blocks.new(p[1].body:getX(),-20, id))
	 elseif(key == "6")then
   		table.insert(bList, blocks.new(p[1].body:getX()+blocks.size*2,-20, id))
   elseif(key == "7")then
   		table.insert(bList, blocks.new(p[1].body:getX()+blocks.size*3,-20, id))
   elseif(key == "8")then
   		table.insert(bList, blocks.new(p[1].body:getX()+blocks.size*4,-20, id))
   elseif(key == "9")then
   		table.insert(bList, blocks.new(p[1].body:getX()+blocks.size*5,-20, id))
   elseif(key == "0")then
   		table.insert(bList, blocks.new(p[1].body:getX()+blocks.size*6,-20, id))
       
   end
end

function love.draw()
	love.graphics.push()
   love.graphics.translate(-p[1].body:getX()+width, -p[1].body:getY()/2)
	love.graphics.setColor( 255, 255, 255)
		love.graphics.polygon("fill", floor.body:getWorldPoints(floor.shape:getPoints( )))

	for i,v in ipairs(bList) do
		v:draw()
		--print(v.body:getGravityScale())
	end
	love.graphics.setColor( 255, 255, 255)
	for i,v in ipairs(p) do
		v:draw()
	end
	if lost == true then
		love.graphics.setColor( 255, 255, 255)
		love.graphics.print("You Lost", p[1].body:getX(), height / 2)
	end
	   love.graphics.pop()
end

