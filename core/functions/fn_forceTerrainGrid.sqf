/*
 * Author: BlackHawk
 *
 * Force terrain grid to prevent far away objects from appearing as floating.
 * Useful for mission with long engagement ranges.
 *
 * Arguments:
 * none
 *
 * Return Value:
 * nothing
 *
 * Public: Yes
 */

#include "script_component.hpp"

GVAR(terrainGridPFH_handle) = [{
    private _value = GETMVAR(terrainGridValue,3.125);
	if (
        CBA_missionTime > 0 &&
        {getTerrainGrid isNotEqualTo _value}
    ) then {
		setTerrainGrid _value;
	};
}, 1] call CBA_fnc_addPerFrameHandler;
