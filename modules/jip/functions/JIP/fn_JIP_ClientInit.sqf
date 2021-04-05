#include "script_component.hpp"

#include "..\..\settings.sqf"

[{(!isNull ace_player)}, {
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

		if (player isEqualTo _target || !(_target call FUNC(isAlive))) then {
			private _rank = -1;
			{
				if ((rankId _x > _rank) && {(_target call FUNC(isAlive))}) then {
					_rank = rankId _x;
					_target = _x;
				};
			} forEach ((units group player) - [player]);
		};

		if ((_target distance player) > GVAR(JIPDISTANCE)) then {
			private _checkDelay = 60;

			switch (GVAR(JIPTYPE)) do {

				case "TELEPORT": {
					diag_log "Adding action";
					private _teleportAction = player addAction ["Teleport to Squad", "modules\jip\teleportAction.sqf", _target];

					[{
						private _spawnPos = getPosATL player;

						if (player distance _spawnPos > GVAR(SPAWNDISTANCE)) exitWith { //Exitwith ends the loop
							player removeAction (_this select 0);
							cutText [format ["JIP teleport option lost, you went beyond %1 meters from your spawn location", GVAR(SPAWNDISTANCE)], 'PLAIN DOWN'];
						};
						} , _checkDelay, [_teleportAction]] call CBA_fnc_addPerFrameHandler;
				};

				case "TRANSPORT": {
					private _transportAction = player addAction ["Request Transport", "modules\jip\transportAction.sqf"];

					[{
						private _spawnPos = getPosATL player;

						if (player distance _spawnPos > GVAR(SPAWNDISTANCE)) exitWith { //Exitwith ends the loop
							player removeAction (_this select 0);
							cutText [format ["JIP transport request option lost, you went beyond %1 meters from your spawn location", GVAR(SPAWNDISTANCE)], 'PLAIN DOWN'];
						};
						} , _checkDelay, [_transportAction]] call CBA_fnc_addPerFrameHandler;
				};
			};
		};
	};
}] call CBA_fnc_waitUntilAndExecute;
