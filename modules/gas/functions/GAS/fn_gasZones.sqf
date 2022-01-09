#include "script_component.hpp"

//Example, to be run only once, SERVER ONLY: ["GAS_ZONES", _gasLogic] call CBA_fnc_serverEvent;
/* LOG("In gasZones.."); */

if (!isDedicated && hasInterface) then {
	params ["_gasLogic"];

	private _shotPos = getPosATL _gasLogic;
	private _gasTrig = objNull;

	/* LOG_1("Gas logic = %1", _gasLogic); */

	private _shotArea = _gasLogic getVariable QGVAR(SHOTAREA);
	private _timeOut = _gasLogic getVariable QGVAR(TIMEOUT);

	/* LOG_1("GAS_SHOTAREA = %1", _shotArea); */
	/* LOG_1("GAS_TIMEOUT = %1", _timeOut); */

	if !((isNil "_shotArea") && (isNil "_timeOut")) then {
		/* LOG_2("_shotArea = %1 _timeOut = %2", _shotArea, _timeOut); */

		if (_timeOut == -1 || _timeOut > CBA_missionTime) then {
			_gasTrig = createTrigger ["EmptyDetector", _shotPos, false];
			/* LOG_2("Trigger created at: %1, player is at: %2", _shotPos, (getPos player)); */
			_gasTrig setTriggerArea [_shotArea, _shotArea, 0, false, _shotArea];
			_gasTrig setTriggerActivation ["ANYPLAYER", "PRESENT", true];
			_gasTrig setTriggerStatements ["player in thisList || (vehicle player) in thisList","GAS_AREALIST pushBack thisTrigger;","GAS_AREALIST = GAS_AREALIST - [thisTrigger];"];
			/* LOG_1("_gasTrig area = %1", triggerArea _gasTrig); */
		};

		if (_timeOut != -1 && _timeOut > CBA_missionTime) then {
			[{(_this select 1) <= CBA_missionTime}, {
				GVAR(AREALIST) = GVAR(AREALIST) - [(_this select 0)];
				deleteVehicle (_this select 0);
			}, [_gasTrig, _timeOut]] call CBA_fnc_waitUntilAndExecute;
		};
	};
};
