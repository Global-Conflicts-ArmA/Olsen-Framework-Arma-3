#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_veh"];

private _waitTime = 0.5 + (random 5);

[{
	params ["_veh"];

	_veh setVariable ["GAS_VEHALARM_ON", true, true];

	private _delay = 0.75;

	[{
		params ["_args", "_idPFH"];
		_args params ["_veh"];

		if (!(alive _veh) || !(_veh getVariable "GAS_VEHALARM_ON")) exitWith {
			[_idPFH] call CBA_fnc_removePerFrameHandler;
		};

		GVAR(GASLOGICS) apply {
			private _shotArea = _x getVariable ["GAS_SHOTAREA", 0];
			private _timeOut = _x getVariable ["GAS_TIMEOUT", -1];

			if (_timeOut == -1 || _timeOut > time) then {
				if (_veh distance _x < _shotArea) then {
					if (_veh getVariable "GAS_VEHALARM_ON") then {
						[_veh, ["ABCA_M42", 50]] remoteExec ["say3D"];
					};
				};
			};
		};
	}, _delay, [_veh]] call CBA_fnc_addPerFrameHandler;
}, [_veh], _waitTime] call CBA_fnc_waitAndExecute;
