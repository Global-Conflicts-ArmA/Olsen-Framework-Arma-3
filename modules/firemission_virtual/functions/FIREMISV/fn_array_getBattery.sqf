// Function by Tinfoilhate
// Gathers and returns battery information from battery name input
#include "script_component.hpp"

params ["_name"];

private _ret = [];

tin_var_artyBatteries apply {
	_x params ["_bat"];

	if (_name == _bat) then {
		_ret = _x;
	};
};

_ret
