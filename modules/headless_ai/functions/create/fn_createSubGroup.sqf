#include "script_component.hpp"

params [
    ["_side", west, [west]], /*side*/ 
    ["_oldGroup", grpNull, [grpNull]], /*old group*/ 
    ["_newUnits", [], [[]]], /*new units*/ 
    ["_newTask", "PATROL", [""]], /*new task*/ 
    ["_newPos", [], [[]]], /*new taskPos*/ 
    ["_newRadius", 50, [50]], /*new radius*/ 
    ["_rejoinCondition", false, [{}, false]] /*condition to rejoin old group*/ 
];

if (GETMVAR(VerboseDebug,false)) then {
    TRACE_3("createSubGroup called",_side,_oldGroup,_newUnits);
};

private _group = createGroup _side;
_newUnits joinSilent _group;
private _newLeader = leader _group;
if (assignedVehicle _newLeader isNotEqualTo objNull) then {
    _group leaveVehicle assignedVehicle _newLeader
};
_newUnits orderGetIn false;
_newUnits apply {
    unassignVehicle _x
};
[
    _group,
    behaviour leader _oldGroup,
    combatMode _oldGroup,
    speedMode _oldGroup,
    formation _group
] call FUNC(setGroupBehaviour);

private _passarray = [
    _group,
    _newTask,
    _newPos,
    _newRadius,
    _oldGroup getVariable [QGVAR(taskWait),3],
    behaviour leader _oldGroup,
    combatMode _oldGroup,
    speedMode _oldGroup,
    formation _group
];

SETVAR(_group,Pos,getPos _newLeader);
SETVAR(_group,behaviour,behaviour leader _oldGroup);
SETVAR(_group,combatMode,combatMode _oldGroup);
SETVAR(_group,speed,speedMode _oldGroup);
SETVAR(_group,formation,formation _group);
SETVAR(_group,taskRadius,_newRadius);
SETVAR(_group,taskWait,_oldGroup getVariable [QGVAR(taskWait),3]);
SETVAR(_group,task,_newTask);
SETVAR(_group,TaskTimer,0);
SETVAR(_group,occupyOption,false);
SETVAR(_group,Waypoints,[]);
SETVAR(_group,forceLights,false);
SETVAR(_group,surrender,false);
SETVAR(_group,vehicleCargo,false);
SETVAR(_group,Spawned,true);
SETVAR(_group,OriginalTask,_newTask);

[{(count waypoints (_this select 0)) isNotEqualTo 0},{
    _this call FUNC(taskAssign);
}, _passarray] call CBA_fnc_waitUntilAndExecute;

if (_rejoinCondition isEqualType {}) then {
    
    private _conditionTest = call _rejoinCondition;
    if !(_conditionTest isEqualType false) then {
        ERROR_2("condition must return bool false or true", _group, _rejoinCondition);
    };
    
    [{
        params ["_argNested", "_idPFH"];
        _argNested params [
            ["_group", grpNull, [grpNull]],
            ["_oldGroup", grpNull, [grpNull]],
            ["_rejoinCondition", {false}, [{}]]
        ];
        private _units = units _group;
        if (_group isEqualTo grpNull || _oldGroup isEqualTo grpNull || _units isEqualTo [] || units _oldGroup isEqualTo []) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
        if (call _rejoinCondition) then {
             _units joinSilent _oldGroup;
             deleteGroup _group;
        };
    }, 5, [
        _group,
        _oldGroup,
        _rejoinCondition
    ]] call CBA_fnc_addPerFrameHandler;
};

_group
