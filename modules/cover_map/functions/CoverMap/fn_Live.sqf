#include "script_component.hpp"

//Covers Map outside marker and centers map on marker center in game map
if !(hasinterface) exitwith {};
params ["_marker", ["_centered", true, [true]], ["_zoomlevel", 0.4, [0]], ["_name", "AO", [""]], ["_bgColour", "ColorBlack", [""]]];

//delete old markers if present
if !(GVAR(cover) isEqualTo []) then {
	GVAR(cover) apply {deletemarker _x}; 
	GVAR(cover) = [];
};

//for self interact options and logging
GVAR(currentAO) = _marker;

_this call FUNC(bordersToMap);

[{visibleMap},{
    params [["_zoomlevel", 0.4, [0.4]], "_p"];
	MapAnimAdd [0, _zoomlevel, _p];
	MapAnimCommit;
}, [_zoomlevel, getMarkerPos _marker]] call CBA_fnc_waitUntilAndExecute;