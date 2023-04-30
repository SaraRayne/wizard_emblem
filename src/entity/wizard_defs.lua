WIZARD_IDS = {
	'fire', 'water', 'ice', 'lightning'
}

WIZARD_DEFS = {
	['fire'] = {
		name = 'Fire Wizard',
		health = 2,
		attack = 10,
		defense = 5,
		waterMultiplier = -0.5,
		fireMultiplier = 0,
		iceMultiplier = 0.5,
		lightningMultiplier = 0
	},
	['water'] = {
		name = 'Water Wizard',
		health = 2,
		attack = 10,
		defense = 5,
		waterMultiplier = 0,
		fireMultiplier = 0.5,
		iceMultiplier = -0.3,
		lightningMultiplier = -0.5
	},
	['ice'] = {
		name = 'Ice Wizard',
		health = 2,
		attack = 10,
		defense = 5,
		waterMultiplier = 0.3,
		fireMultiplier = -0.5,
		iceMultiplier = 0,
		lightningMultiplier = 0
	},
	['lightning'] = {
		name = 'Lightning Wizard',
		health = 2,
		attack = 10,
		defense = 5,
		waterMultiplier = 0.5,
		fireMultiplier = 0,
		iceMultiplier = 0,
		lightningMultiplier = 0
	}
}