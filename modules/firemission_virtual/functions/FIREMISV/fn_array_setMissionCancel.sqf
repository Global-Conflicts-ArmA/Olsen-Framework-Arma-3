// Function by Tinfoilhate
// Sets battery cancel information from mission id input
// [name,ready,[ammoClass,quantity],guns,dispersion,reloadTime,calcTime,flightTime,delayTime,side]
#include "script_component.hpp"

params ["_name", "_status", "_side"];

private _ret = [];
private _updatedArray = [];

private _fnc = {
	_x params ["_bat", "_cancel", "_array"];

	if (_name == _bat) then {
		_updatedArray pushBack [_bat, _status, _array];
	} else {
		_updatedArray pushBack _x;
	};
};

switch (_side) do {
	case west: {
		tin_var_fireMissions_west apply {call _fnc};

		["tin_var_fireMissions_west", _updatedArray] call FUNC(publicVariable);
	};

	case east: {
		tin_var_fireMissions_east apply {call _fnc};

		["tin_var_fireMissions_east", _updatedArray] call FUNC(publicVariable);
	};

	case independent: {
		tin_var_fireMissions_independent apply {call _fnc};

		["tin_var_fireMissions_independent", _updatedArray] call FUNC(publicVariable);
	};

	case civilian: {
		tin_var_fireMissions_civilian apply {call _fnc};

		["tin_var_fireMissions_civilian", _updatedArray] call FUNC(publicVariable);
	};
};

_ret
