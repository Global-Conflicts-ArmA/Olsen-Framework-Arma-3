/*
Modules are added by including the root.sqf which tells the framework where specific sections of the module should be loaded.

Example:
#include "start_text\root.sqf"

Enabled modules by default, disable them by adding // in front.
*/

#include "acre_setup\root.sqf"
#include "ai_drivers\root.sqf"
#include "anti_nd\root.sqf"
#include "jip\root.sqf"
#include "self_actions\root.sqf"
#include "weapon_helper\root.sqf"

/*
Additional modules that can be enabled by removing the //
!!Some of them require changing settings in their settings.sqf file!!
*/

//#include "a3_endscreen\root.sqf"
//#include "ace_medical\root.sqf"
//#include "ai_behaviour\root.sqf"
//#include "ai_link\root.sqf"
//#include "ai_skill\root.sqf"
//#include "ai_tasks\root.sqf"
//#include "ambient_animation\root.sqf"
//#include "ambient_effects\root.sqf"
//#include "ao_limit\root.sqf"
//#include "ao_limit_soft\root.sqf"
//#include "backpack_on_chest\root.sqf"
//#include "billboards\root.sqf"
//#include "call_mission\root.sqf"
//#include "capture_zone\root.sqf"
//#include "clicker\root.sqf"
//#include "cover_map\root.sqf"
//#include "currency\root.sqf"
//#include "cvc_check\root.sqf"
//#include "daylight\root.sqf"
//#include "env_parameters\root.sqf"
//#include "extract\root.sqf"
//#include "firemission\root.sqf"
//#include "gas\root.sqf"
//#include "grad-fortifications\root.sqf"
//#include "headless_ai\root.sqf"
//#include "hostage\root.sqf"
//#include "in_game_brief\root.sqf"
//#include "knock_down\root.sqf"
//#include "marker_control\root.sqf"
//#include "rank_icons\root.sqf"
//#include "remove_map\root.sqf"
//#include "set_face\root.sqf"
//#include "setup_timer\root.sqf"
//#include "snow\root.sqf"
//#include "start_in_parachute\root.sqf"
//#include "start_in_vehicle\root.sqf"
//#include "start_on_team_color\root.sqf"
//#include "start_text\root.sqf"
//#include "task_control\root.sqf"
//#include "tracking_markers\root.sqf"
//#include "vehicle_boost\root.sqf"

/********* EXPERIMENTAL / INCOMPLETE MODULES *********/
// These modules may or may not work and aren't supported in their current state
//#include "ai_attack\root.sqf"
//#include "radio_messages\root.sqf"
//#include "random_scenario\root.sqf"
