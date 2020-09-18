#include "..\..\script_macros.hpp"


params["_getBld","_bldTask","_groupSet"];
_groupSet params [["_blds",[],[[]]],"_group","_pos",["_radius",0,[0]],["_wait",3,[0]],["_behaviour","SAFE",[""]],["_combat","RED",[""]],["_speed","LIMITED",[""]],["_formation","WEDGE",[""]],["_Type","MOVE",[""]],["_oncomplete","",[""]],["_compradius",0,[0]],["_bldPos",[],[[]]],["_bpos",[],[[]]],["_patrol",false,[false]]];
_group call CBA_fnc_clearWaypoints;
private _bpos = _pos;
if (count _blds < 1) then {
    _blds = [_pos,_radius] call _getBld;
    if (count _blds < 1) then {
        _bpos = _pos;
        _patrol = true;
    } else {
        _bpos = getposatl (_blds select 0);
    };
};
if (_patrol) then {
    if (_radius < 1) then {_radius = 30;};
    [_group,_bpos,_radius,_wait,_behaviour,_combat,_speed,_formation] spawn FUNC(taskPatrol);
} else {
    [0,"ARRAY",1,_bpos,_this] call FUNC(createWaypointModified);
    deleteWaypoint ((waypoints _group) select 0);
    while {{alive _x} count (units _group) <= ((count (units _group)) * 0.5) || (((getPosATL leader _group) distance _bpos) > 50)} do { sleep 5; };
    {
        _x setvariable[QGVAR(Occupy),true];
        private _uBld = _blds select (_forEachIndex % (count _blds));
        _bldPos = _uBld buildingPos -1;
        [_x,_uBld,_bldPos,_wait,[_behaviour,_combat,_speed,_formation]] spawn _bldTask;
    } forEach (units _group);
};
if (GETMVAR(Debug,false)) then {
    if (_patrol) then {
        [_group,_bpos,"BLDERROR PATROL","ColorOPFOR"] call FUNC(debugCreateMarker);
    } else {
        {
            [_group,(getposatl _x),format["gBldP%1",_forEachIndex]] call FUNC(debugCreateMarker);
        } forEach [_blds];
    };
};
SETVAR(_group,InitialWPSet,true);
_group setVariable [QGVAR(Mission),"BLDMOVE"];
[_group] call FUNC(taskRelease);
true
