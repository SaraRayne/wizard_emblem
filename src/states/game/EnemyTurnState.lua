EnemyTurnState = Class{__includes = BaseState}

function EnemyTurnState:init(firstEnemy, secondEnemy, thirdEnemy, playState)
	self.playState = playState
	self.inCombat = false
	self.openingDialogue = DialogueState("Enemy Turn")

	-- define enemy wizards and allow movement by default
	self.firstEnemy = firstEnemy
	self.secondEnemy = secondEnemy
	self.thirdEnemy = thirdEnemy

	self.numWizardsMoved = 0
end

function EnemyTurnState:enter()
	gStateStack:push(self.openingDialogue)
	Timer.after(2, function() 
		if self.openingDialogue.textbox.closed ~= true then
			gStateStack:pop()
		end
		Timer.after(3, function()
			self:moveEnemy(self.firstEnemy)
			Timer.after(3, function()
				self:moveEnemy(self.secondEnemy)
				Timer.after(3, function()
					self:moveEnemy(self.thirdEnemy)
					Timer.after(3, function()
							gStateStack:pop()
							self.playState.turn = 'player'
					end)
				end)
			end)
		end)
	end)
end

function EnemyTurnState:update(dt)
	aliveWizards = self:countAliveWizards({self.firstEnemy, self.secondEnemy, self.thirdEnemy})
	if aliveWizards == 0 then
		gStateStack:pop()
		gStateStack:push(EndGameState("You win! Press Space to play again.", true))
	end

	self.firstEnemy:update()
	self.secondEnemy:update()
	self.thirdEnemy:update()

	-- if self.numWizardsMoved == aliveWizards and aliveWizards ~= 0 and self.inCombat == false then
	-- 	gStateStack:pop()
	-- 	self.playState.turn = 'player'
	-- end 
end

function EnemyTurnState:moveEnemy(enemy)
	if enemy.isAlive == false then
		return
	end

	players = self:alivePlayerWizards(self.playState.gameboard.playerWizards)
	closestPlayer = self:findClosestPlayer(enemy, players)

	x, y = self:findClosestTileToPlayer(enemy, closestPlayer)

	local collidedPlayer = self:checkCollision(x, y, players)

	if collidedPlayer then
		-- Move to nearby tile
		enemy.mapX = x
		enemy.mapY = y + 1
		enemy.x = (enemy.mapX - 1) * TILE_SIZE
		enemy.y = (enemy.mapY - 1) * TILE_SIZE - enemy.height / 2
		self.numWizardsMoved = self.numWizardsMoved + 1

		self.inCombat = true
		gStateStack:push(CombatState(enemy, collidedPlayer, self))
	else
		-- Move to closest tile
		enemy.mapX = x
		enemy.mapY = y
		enemy.x = (enemy.mapX - 1) * TILE_SIZE
		enemy.y = (enemy.mapY - 1) * TILE_SIZE - enemy.height / 2
		self.numWizardsMoved = self.numWizardsMoved + 1
	end
end

function EnemyTurnState:findClosestPlayer(enemy, players)
	local closestPlayer = nil
	-- initialize lowest to random value
	local lowestX = 200
	local lowestY = 200
	for i, v in pairs(players) do
		local diffX = math.abs(v.mapX - enemy.mapX)
		local diffY = math.abs(v.mapY - enemy.mapY)
		if diffX <= lowestX and diffY <= lowestY then
			closestPlayer = v
			lowestX = diffX 
			lowestY = diffY
		end
	end
	return closestPlayer
end

function EnemyTurnState:findClosestTileToPlayer(enemy, closestPlayer)
	local allPossibleX = {enemy.mapX, math.min(enemy.mapX + 1, VIRTUAL_WIDTH - 16), math.min(enemy.mapX + 2, VIRTUAL_WIDTH - 16), math.max(0, enemy.mapX - 1), math.max(0, enemy.mapX - 2)}
	local allPossibleY = {enemy.mapY, math.min(enemy.mapY + 1, VIRTUAL_HEIGHT), math.min(enemy.mapY + 2, VIRTUAL_HEIGHT), math.max(0, enemy.mapY - 1), math.max(0, enemy.mapY - 2)}

	-- initialize lowest to random value
	local lowestX = 200
	local lowestY = 200
	-- placeholders for x and y coordinates to move to
	local xPos = nil
	local yPos = nil

	for i, xValue in pairs(allPossibleX) do
		diffX = math.abs(xValue - closestPlayer.mapX)
		if diffX < lowestX then
			lowestX = diffX
			xPos = xValue
		end
	end

	for i, yValue in pairs(allPossibleY) do
		diffY = math.abs(yValue - closestPlayer.mapY)
		if diffY < lowestY then
			lowestY = diffY
			yPos = yValue
		end
	end

	return xPos, yPos
end

function EnemyTurnState:checkCollision(x, y, players)
	for i, player in pairs(players) do
		if x == player.mapX and y == player.mapY and player.isAlive then
			return player
		end
	end
	return nil
end

function EnemyTurnState:countAliveWizards(enemyWizards)
	local aliveCount = 0

	for i, wizard in pairs(enemyWizards) do
		if wizard.isAlive then
			aliveCount = aliveCount + 1
		end
	end

	return aliveCount
end

function EnemyTurnState:alivePlayerWizards(playerWizards)
	local alivePlayers = {}

	for i, wizard in pairs(playerWizards) do
		if wizard.isAlive then
			table.insert(alivePlayers, wizard)
		end
	end

	return alivePlayers
end

function EnemyTurnState:render()
end