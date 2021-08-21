// Function by Tinfoilhate
// Sets battery cancel information from mission id input
// [name,ready,[ammoClass,quantity],guns,dispersion,reloadTime,calcTime,flightTime,delayTime,side]

params ["_name"];

_ret = [];
_updatedArray = [];

_fnc = {
	_x params ["_bat","_cancel"];

	if (_name == _bat) then {
		_ret = _cancel;
	};	
};

switch (_side) do {
	case west: {
		{call _fnc} forEach tin_var_fireMissions_west;
	};
	
	case east: {
		{call _fnc} forEach tin_var_fireMissions_east;
	};

	case independent: {
		{call _fnc} forEach tin_var_fireMissions_independent;
	};

	case civilian: {
		{call _fnc} forEach tin_var_fireMissions_civilian;
	};	
};

_ret