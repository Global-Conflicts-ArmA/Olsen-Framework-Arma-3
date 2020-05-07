/*
 * Author: Olsen
 *
 * Disable tracking of unit by framework.
 * Unit will be ignored in casualty count etc.
 *
 * Arguments:
 * 0: unit to not track <object>
 *
 * Return Value:
 * nothing
 *
 * Public: Yes
 */

#include "..\script_macros.hpp"

params ["_unit"];

if (isServer) then {
	SETVAR(_unit,DontTrack,true);
};