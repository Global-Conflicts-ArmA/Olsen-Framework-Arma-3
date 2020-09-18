#include "..\..\script_macros.hpp"

params ["_group", "_building"];

private _otask = SETVAR(_group,Task,"NONE");
private _leader = leader _group;

SETVAR(_Group,InitialWPSet,true);
SETVAR(_group,Task,"BLDSEARCH");
[_group] call FUNC(taskRelease);
SETVAR(_group,searchingBuilding,true);

private _markerName = format ["PZAI_b_%1",CBA_missionTime];
private _bDebugMarker = [_markerName, getpos _building, "ICON", [1, 1], "TYPE:", "mil_box","COLOR:", "ColorRed"] call CBA_fnc_createMarker;

_group lockWP true;
private _wp = _group addWaypoint [getPos _leader, 0, currentWaypoint _group];
private _cond = QUOTE(!(QGETVAR((group (thisList select 0)),searchingBuilding,false)));
//private _cond = QUOTE((({unitReady _x || !(alive _x)} count thisList) isEqualTo count thisList) && {!(QGETVAR((group (thisList select 0)),searchingBuilding,false))});
private _comp = format [QUOTE(this setFormation '%1'; this setBehaviour '%2'; deleteWaypoint [ARR_2(group this, currentWaypoint (group this))];),(formation _group),(behaviour _leader)];
_wp setWaypointStatements [_cond,_comp];

_group setFormDir (_leader getDir _building);

//IGNORE_PRIVATE_WARNING ["_x"]
private _positions = [_building buildingPos -1, [], {_x select 2}] call BIS_fnc_sortBy;
private _totalPositions = count _positions;

private _units = units _group;
private _coverTeam = [];
if (count (units _group) > 8) then {
    _coverTeam = [(_units deleteAt (_units find _leader))];
    private _helperUnit = selectRandom _units;
    _coverTeam pushBack _helperUnit;
    private _helperUnit = selectRandom _units;
    _coverTeam pushBack _helperUnit;
    private _helperUnit = selectRandom _units;
    _coverTeam pushBack _helperUnit;
} else {
    if (count (units _group) >= 4) then {
        _coverTeam = [(_units deleteAt (_units find _leader))];
        private _helperUnit = _units select floor random (count _units);
        _coverTeam pushBack _helperUnit;
    };
};

if !(_coverTeam isEqualTo []) then {
    //set leader and helper to cover 
    {
        private _unit = _x;
        doStop _unit;
        _unit setUnitPos "MIDDLE";
    } foreach _coverTeam;
};

private _assaultUnits = _units - _coverTeam;
private _teams = [];

for "_u" from 0 to ((count _assaultUnits) - 1) step 2 do {
    if (_positions isEqualTo []) then {
        private _team = [_assaultUnits select _u];
        if (count _assaultUnits >= (_u + 1)) then {
            _team pushBack (_assaultUnits select (_u + 1));
        };
        {
            private _unit = _x;
            doStop _unit;
            _unit setUnitPos "MIDDLE";
        } foreach _team;
    } else {
        private _team = [_assaultUnits select _u];
        if (count _assaultUnits >= (_u + 1)) then {
            _team pushBack (_assaultUnits select (_u + 1));
        };
        private _pos = _positions deleteAt 0;
        _teams pushBack [_pos, _team];
        {
            doStop _x;
            _x doMove _pos;
        } forEach _team;
        //"Sign_Arrow_F" createvehicle [_pos select 0, _pos select 1, (_pos select 2) + 2.5];
        //LOG_2("sending team to pos: %1 remaining positions: %2",_pos,count _positions);
    };
};

[{
    params ["_args", "_idPFH"];
    _args params [
        "_group", 
        "_building", 
        "_otask", 
        "_positions",
        "_coverTeam",
        ["_teams", [], [[]]],
        "_bDebugMarker",
        "_totalPositions",
        ["_clearedPositions", 0, [0]],
        "_lastTimeChanged",
        ["_debugSet", false, [false]]
    ];
    //LOG_1("_args: %1",_args);
    private _units = units _group;
    if (_units isEqualTo []) exitWith {
        SETVAR(_group,searchingBuilding,false);
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    
    _teams select {
        ({alive _x} count (_x select 1)) == 0
    } apply {
        _positions pushback (_x select 0);
        //LOG_1("pos: %1 readded from dead team",(_x select 0));
    };
    
    private _waitedTime = (CBA_missionTime - _lastTimeChanged);
    //LOG_1("_waitedTime: %1",_waitedTime);
    if ((_waitedTime >= 25) || (_clearedPositions >= _totalPositions) || ((CBA_missionTime - (GETVAR(_building,searched,(CBA_missionTime)))) > 600)) exitWith {
        {
            _x doFollow leader _x;
            _x setUnitPos "AUTO";
        } forEach _units;
        _group lockWP false;
        SETVAR(_group,Mission,_otask);
        //LOG_1("exited bld search for group: %1 on complete",_group);
        SETVAR(_building,searched,CBA_missionTime);
        SETVAR(_group,searchingBuilding,false);
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _bDebugMarker setMarkerColor "ColorBlue";
    };
    //private _leader = leader _group;
    
    private _assaultUnits = _units - _coverTeam;
    
    //LOG_4("group: %1 pos counts: %2 coverteam: %3 team count: %4",_group,(count _positions),_coverTeam,(count _teams));
    
    if (count _assaultUnits <= 1) then {
        _args set [4, []];
        _assaultUnits = _assaultUnits + _units;
        private _lastTeam = _teams select 0;
        _lastTeam params ["_pos", "_members"];
        _members append _assaultUnits;
        _teams = [];
        _lastTimeChanged = CBA_missionTime;
        _args set [9, _lastTimeChanged];
    };
    
    private _aliveTeams = _teams select {({alive _x} count (_x select 1)) >= 1};
    
    {
        _x params ["_pos", "_members"];
        _members = _members select {alive _x};
        if (
            ((_members select 0) distance _pos) <= 2.5
        ) then {
            _clearedPositions = _clearedPositions + 1;
            _lastTimeChanged = CBA_missionTime;
            _args set [9, _lastTimeChanged];
            //LOG_2("team reached pos: %1 team members: %2",_pos,_members);
            if !(_positions isEqualTo []) then {
                _pos = _positions deleteAt 0;
                //"Sign_Arrow_F" createvehicle [_pos select 0, _pos select 1, (_pos select 2) + 2.5];
                //LOG_2("sending team to pos: %1 remaining positions: %2",_pos,count _positions);
                {
                    _x doMove _pos;
                } forEach _members;
            };
        };
        //LOG_2("team pos: %1 member count: %2",_pos,(count _members));
        _x set [0, _pos];
        _x set [1, _members];
    } forEach _aliveTeams;
    
    _args set [3, _positions];
    _args set [5, _aliveTeams];
    _args set [8, _clearedPositions];
    
    if (!(_debugSet) && {(_clearedPositions > (count _positions))}) then {
        _debugSet = true;
        _args set [10, _debugSet];
        _bDebugMarker setMarkerColor "ColorYellow";
    };
    
    //LOG_3("group: %1 cleared pos: %2 total pos: %3",_group,_clearedPositions,_totalPositions); 
    
}, 5, [_group, _building, _otask, _positions, _coverTeam, _teams, _bDebugMarker, _totalPositions, 0, (CBA_missionTime + 10)]] call CBA_fnc_addPerFrameHandler;
