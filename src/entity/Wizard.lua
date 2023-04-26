Wizard = Class{}

function Wizard:init(def)
    self.direction = def.direction

    self.animations = self:createAnimations(def.animations)

    self.mapX = def.mapX
    self.mapY = def.mapY

    self.width = def.width
    self.height = def.height

    self.x = (self.mapX - 1) * TILE_SIZE

    self.y = (self.mapY - 1) * TILE_SIZE - self.height / 2
end

function Wizard:changeState(name)
    self.stateMachine:change(name)
end

function Wizard:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Wizard:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'wizards',
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end

--[[
    Called when we interact with this entity, as by pressing enter.
]]
function Wizard:onInteract()

end

function Wizard:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Wizard:update(dt)
    self.currentAnimation:update(dt)
    self.stateMachine:update(dt)
end

function Wizard:render()
    self.stateMachine:render()
end