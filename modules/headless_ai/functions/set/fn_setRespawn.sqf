#include "script_component.hpp"


params [["_logic",objNull,[objNull]],["_marker","respawn_west",[""]]];
{
    private _side = _x;
    switch (_side) do {
        case WEST: {_marker = "respawn_west";};
        case EAST: {_marker = "respawn_east";};
        case INDEPENDENT: {_marker = "respawn_guerrila";};
        case CIVILIAN: {_marker = "respawn_Civ";};
        default {};
    };
    if (_marker in allMapMarkers) then {
        _marker setMarkerPos (getPos _logic);
    } else {
        createMarker [_marker, getPos _logic];
    };
    {
        private _unit = _x;
    } forEach (allUnits select {side _x isEqualTo _side});
} forEach ([GETVAR(_logic,respawnside,0)] call FUNC(getSide));
true
