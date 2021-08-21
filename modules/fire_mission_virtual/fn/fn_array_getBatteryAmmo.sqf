// Function by Tinfoilhate
// Gathers and returns battery ammo information from battery name input
// [name,ready,[ammoClass,quantity],guns,dispersion,reloadTime,calcTime,flightTime,delayTime,side]

params ["_name"];

_ret = [];

{
	_x params ["_bat"];

	if (_name == _bat) then {
		_ret = _x # 2;
	};
} forEach tin_var_artyBatteries;

_ret