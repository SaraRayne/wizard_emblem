CombatState = Class{__includes = BaseState}

function CombatState:init(attacker, foe, turnState)
	self.attacker = attacker
	self.foe = foe
	self.turnState = turnState
end

function CombatState:enter()
	-- Calculate damage from attacker to foe
	local damageToFoe = self:calculateDamage(self.attacker, self.foe)

	-- Apply damage
	Timer.after(1.5, function()
		Timer.tween(0.5, {
			[self.foe.healthBar] = {value = self.foe.health - damageToFoe}
		})
		:finish(function()
			self.foe:takeDamage(damageToFoe)

			if self:checkForDeath(self.foe) then
				Timer.after(2, function() 
					self.foe.isAlive = false
					self.turnState.inCombat = false
					gStateStack:pop()
				end)
			else
				-- Call calculate damage from foe to attacker
				local damageToAttacker = self:calculateDamage(self.foe, self.attacker)
		
				Timer.after(1.5, function()
					-- Apply damage
					Timer.tween(0.5, {
						[self.attacker.healthBar] = {value = self.attacker.health - damageToAttacker}
					})
					:finish(function()
						self.attacker:takeDamage(damageToAttacker)

						Timer.after(2, function() 
							if self:checkForDeath(self.attacker) then
								self.attacker.isAlive = false
							end
							self.turnState.inCombat = false
							gStateStack:pop()
						end)
					end)
				end)
			end
		end)
	end)
end

function CombatState:update(dt)
end

function CombatState:calculateDamage(attacker, attackee)
	local magicMultiplier = nil

	if attackee.magicType == 'Fire Wizard' then
		magicMultiplier = attacker.fireMultiplier
	elseif attackee.magicType == 'Water Wizard' then
		magicMultiplier = attacker.waterMultiplier
	elseif attackee.magicType == 'Ice Wizard' then
		magicMultiplier = attacker.iceMultiplier
	elseif attackee.magicType == 'Lightning Wizard' then
		magicMultiplier = attacker.lightningMultiplier
	end

	local attack = (attacker.attack + (attacker.attack * magicMultiplier)) - attackee.defense

	return math.max(0, attack)
end

function CombatState:checkForDeath(wizard)
	if wizard.health == 0 then
		return true
	end
	return false
end

function CombatState:render()

end