/*
 * Author: Olsen
 *
 * Creates respawn marker for set team at [0,0,0]
 *
 * Arguments:
 * 0: team <string>
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#include "script_component.hpp"

params ["_team"];

private _markerName = format ["respawn_%1", _team];

private _marker = createMarker [_markerName, [0, 0, 0]];
_marker setMarkerShape "ICON";
_markerName setMarkerType "EMPTY";