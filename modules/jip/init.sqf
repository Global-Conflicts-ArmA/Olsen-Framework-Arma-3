#include "..\..\core\script_macros.hpp"

["JIP Manager", "Handles JIPs in different ways depending on the module's settings.", "Olsen &amp; Starfox64"] call FUNC(RegisterModule);

#include "settings.sqf"

if (isServer) then {
	[{
	    CBA_missionTime > GVAR(JIPDENYTIME)
	},{
	    missionNamespace setVariable [QGVAR(JIPDenied), true, true];
	}, []] call CBA_fnc_waitUntilAndExecute;
};

if (hasInterface && {(str (side player)) != "LOGIC"}) then {

	if ((GVAR(JIPTYPE) isEqualTo "DENY") && {missionNamespace getVariable [QGVAR(JIPDenied), false]}) exitWith {
		[{
			player call FUNC(UntrackUnit);
			player setDamage 1;
			[{
			    cutText ["This mission does not support JIP.", "PLAIN DOWN"];
			}, [], 8] call CBA_fnc_waitAndExecute;
		}, [], 5] call CBA_fnc_waitAndExecute;
	};

	private _target = leader player;

	if (player isEqualTo _target || !(_target call FUNC(Alive))) then {
		private _rank = -1;
		{
			if ((rankId _x > _rank) && {(_target call FUNC(Alive))}) then {
				_rank = rankId _x;
				_target = _x;
			};
		} forEach ((units group player) - [player]);
	};

	if ((_target distance player) > GVAR(JIPDISTANCE)) then {

		switch (GVAR(JIPTYPE)) do {

			case "TELEPORT": {
				private _teleportAction = player addAction ["Teleport to Squad", "modules\jip\teleportAction.sqf", _target];
				[_teleportAction] spawn { //Spawns code running in parallel
					private _spawnPos = getPosATL player;
					while {true} do {
						if (player distance _spawnPos > GVAR(SPAWNDISTANCE)) exitWith { //Exitwith ends the loop
							player removeAction (_this select 0);
							cutText [format ["JIP teleport option lost, you went beyond %1 meters from your spawn location", GVAR(SPAWNDISTANCE)], 'PLAIN DOWN'];
						};
						sleep (60); //Runs every min
					};
				};
			};

			case "TRANSPORT": {
				private _transportAction = player addAction ["Request Transport", "modules\jip\transportAction.sqf"];
				[_transportAction] spawn { //Spawns code running in parallel
					private _spawnPos = getPosATL player;
					while {true} do {
						if (player distance _spawnPos > GVAR(SPAWNDISTANCE)) exitWith { //Exitwith ends the loop
							player removeAction (_this select 0);
							cutText [format ["JIP transport request option lost, you went beyond %1 meters from your spawn location", GVAR(SPAWNDISTANCE)], 'PLAIN DOWN'];
						};
						sleep (60); //Runs every min
					};
				};
			};
		};
	};
};
