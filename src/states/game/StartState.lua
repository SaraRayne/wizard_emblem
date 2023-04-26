StartState = Class{__includes = BaseState}

function StartState:init()
    -- TODO: ADD INTRO MUSIC
    -- gSounds['intro-music']:play()

end

function StartState:update(dt)
    if love.keyboard.wasPressed('space') then
        gStateStack:push(PlayState())
        gStateStack:push(DialogueState("" .. 
            "This is Wizard Emblem. You control a team of wizards with one goal: "..
            "to defeat the enemy wizards! To move, use the arrow keys to select the "..
            "tile you'd like to move to, then press Enter. Press Space to skip dialogue. "..
            "Good luck!"
        ))
    end
end

-- TODO: Make start state prettier (not just a boring background)
function StartState:render()
    love.graphics.clear(188/255, 188/255, 188/255, 1)

    love.graphics.setColor(24/255, 24/255, 24/255, 1)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Wizard Emblem', 0, VIRTUAL_HEIGHT / 2 - 72, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Space', 0, VIRTUAL_HEIGHT / 2 + 68, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(1, 1, 1, 1)
end