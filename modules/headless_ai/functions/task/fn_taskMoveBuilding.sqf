#include "script_component.hpp"


params ["_getBld","_bldTask","_groupSet"];
_groupSet params [
    /* 0 */  ["_side", west, [west]],
    /* 1 */  ["_groupPos", [], [[]]],
    /* 2 */  ["_behaviour", "AWARE", [""]],
    /* 3 */  ["_combat", "YELLOW", [""]],
    /* 4 */  ["_speed", "normal", [""]],
    /* 5 */  ["_formation", "wedge", [""]],
    /* 6 */  ["_groupStance", "AUTO", [""]],
    /* 7 */  ["_groupInit", false, [false, {}, ""]],
    /* 8 */  ["_createRadius", 0, [0]],
    /* 9 */  ["_taskRadius", 30, [0]],
    /* 10 */ ["_taskWait", 3, [0]],
    /* 11 */ ["_startBuilding", false, [false]],
    /* 12 */ ["_task", "PATROL", [""]],
    /* 13 */ ["_taskTimer", 0, [0]],
    /* 14 */ ["_multi", 1, [1]],
    /* 15 */ ["_occupy", "Off", ["", 0]],
    /* 16 */ ["_vehAssigned", false, [false]],
    /* 17 */ ["_waypoints", [], [[]]],
    /* 18 */ ["_surfaceWater", false, [false]],
    /* 19 */ ["_fl", false, [false]],
    /* 20 */ ["_surrender", false, [false]],
    /* 21 */ ["_storedVars", [], [[]]],
    /* 22 */ ["_name", "", [""]],
    /* 23 */ ["_groupID", "", [""]],
    /* 24 */ ["_areaAssigned", "NONE", [""]],
    /* 25 */ ["_assetType", "INFANTRY", [""]]
];

_group call CBA_fnc_clearWaypoints;
private _bpos = _pos;
if (isNull _bld) then {
    _bld = [_pos,_radius] call _getBld;
    if (isNull _bld) then {
        _bpos = _pos;
        _patrol = true;
    } else {
        _bpos = getposatl _bld;
        if (_bldPos isEqualTo []) then {_bldPos = _bld buildingPos -1;};
    };
};
if (_patrol) then {
    if (_radius < 1) then {_radius = _radius + 30;};
    [_group,_bpos,_radius,_wait,_behaviour,_combat,_speed,_formation] spawn FUNC(taskPatrol);
} else {
    [0,"OBJECT",1,_bpos,_this] call FUNC(createWaypointModified);
    deleteWaypoint ((waypoints _group) select 0);
    while {{alive _x} count (units _group) <= ((count (units _group)) * 0.5) || (((getPosATL leader _group) distance _pos) > 50)} do { sleep 5; };
    {
        _x setvariable[QGVAR(Occupy),true];
        [_x,_bld,_bldPos,_wait,[_behaviour,_combat,_speed,_formation]] spawn _bldTask;
    } forEach (units _group);
};
if (GETMVAR(Debug,false)) then {
    if (_patrol) then {
        // Where is debugCreateMarker declared?
        [_group,_bpos,"BLDERROR PATROL","ColorOPFOR"] call FUNC(debugCreateMarker);
    } else {
        [_group,_bpos,"rBldP"] call FUNC(debugCreateMarker);
    };
};
_group setVariable [QGVAR(Mission),"BLDMOVE"];
