#include "script_component.hpp"

if (isDedicated) exitWith { };
[_this] spawn {
	params ["_msgArray"];

	private _sleepTime = 0;
	private _msgSide = _msgArray # 0 # 2;

	if (side player == _msgSide) then {
		private _netVar = "tin_var_fireMission_netBusy_" + str(_msgSide);

		waitUntil {!(missionNameSpace getVariable _netVar)};

		[_netVar, true] call FUNC(publicVariable);

		_msgArray apply {
			_x params ["_msgChan", "_msgText"];

			enableRadio true;

			sleep 0.05;

			_sleepTime = (count _msgText) * 0.08;

			[_msgChan, _msgText] call FUNC(radio_sysChat);

			enableRadio false;
			sleep _sleepTime;
		};

		[_netVar, false] call FUNC(publicVariable);
	};
};
