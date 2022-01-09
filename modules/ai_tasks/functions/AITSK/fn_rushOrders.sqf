#include "script_component.hpp"

params ["_group","_target"];

// Helicopters -- supress it!
if ((leader _group distance2d _target < 220) && {vehicle _target isKindOf "Air"}) exitWith {
	(units _group) apply {
		_x commandSuppressiveFire getposASL _target;
	};
};

// Tank -- hide or ready AT
if ((leader _group distance2d _target < 80) && {vehicle _target isKindOf "Tank" || vehicle _target isKindOf "rhs_btr80_msv"}) exitWith {
	(units _group) apply {
		if (secondaryWeapon _x != "") then {
			_x setUnitpos "Middle";
			_x selectWeapon (secondaryWeapon _x);
		} else {
			_x setunitpos "DOWN";
			_x commandSuppressiveFire getposASL _target;
		};
	};

	_group enableGunLights "forceOff";
};

// Default -- run for it!
(units _group) apply {
	_x setunitpos "UP";
	_x domove (getposATL _target);
};

_group enableGunLights "forceOn";
