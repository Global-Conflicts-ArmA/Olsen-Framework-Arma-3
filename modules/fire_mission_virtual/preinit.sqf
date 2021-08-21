#include "dia\defs.hpp"

if (isServer) then {
	#include "settings.sqf"

	["tin_var_fireMission_netBusy_WEST", false] call tin_fnc_publicVariable;
	["tin_var_fireMission_netBusy_EAST", false] call tin_fnc_publicVariable;
	["tin_var_fireMission_netBusy_GUER", false] call tin_fnc_publicVariable;
	["tin_var_fireMission_netBusy_CIV", false] call tin_fnc_publicVariable;
};