/*
 * Author: TheMagnetar
 * Returns all empty positions of a vehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Empty positions <ARRAY>
 *
 * Example:
 * [group player] call fw_fnc_getEmptyPositions
 *
 * Public: No
*/

#include "script_component.hpp"

params ["_vehicle"];

private _emptyPositions = [];

{
    _x params ["_unit", "_role", "_index", "_turretPath"];
    if (isNull _unit) then {
        _role = toLower (_role);
        if (_role in ["cargo", "turret"]) then {
            if (_role isEqualTo "cargo") then {
                _emptyPositions pushBack ["cargo", _index];
            } else {
                _emptyPositions pushBack ["turret", _turretPath];
            };
        } else {
            _emptyPositions pushBack _role;
        };
    };
} forEach (fullCrew [_vehicle, "", true]);

_emptyPositions
