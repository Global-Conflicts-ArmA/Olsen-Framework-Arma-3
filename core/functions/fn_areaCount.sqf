/*
 * Author: Olsen
 *
 * Counts units on set side in area of set diameter around object.
 *
 * Arguments:
 * 0: side <side>
 * 1: radious <number>
 * 2: center of area <object>
 *
 * Return Value:
 * amount of units in area <number>
 *
 * Public: Yes
 */

#include "..\script_macros.hpp"

params [
	["_side", sideUnknown, [sideUnknown]],
	["_radius", 0, [0]],
	["_logic", objNull, [objNull]],
	["_noUntracked", false, [false]]
];

private _nearMen = _logic nearEntities ["Man", _radius];
private _count = {
	(_x call FUNC(Alive)) &&
	{side _x isEqualTo _side} &&
	{(!(GETVAR(_x,DontTrack,false)) || !_noUntracked)}
} count _nearMen;

_count