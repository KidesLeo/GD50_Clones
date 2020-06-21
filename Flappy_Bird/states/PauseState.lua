
--[[

    A pause state that is instansiated evertime the player presses
    the escape key. Pressing it again will result in a restart and
    pressing the return key will result in a resumtion.

]]

PauseState = Class{_includes, BaseState}


function PauseState:init()

    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0
    self.score = 0


end


function PauseState:enter()
    self.bird = bird
    self.pipePairs = pipePairs
    self.timer = timer
    self.score = score

    sounds['music']:pause()
    sounds['pause']:play()
    scrolling = false

end

function PauseState:update(dt)

    if love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {reset = false})
    end

    if love.keyboard.wasPressed('escape') then
        love.window.close()
    end

    if love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {reset = false})
    end

end

function PauseState:render(dt)

    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    self.bird:render()

    love.graphics.setColor(0,0,0,0.5)
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT )
    love.graphics.setColor(255,255,255)

    love.graphics.setFont(hugeFont)
    love.graphics.printf("I I", 0, 45, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(flappyFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 120, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf("Esc - Quit\nEnter - Continue", 5, 200, VIRTUAL_WIDTH, 'left')

    love.graphics.setColor(0,0,0)
end

function PauseState:exit()
    sounds['pause']:play()
    sounds['music']:play()
    scrolling = true
end