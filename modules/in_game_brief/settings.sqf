// ----------------------------------------------------
// This script allows users to brief in-game.
// Resctricted to a sized setup zone untill both teams interact with a chosen object and "ready up", at which point the mission will become live after 15 seconds and players may then leave the zone.
//
//
// You can find an example mission here: https://globalconflicts.net/wiki/index.php?title=Mission_template/Examples
// 1) Uncomment the module in the modules\modules.sqf file.
//
// 3) For each setup zone you want to create, place a gamelogic in the center of the desired area, and add the following to the settings.sqf file:
// [<GAME LOGIC NAME>, <SETUP SIZE>, <SIDE>] call FUNC(setup);
//
// 4) Place down one object in each sides start zone, it can be any object, and give each object the relevant variable name for the correct side, either "BlueBoard" or "RedBoard"
//
// 5) Place down a logic and name it "barrierChecker"
// ----------------------------------------------------
//[barrier1, 50, west] call FUNC(setup);
//[barrier2, 50, east] call FUNC(setup);
