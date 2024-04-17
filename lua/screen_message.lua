local screen_message = {valid = false}
local screen_text = ""
function wesnoth.wml_actions.screen_message(cfg)
    if screen_message.valid then
        screen_message:remove()
    end
    if cfg.message and not cfg.remove then
        screen_text = cfg.message
        if cfg.caption and cfg.caption ~= "" then
            screen_text = "<b><big>" .. cfg.caption .. "</big></b>\n" .. screen_text
        end
        screen_message = wesnoth.interface.add_overlay_text(screen_text, {
            size = 18,
            location = {5,5},
            color = {255, 255, 255},
            duration = "unlimited",
            max_width = "40%",
            valign = "top",
            halign = "left"
        })
    end
end

wesnoth.persistent_tags.screen_message.read = wesnoth.wml_actions.screen_message

function wesnoth.persistent_tags.screen_message.write(add)
    add{message = screen_text}
end