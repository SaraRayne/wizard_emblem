CombatState = Class{__includes = BaseState}

function CombatState:init(attacker, foe)
	self.attacker = attacker
	self.foe = foe
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
		end)

		-- TODO: call check for death; if death is true, print dead and exit (pop);
			-- later have blinking animation and get rid of dead player
			-- might need to alter generation of players; add to a table and in gameboard, generate all in table?
			-- when dead, remove from table

		-- Call calculate damage from foe to attacker
		local damageToAttacker = self:calculateDamage(self.foe, self.attacker)

		Timer.after(1.5, function()
			-- Apply damage
			Timer.tween(0.5, {
				[self.attacker.healthBar] = {value = self.attacker.health - damageToAttacker}
			})
			:finish(function()
				self.attacker:takeDamage(damageToAttacker)
			end)

			-- TODO: call check for death; if death is true, print dead and exit;
				-- later have blinking animation and get rid of dead player
				-- might need to alter generation of players; add to a table and in gameboard, generate all in table?
				-- when dead, remove from table
			-- TODO: pop after checking for deaths
			gStateStack:pop()
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
  -- check if health is 0
  -- if health zero, return true else false
end

function CombatState:render()

end