local village_coords = {
    {10, 12}, { 9, 17}, {13, 8},
    {16, 20}, {25, 9}, {17, 14},
    {24, 15}
} 
-- lock view
wesnoth.interface.lock(true)

for i = 1, #village_coords do

    local village = village_coords[i]
    local x_val = village[1]
    local y_val = village[2]

    wesnoth.interface.scroll_to_hex(
        village[1], village[2], false, true)

    -- explosion animation
    wesnoth.interface.add_hex_overlay(
        x_val, y_val, 
        {
            halo = "projectiles/fire-burst-small-[1~8].png:100"
        })
    wesnoth.interface.delay(100)
    -- explosion sound
    wesnoth.audio.play("fire.wav")
    wesnoth.interface.delay(100)
    wesnoth.interface.remove_hex_overlay(
        x_val, y_val,
        "projectiles/fire-burst-small-[1~8].png:100")
    -- destroy village
    wesnoth.current.map[village] = "Rd^Dr"

    -- add code to damage adjacent area of each village
    if (x_val == 10) and (y_val == 12) then
        surroundings = {
            {9, 13}, {10, 11},
            {11, 12}, {10, 13}}
        for j = 1, #surroundings do
            local surrounding = surroundings[j]

            wesnoth.interface.add_hex_overlay(
                surrounding[1], surrounding[2],
                { halo = "scenery/flames[01~15].png:100" }
            )
            if (surrounding[1] == 9) and (surrounding[2] == 13) then
                wesnoth.current.map[surrounding] = "Gll"
            end
        end
    end

    if (x_val == 9) and (y_val == 17) then
        surroundings = {
            {8, 17}, {9, 18}, {10, 16}}
        for j = 1, #surroundings do
            local surrounding = surroundings[j]

            wesnoth.interface.add_hex_overlay(
                surrounding[1], surrounding[2],
                { halo = "scenery/flames[01~15].png:100" }
            )
            if (surrounding[1] == 8) and (surrounding[2] == 17) then
                wesnoth.current.map[surrounding] = "Gll"
            end
            if (surrounding[1] == 9) and (surrounding[2] == 18) then
                wesnoth.current.map[surrounding] = "Gll"
            end
        end
    end

    if (x_val == 13) and (y_val == 8) then
        surroundings = {
            {13, 7}, {12, 7},
            {12, 8}, {14, 8}}
        for j = 1, #surroundings do
            local surrounding = surroundings[j]

            wesnoth.interface.add_hex_overlay(
                surrounding[1], surrounding[2],
                { halo = "scenery/flames[01~15].png:100" }
            )
            if (surrounding[1] == 13) and (surrounding[2] == 7) then
                wesnoth.current.map[surrounding] = "Gll"
            end
            if (surrounding[1] == 12) and (surrounding[2] == 7) then
                wesnoth.current.map[surrounding] = "Gll"
            end
            if (surrounding[1] == 12) and (surrounding[2] == 8) then
                wesnoth.current.map[surrounding] = "Gll"
            end
        end
    end

    if (x_val == 16) and (y_val == 20) then
        surroundings = {
            {15, 20}, {16, 19}, {17, 21}}
        -- special case here: all are forests
        for j = 1, #surroundings do
            local surrounding = surroundings[j]

            wesnoth.interface.add_hex_overlay(
                surrounding[1], surrounding[2],
                { halo = "scenery/flames[01~15].png:100" }
            )
            wesnoth.current.map[surrounding] = "Gg"
        end
    end

    if (x_val == 25) and (y_val == 9) then
        surroundings = {
            {25, 8}, {25, 10},
            {26, 9}}
        for j = 1, #surroundings do
            local surrounding = surroundings[j]

            wesnoth.interface.add_hex_overlay(
                surrounding[1], surrounding[2],
                { halo = "scenery/flames[01~15].png:100" }
            )
            if (surrounding[1] == 12) and (surrounding[2] == 8) then
                wesnoth.current.map[surrounding] = "Gll"
            end
        end
    end

    if (x_val == 24) and (y_val == 15) then
        surroundings = {
            {24, 14}, {25, 15},
            {24, 16}}
        for j = 1, #surroundings do
            local surrounding = surroundings[j]

            wesnoth.interface.add_hex_overlay(
                surrounding[1], surrounding[2],
                { halo = "scenery/flames[01~15].png:100" }
            )
            if (surrounding[1] == 24) and (surrounding[2] == 14) then
                wesnoth.current.map[surrounding] = "Gd"
            end
            if (surrounding[1] == 24) and (surrounding[2] == 15) then
                wesnoth.current.map[surrounding] = "Gd"
            end
        end
    end

    -- the village in the middle
    if (x_val == 17) and (y_val == 14) then
        surroundings = {
            {16, 14}, {18, 14},
            {18, 13}}
        for j = 1, #surroundings do
            local surrounding = surroundings[j]

            wesnoth.interface.add_hex_overlay(
                surrounding[1], surrounding[2],
                { halo = "scenery/flames[01~15].png:100" }
            )
            if (surrounding[1] == 18) and (surrounding[2] == 13) then
                wesnoth.current.map[surrounding] = "Gs^Fetd"
            end
        end
    end

    -- redraw the display
    wesnoth.wml_actions.redraw{}
    -- put burning ashes on top
    wesnoth.interface.add_hex_overlay(
        x_val, y_val,
        {
            halo = "scenery/flames[01~15].png:100"
        })
end
-- unlock view
wesnoth.interface.lock(false)