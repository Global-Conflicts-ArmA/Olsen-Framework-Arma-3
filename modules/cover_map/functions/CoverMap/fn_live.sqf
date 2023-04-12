#include "script_component.hpp"

//Covers Map outside marker and centers map on marker center in game map
if !(hasinterface) exitwith {};
params [
    "_marker",
    ["_centered", true, [true]],
    ["_zoomlevel", 0.4, [0]],
    ["_name", "AO", [""]],
    ["_bgColour", "BH_checkLOS_colorNotVisible", [""]],
    ["_condition", true, [true, {}]]
];

//delete old markers if present
if !(GVAR(map_cover) isEqualTo []) then {
	GVAR(map_cover) apply {deletemarker _x};
	GVAR(map_cover) = [];
};

//for self interact options and logging
GVAR(map_currentAO) = _marker;

_this call FUNC(bordersToMap);

[{visibleMap},{
    params [["_zoomlevel", 0.4, [0.4]], "_pos"];
	MapAnimAdd [0, _zoomlevel, _pos];
	MapAnimCommit;
}, [_zoomlevel, getMarkerPos _marker]] call CBA_fnc_waitUntilAndExecute;
