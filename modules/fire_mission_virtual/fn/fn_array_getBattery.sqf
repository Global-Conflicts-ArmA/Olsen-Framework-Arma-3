// Function by Tinfoilhate
// Gathers and returns battery information from battery name input

params ["_name"];

_ret = [];

{	
	_x params ["_bat"];

	if (_name == _bat) then {
		_ret = _x;
	};	
} forEach tin_var_artyBatteries;

_ret