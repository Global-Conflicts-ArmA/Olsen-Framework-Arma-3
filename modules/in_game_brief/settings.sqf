// ----------------------------------------------------
// This script allows users to brief in-game.
// Resctricted to a sized setup zone untill both teams interact with a chosen object and "ready up", at which point the mission will become live after 15 seconds and players may then leave the zone.
//
//
// You can find an example mission here: https://globalconflicts.net/wiki/index.php?title=Mission_template/Examples
// 1) Uncomment the module in the modules\modules.sqf file.
//
// 2) For each setup zone you want to create, place a rectangle area marker for the desired briefing area, and add the following to the settings.sqf file:
// [<MARKER NAME>, <SIDE>] call FUNC(setup);
//
// 3) Place down one object in each sides' start zone, it can be any object, and give each object the relevant variable name for the correct side, either "BlueBoard" or "RedBoard"
//
// ----------------------------------------------------
//["setup_blufor", blufor] call FUNC(setup);
//["setup_opfor", opfor] call FUNC(setup);
