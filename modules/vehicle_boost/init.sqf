["Vehicle Boost", "Module to provide boost functionality to vehicles.", "StatusRed"] call FNC_RegisterModule;

#include "settings.sqf"

if (hasInterface) then {
	[{time > 0}, {
	 	{
			_x addAction ["<t color='#FF0000'>BOOST</t>", {_this call FNC_Boost}, nil, 10, false, false, "", "(driver _target) isEqualTo _this"];
		} forEach FW_vehiclesWithBoost;
	}, []] call CBA_fnc_waitUntilAndExecute;
};
