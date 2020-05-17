/*
 * Author: Olsen
 *
 * Starts tracking all units, except ones with FW_DontTrack set to true.
 *
 * Arguments:
 * none
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#include "..\script_macros.hpp"

{
	if !(GETVAR(_x,DontTrack,false)) then {
		_x call FUNC(TrackUnit);
	};
} forEach allUnits;