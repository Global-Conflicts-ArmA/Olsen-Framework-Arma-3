/*
 * Author: BlackHawk
 *
 * Check if item classname is valid.
 *
 * Arguments:
 * 0: classname <string>
 *
 * Return Value:
 * is valid <bool>
 *
 * Public: No
 */

#include "script_component.hpp"

params [
	["_class", "", [""]],
	["_unit", objNull, [objNull]]
];

private _result = (isClass (configfile >> "CfgWeapons" >> _class)
|| {(isClass (configFile >> "CfgMagazines" >> _class))}
|| {(isClass (configFile >> "CfgGlasses" >> _class))}
|| {(isClass (configFile >> "CfgVehicles" >> _class))}
);

if !(_result) then {
	if !(isMultiplayer) then {
        ERROR_1("Invalid classname given! - %1",_class);
	};
	[_class, {
		params ["_class"];
		if (isNil QGVAR(missing_gear_found)) then {
            GVAR(missing_gear_found) = [_class];
		} else {
            ERROR_1("Framework has detected an invalid classname - %1! Mission will continue but some parts of gear will be missing.",str _class);
            if !((GVAR(missing_gear_found) findif {_x isEqualTo _class}) isEqualTo -1) then {
				GVAR(missing_gear_found) pushBackUnique _class;
			};
		};
	}] remoteExec ["BIS_fnc_call", 0, true];

	if !(isNull _unit) then {
		[_class, _unit] remoteExecCall [QFUNC(makeUnitsList), 2, false];
	};
};

_result