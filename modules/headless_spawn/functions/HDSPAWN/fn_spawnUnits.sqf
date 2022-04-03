/*
 * Author: PiZZADOX & StatusRed
 * Spawns an array of unit types and olsen gear types
 *
 * Arguments:
 * 0: Group Spawn Position <Position>
 * 1: Unit Array in nested format <ARRAY> ([<unit classname>, <gear type>])
 * 2: Side <Side> (default: east)
 *
 * Return Value:
 * Group
 *
 * Example:
 * [[0, 0, 0], [["B_W_Officer_F", "BAF_PL"], ["B_W_Medic_F", "BAF_MED"]], east] call HDSPAWN_fnc_spawnUnits;
 *
 * Public: Yes
 */
#include "script_component.hpp"

params [["_groupPos", [0, 0, 0], [[]]], ["_units", [], [[]]], ["_side", east, [east]]];

private _group = createGroup _side;

LOG_1("Spawning %1 units",(count _units));

_units apply {
    _x params ["_type", "_gear"];
    LOG_2("Spawning: %1 with gear: %2",_type,_gear);
    private _unit = _group createUnit [_type, _groupPos, [], 15, "NONE"];
    [_unit, _gear] call EFUNC(FW,GearScript);
};

_group
