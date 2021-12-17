#include "script_component.hpp"

#include "..\..\settings.sqf"

if !(hasInterface) exitWith {};

if ((GVAR(JIPTYPE) isEqualTo "DENY") && {missionNamespace getVariable [QGVAR(JIPDenied), false]}) exitWith {
	[{
		player call EFUNC(FW,UntrackUnit);
		player setDamage 1;
		[{
		    cutText ["This mission does not support JIP.", "PLAIN DOWN"];
		}, [], 8] call CBA_fnc_waitAndExecute;
	}, [], 5] call CBA_fnc_waitAndExecute;
};

private _target = leader player;

if (player isEqualTo _target || !(_target call EFUNC(FW,isAlive))) then {
	private _rank = -1;
	((units group player) - [player]) apply {
		if ((rankId _x > _rank) && {(_target call EFUNC(FW,isAlive))}) then {
			_rank = rankId _x;
			_target = _x;
		};
	};
};

if ((_target distance player) > GVAR(JIPDISTANCE)) then {
	private _checkDelay = 60;

	switch (GVAR(JIPTYPE)) do {

		case "TELEPORT": {
			private _teleportAction = player addAction ["Teleport to Squad", "modules\jip\teleportAction.sqf", _target];

			[{
				_this params ["_args", "_idPFH"];
				_args params ["_teleportAction"];
				private _spawnPos = getPosATL player;

				if (player distance _spawnPos > GVAR(SPAWNDISTANCE)) exitWith {
					player removeAction _teleportAction;
					cutText [format ["JIP teleport option lost, you went beyond %1 meters from your spawn location", GVAR(SPAWNDISTANCE)], 'PLAIN DOWN'];
					[_idPFH] call CBA_fnc_removePerFrameHandler;
				};
				}, _checkDelay, [_teleportAction]] call CBA_fnc_addPerFrameHandler;
		};

		case "TRANSPORT": {
			private _transportAction = player addAction ["Request Transport", "modules\jip\transportAction.sqf"];

			[{
				_this params ["_args", "_idPFH"];
				_args params ["_transportAction"];
				private _spawnPos = getPosATL player;

				if (player distance _spawnPos > GVAR(SPAWNDISTANCE)) exitWith { //Exitwith ends the loop
					player removeAction _transportAction;
					cutText [format ["JIP transport request option lost, you went beyond %1 meters from your spawn location", GVAR(SPAWNDISTANCE)], 'PLAIN DOWN'];
					[_idPFH] call CBA_fnc_removePerFrameHandler;
				};
				}, _checkDelay, [_transportAction]] call CBA_fnc_addPerFrameHandler;
		};
	};
};
