/*
 * Author: Olsen
 *
 * Checks if unit is within area of marker, supports all shapes.
 *
 * Arguments:
 * 0: unit <object>
 * 1: marker <string>
 *
 * Return Value:
 * is unit in marker <bool>
 *
 * Public: Yes
 */

params [
	["_unit", objNull, [objNull]],
	["_marker", "", [""]]
];

(_unit inArea _marker)