
function wesnoth.wml_actions.give_experience(cfg)
    -- get the XP amount
    local amount = tonumber(cfg.amount) or wml.error("Missing or wrong percentage= value in [give_experience]")

    -- get the receiving unit(s)
    for index, unit in ipairs(wesnoth.units.find_on_map(cfg)) do
        if unit.valid then
            wesnoth.interface.float_label( unit.x, unit.y, string.format("<span color='cyan'>+%s XP</span>", tostring(amount) ) )
            unit.experience = unit.experience + amount
        end
    end    
end

function wesnoth.wml_actions.recall_gold_cost(cfg)
    local percentage = tonumber( cfg.percentage ) or wml.error( "Missing or wrong percentage= value in [recall_gold_cost]" )
    for _, unit in pairs(wesnoth.units.find_on_recall {}) do
        unit.recall_cost = math.floor(unit.cost * (percentage/100))
    end
end

function wesnoth.effects.gender(unit, cfg)
    -- we extend unit effects to gender swapping
	if cfg.set then
		unit.gender = cfg.set
	else
		wml.error("Invalid or Missing key in [effect] apply_to=gender")
	end
end