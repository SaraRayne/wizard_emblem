-- TODO: map these to spritesheet
ENTITY_DEFS = {
  ['player'] = {
      animations = {
          ['walk-left'] = {
              frames = {16, 17, 18, 17},
              interval = 0.15,
              texture = 'wizards'
          },
          ['walk-right'] = {
              frames = {28, 29, 30, 29},
              interval = 0.15,
              texture = 'wizards'
          },
          ['walk-down'] = {
              frames = {4, 5, 6, 5},
              interval = 0.15,
              texture = 'wizards'
          },
          ['walk-up'] = {
              frames = {40, 41, 42, 41},
              interval = 0.15,
              texture = 'wizards'
          },
          ['idle-left'] = {
              frames = {17},
              texture = 'wizards'
          },
          ['idle-right'] = {
              frames = {29},
              texture = 'wizards'
          },
          ['idle-down'] = {
              frames = {1},
              texture = 'wizards'
          },
          ['idle-up'] = {
              frames = {41},
              texture = 'wizards'
          },
      }
  },
  ['enemy'] = {
      animations = {
          ['walk-left'] = {
              frames = {16, 17, 18, 17},
              interval = 0.15,
              texture = 'wizards'
          },
          ['walk-right'] = {
              frames = {28, 29, 30, 29},
              interval = 0.15,
              texture = 'wizards'
          },
          ['walk-down'] = {
              frames = {4, 5, 6, 5},
              interval = 0.15,
              texture = 'wizards'
          },
          ['walk-up'] = {
              frames = {40, 41, 42, 41},
              interval = 0.15,
              texture = 'wizards'
          },
          ['idle-left'] = {
              frames = {17},
              texture = 'wizards'
          },
          ['idle-right'] = {
              frames = {29},
              texture = 'wizards'
          },
          ['idle-down'] = {
              frames = {1},
              texture = 'wizards'
          },
          ['idle-up'] = {
              frames = {37},
              texture = 'wizards'
          },
      }
  }
}