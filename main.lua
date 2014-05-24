dude = love.graphics.newImage( "dude.png" )
floor = love.graphics.newImage("floor.png")
block = love.graphics.newImage("block.png")
mother = love.graphics.newImage("mother.png")


WIDTH = 10
HEIGHT = 10
STARTX = 200
STARTY = 100
BASERAND =100
BIGRAND = 155

state = 0

ENDSTATE = 50
MIDDLESTATE = 25

function love.load()
    local joysticks = love.joystick.getJoysticks()
    joystick1 = joysticks[1]
    position1 = {x = 4, y = 5, p=50}
    joystick2 = joysticks[2]
    position2 = {x = 6, y = 5, p=50}
    math.randomseed(os.time())

    music = love.audio.newSource("Ouroboros.mp3")
    music:setLooping(true)
    music:play()

	r = rand()
	g = rand()
	b = rand()
end


love.graphics.setBackgroundColor(100, 100 ,100)

function img(img, p)
	if p.y == they then
		love.graphics.draw(img, STARTX + p.x*32, STARTY + (p.y-1)*32)
	end
end

r = 255
g = 255
b = 255

function love.draw()
	local c = (r + g + b) / 4
	love.graphics.setColor(c, c, c)
	for x=1,WIDTH do
		for y=1,HEIGHT do
			love.graphics.draw(floor, STARTX + x*32, STARTY + y*32)
		end
	end
	
	love.graphics.setColor(r,g,b)

	for y=1, HEIGHT do
		they = y
		img(block, {x = 1, y = 1})
		img(block, {x = 5, y = 3})
		img(block, {x = 3, y = 6})
		img(dude, position1)
		img(mother, position2)
	end


    love.graphics.setColor(255,255,255)
	love.graphics.print("P1 " .. position1.p, 50, 10)
    love.graphics.print("P2 " .. position2.p, 700, 10)
	love.graphics.print("P1 " .. position1.p, 50, 550)
    love.graphics.print("P2 " .. position2.p, 700, 550)

    local text = "MASTERBAIT"
    if state > MIDDLESTATE then
    	text = "DANCE MOM!"
    end
    love.graphics.print(text, 400, 500)
end

function love.keypressed(k)
   if k == 'escape' then
      love.event.quit()
   end
end

function love.joystickpressed( joystick, button )
	id, instanceid = joystick:getID()
	local step = false
	if id == 1 then
		move(joystick1, state < MIDDLESTATE, position1)
		step = true
	end
	if id == 2 then
		move(joystick2, state > MIDDLESTATE, position2)
		step = true
	end
	if step then
		perform(position1)
		perform(position2)
		state = state + 1
		if state > ENDSTATE then
			state = 0
		end
	end
end

function perform(p)
	p.p = p.p - 1
	if p.p < 0 then
		p.p = 0
	end
	r = rand()
	g = rand()
	b = rand()
end

function rand()
	return BASERAND + math.random(BIGRAND)
end

function move(joystick, term, position)
    if not joystick then return end

    local dx,dy = joystick:getAxis(4), joystick:getAxis(5)

    position.x = position.x + dx
    position.y = position.y + dy
    if position.x < 1 then position.x = 1 end
    if position.y < 1 then position.y = 1 end
    if position.x > WIDTH then position.x = WIDTH end
    if position.y > HEIGHT then position.y = HEIGHT end

    if term then
	    if dx == 0 and dy == 0 then
	    	position.p = position.p + 10
	    end
	end
end