/*
 * Author: TinfoilHate
 * Checks to see if a vehicle position is crew or cargo/FFV.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [player, "rhs_tsh4"] call FW_fnc_CVCCHECK_vehCheck
 *
 * Public: No
*/

#include "script_component.hpp"

params ["_unit","_veh"];
private ["_turretList","_vehRole","_valid"];

_valid = false;

_turretList = allTurrets [_veh,true] - allTurrets [_veh,false];

if (_veh isKindOf "Tank" || _veh isKindOf "Wheeled_APC_F") then {
	_vehRole = assignedVehicleRole _unit;

	if (_vehRole select 0 == "Turret") then {
		if !(_vehRole select 1 in _turretList) then {
			_valid = true;
		};
	};

	if (_vehRole select 0 == "Driver") then {
		_valid = true
	};
};

_valid
