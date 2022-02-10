// Function by Tinfoilhate
// Gathers and returns battery side information from battery name input
// [name,ready,[ammoClass,quantity],guns,dispersion,reloadTime,calcTime,flightTime,delayTime,side]
#include "script_component.hpp"

params ["_name"];

private _ret = [];

tin_var_artyBatteries apply {
	_x params ["_bat"];

	if (_name == _bat) then {
		_ret = _x # 9;
	};
};

_ret
