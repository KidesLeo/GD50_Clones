--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

medal = {
    ['winner'] = love.graphics.newImage('winner.png'),
    ['competitor'] = love.graphics.newImage('competitor.png'),
    ['participant'] = love.graphics.newImage('participant.png'),
    ['zero'] = love.graphics.newImage('donor.png')
}

score = io.open('score.txt', 'w')
score:write("0")
io.close(score)

score = io.open('score.txt', 'r')
h_score = tonumber(score:read())
io.close(score)
--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.draw(CheckScore(self.score), 250, 120)

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end


-- checks the score and updates the current highscore if it's higher and returns appropriate medal
function CheckScore(scr)
    
    score = io.open('score.txt', 'r')
    h_score = tonumber(score:read())
    io.close(score)

    if scr == 0 then
        return medal['zero']
    elseif scr > h_score then
        score = io.open('score.txt', 'w')
        score:write(tostring(scr))
        io.close(score)
    elseif scr >= h_score/2 and scr < h_score then
        return medal['competitor']
    elseif scr < h_score then
        return medal['participant']
    end

    return medal['winner']
end