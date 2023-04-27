EnemyTurnState = Class{__includes = BaseState}

function EnemyTurnState:init()
end

function PlayerTurnState:enter()
	gStateStack:push(DialogueState("Enemy Turn"))
end

function EnemyTurnState:update(dt)
	-- TODO: if all enemy wizards have moved, switch to player turn state and pop off enemy turn state
	if love.keyboard.wasPressed('space') then
		gStateStack:pop()
		gStateStack:push(PlayerTurnState())
	end 
end

function EnemyTurnState:render()
end