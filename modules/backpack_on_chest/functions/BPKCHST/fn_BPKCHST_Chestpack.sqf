/*
 * Author: DerZade
 * Returns the classname of a unit's chestpack.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Classname <STRING>
 *
 * Example:
 * [player] call zade_boc_fnc_chestpack;
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit"];

private _var = _unit getVariable ["zade_boc_chestpack",nil];

//return ""
if (isNil "_var") exitWith {""};
private _chestpackClass = (_var select 0) select 0;

//return classname
_chestpackClass
