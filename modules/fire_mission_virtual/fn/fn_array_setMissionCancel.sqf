// Function by Tinfoilhate
// Sets battery cancel information from mission id input
// [name,ready,[ammoClass,quantity],guns,dispersion,reloadTime,calcTime,flightTime,delayTime,side]

params ["_name","_status","_side"];

_ret = [];
_updatedArray = [];

_fnc = {
	_x params ["_bat","_cancel","_array"];

	if (_name == _bat) then {
		_updatedArray pushBack [_bat,_status,_array];
	} else {
		_updatedArray pushBack _x;
	};
};

switch (_side) do {
	case west: {
		{call _fnc} forEach tin_var_fireMissions_west;

		["tin_var_fireMissions_west",_updatedArray] call tin_fnc_publicVariable;
	};

	case east: {
		{call _fnc} forEach tin_var_fireMissions_east;

		["tin_var_fireMissions_east",_updatedArray] call tin_fnc_publicVariable;
	};

	case independent: {
		{call _fnc} forEach tin_var_fireMissions_independent;

		["tin_var_fireMissions_independent",_updatedArray] call tin_fnc_publicVariable;
	};

	case civilian: {
		{call _fnc} forEach tin_var_fireMissions_civilian;

		["tin_var_fireMissions_civilian",_updatedArray] call tin_fnc_publicVariable;
	};
};

_ret