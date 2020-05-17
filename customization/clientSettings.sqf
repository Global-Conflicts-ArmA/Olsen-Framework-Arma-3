GVAR(DebugMessagesEnabled) = true; //Only disable debug messages when the mission is released

GVAR(ClientViewDistance) = 2500; //View distance for the player

GVAR(StartOnSafe) = true;
GVAR(StartOnSafe_Lowered) = true;
GVAR(StartOnSafe_Unloaded) = true;

GVAR(RespawnTickets) = 0; //Initialize individual client respawn tickets to 0

//call FUNC(forceTerrainGrid); //uncomment this to force high terrain setting. This will prevent faraway objects from appearing as floating. Useful for missions with long sightlines.

// Spectator Settings
// Whitelisted sides (BLUFOR,OPFOR,RESISTANCE,CIVILIAN)
eg_whitelisted_sides = [BLUFOR,OPFOR,RESISTANCE,CIVILIAN];
// Whether AI can be viewed by the spectator (true/false)
eg_ai_viewed_by_spectator = true;
// Whether Free camera mode is available (true/false)
eg_free_camera_mode_available = true;
// Whether 3th Person Perspective camera mode is available (true/false)
eg_third_person_perspective_camera_mode_available = true;
// Whether to show Focus Info stats widget (true/false)
Show_Focus_Info_widget = false;
// Whether or not to show camera buttons widget (true/false)
eg_show_camera_buttons_widget = true;
// Whether to show controls helper widget (true/false)
eg_show_controls_helper_widget = true;
// Whether to show header widget (true/false)
eg_show_header_widget = true;
// Whether to show entities / locations lists (true/false)
eg_show_Entities_and_locations_lists = true;
// Define where the spectator camera starts. (add a marker with the name inside the "")
eg_spectator_marker = "";
// Activate showing information about killer
killcam_active = true;
// Makes screen turn black instantly and mutes all audio when killed
eg_instant_death = true;