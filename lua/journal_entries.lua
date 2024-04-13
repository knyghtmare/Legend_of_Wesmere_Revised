local _ = wesnoth.textdomain 'wesnoth-lowr'

function wesnoth.wml_actions.landar_journal_setup()
    wml.variables["landar_entries.entry"]="Cancel"
end

local T = wml.tag

local dialog = {
    T.tooltip { id = "tooltip_large" },
    T.helptip { id = "tooltip_large" },
    T.linked_group { id = "icon", fixed_width = true },
    maximum_height=600,
    T.grid {
        T.row {
            grow_factor = 0,
            T.column {
                horizontal_alignment = "left",
                T.grid {
                    T.row {
                        grow_factor = 0,
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "left",
                            T.image {
                                id = "icon",
                                linked_group = "icon"
                            }
                        },
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "left",
                            T.label {
                                definition = "title",
                                id = "title"
                            }
                        }
                    }
                }
            }
        },
        T.row {
            grow_factor = 1,
            T.column {
                border = "all",
                border_size = 5,
                horizontal_grow = true,
                vertical_alignment = "top",
                T.listbox {
                    id = "list",
                    T.list_definition {
                        T.row {
                            T.column {
                                horizontal_grow = true,
                                T.toggle_panel {
                                    return_value = -1,
                                    T.grid {
                                        T.row {
                                            T.column {
                                                grow_factor = 1,
                                                border = "all",
                                                border_size = 5,
                                                horizontal_alignment = "left",
                                                T.label {
                                                    id = "label"
                                                }
                                            },
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        },
        T.row {
            grow_factor = 0,
            T.column {
                horizontal_alignment = "right",
                T.grid {
                    T.row {
                        grow_factor = 1,
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "right",
                            T.button {
                                id = "cast_button",
                                return_value = -1,
                                label = "OK"
                            }
                        },
                        T.column {
                            border = "all",
                            border_size = 5,
                            horizontal_alignment = "right",
                            T.button {
                                id = "ok_button",
                                return_value = 1,
                                label = "Cancel"
                            }
                        }
                    }
                }
            }
        }
    }
}

local function select()
    local i = wesnoth.get_dialog_value "list"
end

local title = ""
local journal_entry = {"Cancel"}

local function preshow()
    wesnoth.set_dialog_callback(select, "list")
    wesnoth.set_dialog_value(title, "title")
    wesnoth.set_dialog_value("icons/book.png", "icon")

    for i,v in ipairs(journal_entry) do
        if i == 1 then
        else
            wesnoth.set_dialog_value(string.format("(%d) — %s", i-1, journal_entry[i]), "list", i-1, "label")
            wesnoth.set_dialog_markup(true,"list", i-1, "label")
        end
    end
    wesnoth.set_dialog_value(1, "list")
    select()
end

local li
local function postshow()
    li = wesnoth.get_dialog_value "list"
end

local function dialog_var_cleanup()
    li = 0
    title = ""
    journal_entry = {"Cancel"}
end

--landar's journal
function wesnoth.wml_actions.landar_journal()
    local landar_entries = wml.array_access.get("landar_entries")

    for i,v in ipairs(landar_entries) do
        if i == 1 then
        else
            table.insert(journal_entry,landar_entries[i].entry)
        end
    end

    title = "Landar’s Journal"

    local r = gui.show_dialog(dialog, preshow, postshow)

    if r == -1 then
        if journal_entry[li+1]=="Kalenz1" then
            gui.show_narration({
                 title = "Kalenz1",
                 message= _"The last and most powerful of these creatures are almost upon us. I feel that if we can finish them off in time, we shall be victorious.",
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/touch-faerie.png~SCALE(120,120), 168, 212)",
            })
        elseif journal_entry[li+1]=="Kalenz2" then
            gui.show_narration({
                 title = "Kalenz2",
                 message= _"Ungabunga.",
                 portrait = "misc/blank-hex.png~SCALE(360,360)~BLIT(attacks/touch-faerie.png~SCALE(120,120), 168, 212)",
            })
        end
    end

    dialog_var_cleanup()
end

-- journal entry navigator
function wesnoth.wml_actions.journal_menu()

    local x = wml.variables["x1"]
    local y = wml.variables["y1"]

    local a = wesnoth.map.matches(x,y,{
        {"filter",{id="Landar"}}
    })
    local b = wesnoth.map.matches(x,y,{
        {"filter",{id="Kalenz"}}
    })

    -- make menu items for Landar available
    if a == true then
        dialog_var_cleanup()
        wesnoth.wml_actions.landar_journal()
    elseif b == true then
        dialog_var_cleanup()
    else
        dialog_var_cleanup()
    end

    dialog_var_cleanup()
end

-- refresh journal menu every time a new entry is added
function wesnoth.wml_actions.refresh_journal(cfg)
    wesnoth.wml_actions.set_menu_item { id="journal",
        description="View Journal",
        {"filter_location",{x="$x1",y="$y1",
            {"filter",{id="Landar,Kalenz"}}
        }},
        {"command",{
            {"journal_menu"}
        }}
    }
end

-------------------------------------- JOURNAL ENTRY DISCOVERY ----------------------------------------------
------------ LANDAR --------------
function wesnoth.wml_actions.add_landar_entry(cfg)
    wesnoth.wml_actions.set_variables {name = "landar_entries", mode = "append",
        {"value",{entry = cfg.entry}}
    }

    wesnoth.wml_actions.refresh_journal(cfg)
end
