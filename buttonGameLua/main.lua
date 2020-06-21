function love.load()
  centerOfScreenX = love.graphics.getWidth() / 2
  centerOfScreenY = love.graphics.getHeight() / 2

  button = {}
  button.x = 250
  button.y = 250
  button.size = 50

  score = 0
  timer = 10
  -- menu / game
  gameState = 'menu'

  fontSize = love.graphics.newFont(34)
end

function love.update(dt)
  if gameState == 'game' then
    if timer > 0 then
      timer = timer - dt
    end
    if timer < 0 then
      timer = 0
      score = 0
      gameState = 'menu'
    end
  end
end

function love.draw()
  if gameState == 'game' then
    -- fill or line modes | target buton
    love.graphics.setColor(0, 0.8, 0.5)
    love.graphics.circle('fill', button.x, button.y, button.size)
  end
  -- display score
  love.graphics.setFont(fontSize)
  love.graphics.setColor(1, 1, 1)
  love.graphics.print('SCORE: ' .. score, 10, 10)
  -- display timer
  love.graphics.print('TIME: ' .. math.ceil(timer) .. 's', 300, 10)

  -- display menu "click to play"
  if gameState == 'menu' then
    love.graphics.setColor(0, 0.3, 0.6)
    love.graphics.rectangle('line', 250, 285, 300, 70)
    love.graphics.printf('CLICK TO PLAY', 0, centerOfScreenY, love.graphics.getWidth(), 'center')
  end

end

function love.mousepressed(x, y, btn, isTouch)
  if btn == 1 and gameState == 'game' then
    if distanceBetween(button.x, button.y, love.mouse.getX(), love.mouse.getY()) < button.size then
      score = score + 1
      button.x = math.random(button.size, love.graphics.getWidth() - button.size)
      button.y = math.random(button.size, love.graphics.getHeight() - button.size)

    end
  end

  if gameState == 'menu' then
    gameState = 'game'
    timer = 10
  end
end

function distanceBetween(x1, y1, x2, y2)
  return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end
