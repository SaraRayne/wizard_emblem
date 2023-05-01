DialogueState = Class{__includes = BaseState}

function DialogueState:init(text, callback)
    self.textbox = Textbox(6, 6, VIRTUAL_WIDTH - 12, 64, text, gFonts['small'])
    self.callback = callback or function() end
end

function DialogueState:update(dt)
    if love.keyboard.wasPressed('space') then
        self.textbox.closed = true
    end

    if self.textbox:isClosed() then
        print('textbox closed')
        self.callback()
        gStateStack:pop()
    end
end

function DialogueState:render()
    self.textbox:render()
end