clockRadius = 210
clockX, clockY = display.contentCenterX, display.contentCenterY

layer1 = display.newGroup()
layer2 = display.newGroup()
layer3 = display.newGroup()
layer4 = display.newGroup()
layers = { layer1, layer2, layer3, layer4 }

for _, layer in ipairs(layers) do
	layer.x, layer.y = clockX, clockY
end

function secondsToAngle(sec)
	-- 15 -> 0
	-- 0 -> 90
	-- 90-6*sec
	return 6 * sec 
end

function makeHand(layer, width, height, color)
	local hand = display.newPolygon(layer, 0, 0, { -width, 10, 0, -height, width, 10 })
	hand:setFillColor(unpack(color))
	hand.anchorX, hand.anchorY = 0.5, 0.95

	function hand:tick()
		transition.to(hand, {
			time = 950,
			rotation = self.rotation + 6
		})
	end
	return hand
end

hourHand = makeHand(layer2, 5, 130, { 0.9, 0.9, 0.1 })
minuteHand = makeHand(layer3, 7, 180, { 0.9, 0.3, 0.3 })
secondHand = makeHand(layer4, 3, 200, { 1.0, 0, 0 })


display.newCircle(layer1, 0, 0, clockRadius + 15):setFillColor(0.4, 0.7, 0.88)
sin, cos = math.sin, math.cos
for i = 0, 59 do
	radians = math.pi*i / 30
	x, y = clockRadius * cos(radians), clockRadius * sin(radians)
	display.newCircle(layer1, x, y, 2) 
end

print(os.time())

function setupHands()
	local date = os.date( "*t" )    -- returns table of date & time values
	print( date.hour, date.min )    -- print hour and minutes

	-- local h = 
	hourHand.rotation = secondsToAngle(5 * date.hour)
	minuteHand.rotation = secondsToAngle(date.min)
	secondHand.rotation = secondsToAngle(date.sec)
end


print( os.date( "%c" ) )    

setupHands()
timer.performWithDelay(1000, setupHands, -1)
