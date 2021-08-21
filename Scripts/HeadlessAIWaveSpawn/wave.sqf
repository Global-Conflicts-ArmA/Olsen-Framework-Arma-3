//A simple script that allows wave spawning with headless/pizza AI

// You first enter the name of the Logic in the headless/pizza AI Array in GCFW\modules\headless_ai\settings.sqf, followed by how long in seconds you want the wave to spawn from when the script it called.
//[{["WAVE"] call PZAI_fnc_spawnArray}, [], 150] call CBA_fnc_waitAndExecute;

[{["WAVE"] call PZAI_fnc_spawnArray}, [], 150] call CBA_fnc_waitAndExecute;
[{["WAVE"] call PZAI_fnc_spawnArray}, [], 300] call CBA_fnc_waitAndExecute;
[{["WAVE"] call PZAI_fnc_spawnArray}, [], 600] call CBA_fnc_waitAndExecute;
[{["WAVE"] call PZAI_fnc_spawnArray}, [], 900] call CBA_fnc_waitAndExecute;
[{["WAVE"] call PZAI_fnc_spawnArray}, [], 1200] call CBA_fnc_waitAndExecute;
[{["WAVE"] call PZAI_fnc_spawnArray}, [], 1800] call CBA_fnc_waitAndExecute;
[{["WAVE"] call PZAI_fnc_spawnArray}, [], 2400] call CBA_fnc_waitAndExecute;