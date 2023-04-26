WizardBaseState = Class{}

function WizardBaseState:init(wizard)
    self.wizard = wizard
end

function WizardBaseState:update(dt) end
function WizardBaseState:enter() end
function WizardBaseState:exit() end
function WizardBaseState:processAI(params, dt) end

function WizardBaseState:render()
    local anim = self.wizard.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.wizard.x), math.floor(self.wizard.y))
end