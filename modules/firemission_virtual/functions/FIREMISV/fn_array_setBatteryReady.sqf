// Function by Tinfoilhate
// Sets battery ready information from battery name input
// [name,ready,[ammoClass,quantity],guns,dispersion,reloadTime,calcTime,flightTime,delayTime,side]
#include "script_component.hpp"

params ["_name","_status"];

private _ret = [];
private _updatedArray = [];

tin_var_artyBatteries apply {
	_x params ["_bat"];

	if (_name == _bat) then {
		_ret = _status;
		private _temp = _x;

		_temp set [1,_status];

		_updatedArray pushBack _temp;
	} else {
		_updatedArray pushBack _x;
	};
};

["tin_var_artyBatteries",_updatedArray] call FUNC(publicVariable);

_ret
