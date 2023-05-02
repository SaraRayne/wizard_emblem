Wizard = Class{}

function Wizard:init(def)
    self.direction = def.direction
    self.isAlive = true

    self.appearance = def.appearance
    self.blinking = false

    self.mapX = def.mapX
    self.mapY = def.mapY

    self.width = def.width
    self.height = def.height

    self.x = (self.mapX - 1) * TILE_SIZE

    self.y = (self.mapY - 1) * TILE_SIZE - self.height / 2

    self.magicType = def.stats.name
    self.health = def.stats.health
    self.attack = def.stats.attack
    self.defense = def.stats.defense
    self.waterMultiplier = def.stats.waterMultiplier
    self.fireMultiplier = def.stats.fireMultiplier
    self.iceMultiplier = def.stats.iceMultiplier
    self.lightningMultiplier = def.stats.lightningMultiplier

    self.healthBar = StatBar {
        x = (self.mapX) * TILE_SIZE - 20,
        y = (self.mapY) * TILE_SIZE - (self.height * 2),
        width = 24,
        height = 3,
        color = {r = 189/255, g = 32/255, b = 32/255},
        value = self.health,
        max = 60,
        wizard = self
    }

    self.whiteShader = love.graphics.newShader[[
        extern float WhiteFactor;

        vec4 effect(vec4 vcolor, Image tex, vec2 texcoord, vec2 pixcoord)
        {
            vec4 outputcolor = Texel(tex, texcoord) * vcolor;
            outputcolor.rgb += vec3(WhiteFactor);
            return outputcolor;
        }
    ]]
end

function Wizard:takeDamage(damage)
    gSounds['damage']:play()
    -- blink the attacker sprite three times (turn on and off blinking 6 times)
    Timer.every(0.1, function()
        self.blinking = not self.blinking
    end)
    :limit(6)
    :finish(function() end)
    self.health = math.max(0, self.health - damage)
    return
end

function Wizard:update(dt)
    self.healthBar:update(dt)
end

function Wizard:render()
    -- if blinking is set to true, we'll send 1 to the white shader, which will
    -- convert every pixel of the sprite to pure white
    love.graphics.setShader(self.whiteShader)
    self.whiteShader:send('WhiteFactor', self.blinking and 1 or 0)

    love.graphics.draw(gTextures['wizards'], gFrames['wizards'][self.appearance],
        self.x, self.y)
    
    self.healthBar:render()
end