
if (isDedicated) exitWith { };

[_this] spawn {
	params ["_msgArray"];
	private ["_sleepTime"];

	_sleepTime = 0;
	_msgSide = _msgArray # 0 # 2;
	
	if (side player == _msgSide) then {
		_netVar = "tin_var_fireMission_netBusy_" + str(_msgSide);
		
		waitUntil {!(missionNameSpace getVariable _netVar)};
		
		[_netVar, true] call tin_fnc_publicVariable;

		{
			_x params ["_msgChan","_msgText"];
	
			enableRadio true;

			sleep 0.05;

			_sleepTime = (count _msgText) * 0.08;

			[_msgChan,_msgText] call tin_fnc_radio_sysChat;

			enableRadio false;
			sleep _sleepTime;
		} forEach _msgArray;

		[_netVar, false] call tin_fnc_publicVariable;
	};
};