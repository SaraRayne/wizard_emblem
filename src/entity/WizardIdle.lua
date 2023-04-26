WizardIdleState = Class{__includes = WizardBaseState}

function WizardIdleState:init(wizard)
    self.wizard = wizard
    self.wizard:changeAnimation('idle-' .. self.wizard.direction)
end