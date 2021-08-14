#include "..\..\core\script_macros.hpp"

#include "settings.sqf"

GVAR(boostLastUsed) = 0;

if (hasInterface) then {
	[{CBA_MissionTime > 0}, {
	 	{
			_x addAction ["<t color='#FF0000'>BOOST</t>", {_this call FUNC(VEHBOOST_Boost)}, nil, 10, false, false, "", "(driver _target) isEqualTo _this"];
		} forEach GVAR(vehiclesWithBoost);
	}, []] call CBA_fnc_waitUntilAndExecute;
};
