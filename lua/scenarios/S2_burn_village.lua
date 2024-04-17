local village_coords = {
    {10, 12}, { 9, 17}, {13, 8},
    {16, 20}, {25, 9}, {17, 14},
    {24, 15}
} 
-- lock view
wesnoth.interface.lock_view(true)

for i = 1, #village_coords do

    local village = village_coords[i]
    local x_yal = village[1]
    local y_val = village[2]

    wesnoth.interface.scroll_to_hex(
        village[1], village[2], false, true)

    -- explosion animation
    wesnoth.interface.add_hex_overlay(
        x_yal, y_val, 
        {
            halo = "projectiles/fire-burst-small-[1~8].png:100"
        })
    wesnoth.interface.delay(100)
    -- explosion sound
    wesnoth.audio.play("fire.wav") 
    wesnoth.interface.delay(100)
    wesnoth.interface.remove_hex_overlay(
        x_yal, y_val,
        "projectiles/fire-burst-small-[1~8].png:100")
    -- destroy village
    wesnoth.current.map[village] = "Rd^Dr"
    wesnoth.wml_actions.redraw{}
    -- put burning ashes on top
    wesnoth.interface.add_hex_overlay(
        x_yal, y_val,
        {
            halo = "scenery/flames[01~15].png:100"
        })
end
-- unlock view
wesnoth.interface.lock_view(false)