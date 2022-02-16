// Function by Tinfoilhate
// Sets battery cancel information from mission id input
// [name,ready,[ammoClass,quantity],guns,dispersion,reloadTime,calcTime,flightTime,delayTime,side]
#include "script_component.hpp"

params ["_name"];

private _ret = [];
private _updatedArray = [];

private _fnc = {
	_x params ["_bat","_cancel"];

	if (_name == _bat) then {
		_ret = _cancel;
	};
};

switch (_side) do {
	case west: {
		tin_var_fireMissions_west apply {call _fnc};
	};

	case east: {
		tin_var_fireMissions_east apply {call _fnc};
	};

	case independent: {
		tin_var_fireMissions_independent apply {call _fnc};
	};

	case civilian: {
		tin_var_fireMissions_civilian apply {call _fnc};
	};
};

_ret
