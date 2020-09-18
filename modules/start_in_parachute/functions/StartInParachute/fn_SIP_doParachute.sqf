#include "script_component.hpp"

params ["_target", "_elev", ["_rand", 100], ["_steer", false], ["_class", (["NonSteerable_Parachute_F", "rhs_d6_Parachute"] select (isClass (configFile >> "CfgVehicles" >> "rhs_d6_Parachute")))]];

private _doPara = false;

if (_steer) then {
	_class = "Steerable_Parachute_F";

};

if (typeName _target == "SIDE") then {

	if (side player isEqualTo _target) then {
		_doPara = true;

	};

};

if (typeName _target == "ARRAY") then {

	_target apply {
		if (player isEqualTo _x) then {
			_doPara = true;

		};
	};

};

if (typeName _target == "OBJECT") then {

	if (player isEqualTo _target) then {
		_doPara = true;

	};

};

if (!_doPara) exitwith {};

[{!(isNull player)}, {
	private _elevation = _this select 0;
	private _randelev = _this select 1;
	private _classname = _this select 2;

	private _random = floor (random _randelev);
	private _chute = _classname createVehicle [0, 0, 0];
	_chute setPosATL [getPosatl player select 0, getPosatl player select 1, _elevation + _random];
	player moveIndriver _chute;
}, [_elev, _rand, _class]] call CBA_fnc_waitUntilAndExecute;
