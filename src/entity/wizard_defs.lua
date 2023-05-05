WIZARD_IDS = {
	'fire', 'water', 'ice', 'lightning'
}

WIZARD_DEFS = {
	['fire'] = {
		name = 'Fire Wizard',
		color = {r = 255/255, g = 0/255, b = 0/255},
		health = 60,
		attack = 10,
		defense = 5,
		waterMultiplier = -0.5,
		fireMultiplier = 0,
		iceMultiplier = 0.3,
		lightningMultiplier = 0
	},
	['water'] = {
		name = 'Water Wizard',
		color = {r = 0/255, g = 191/255, b = 255/255},
		health = 60,
		attack = 10,
		defense = 5,
		waterMultiplier = 0,
		fireMultiplier = 0.5,
		iceMultiplier = -0.2,
		lightningMultiplier = -0.3
	},
	['ice'] = {
		name = 'Ice Wizard',
		color = {r = 176/255, g = 224/255, b = 230/255},
		health = 60,
		attack = 10,
		defense = 5,
		waterMultiplier = 0.2,
		fireMultiplier = -0.3,
		iceMultiplier = 0,
		lightningMultiplier = 0
	},
	['lightning'] = {
		name = 'Lightning Wizard',
		color = {r = 255/255, g = 255/255, b = 0/255},
		health = 60,
		attack = 10,
		defense = 5,
		waterMultiplier = 0.5,
		fireMultiplier = 0,
		iceMultiplier = 0,
		lightningMultiplier = 0
	}
}