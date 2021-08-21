// Function by Tinfoilhate
// Sets battery ammo information from battery name input
// [name,ready,[ammoClass,quantity],guns,dispersion,reloadTime,calcTime,flightTime,delayTime,side]

params ["_name","_targetClass","_value"];

_ret = [];
_updatedAmmo = [];
_updatedArray = [];

{
	_x params ["_bat","_ready","_ammoArray"];

	if (_name == _bat) then {
		_updatedAmmo = [];

		{
			_x params ["_class","_qty"];

			if (_class == _targetClass) then {
				if (_qty - _value > 0) then {
					_updatedAmmo pushback [_class,_value];
				};
			} else {
				_updatedAmmo pushback _x;
			};
		} forEach _ammoArray;

		_temp = _x;
		_temp set [2,_updatedAmmo];

		_updatedArray pushBack _temp;
	} else {
		_updatedArray pushBack _x;
	};
} forEach tin_var_artyBatteries;

["tin_var_artyBatteries",_updatedArray] call tin_fnc_publicVariable;

_ret