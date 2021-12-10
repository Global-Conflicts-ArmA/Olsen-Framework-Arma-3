#include "..\..\script_macros.hpp"


params ["_getBld","_bldTask","_groupSet"];
_groupSet params [["_bld",objNull,[objNull]],"_group","_pos",["_radius",0,[0]],["_wait",3,[0]],["_behaviour","SAFE",[""]],["_combat","RED",[""]],["_speed","LIMITED",[""]],["_formation","WEDGE",[""]],["_Type","MOVE",[""]],["_oncomplete","",[""]],["_compradius",0,[0]],["_bldPos",[],[[]]],["_patrol",false,[false]]];
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
SETVAR(_group,InitialWPSet,true);
_group setVariable [QGVAR(Mission),"BLDMOVE"];
[_group] call FUNC(taskRelease);
true
