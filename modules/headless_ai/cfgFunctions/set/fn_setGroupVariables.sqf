#include "..\..\script_macros.hpp"


params ["_group",["_groupSet",[],[[]]]];
_groupSet params [
    /* 0 */ "_side",
    /* 1 */ "_groupPos",
    /* 2 */ "_behaviour",
    /* 3 */ "_combat",
    /* 4 */ "_speed",
    /* 5 */ "_formation",
    /* 6 */ "_groupStance",
    /* 7 */ "_groupInit",
    /* 8 */ "_createRadius",
    /* 9 */ "_taskRadius",
    /* 10 */ "_wait",
    /* 11 */ "_startBld",
    /* 12 */ "_task",
    /* 13 */ "_taskTimer",
    /* 14 */ "_multi",
    /* 15 */ "_occupyOption",
    /* 16 */ "_vehAssigned",
    /* 17 */ "_waypoints",
    /* 18 */ "_onWater",
    /* 19 */ "_fl",
    /* 20 */ "_surrender",
    /* 21 */ "_tracker",
    /* 22 */ "_storedVars",
    /* 23 */ "_name",
    /* 24 */ "_groupID",
    /* 25 */ "_areaAssigned",
    /* 26 */ "_assetType"
];

SETVAR(_group,Pos,_gpos);
SETVAR(_group,behaviour,_behaviour);
SETVAR(_group,combatMode,_combat);
SETVAR(_group,speed,_speed);
SETVAR(_group,formation,_formation);
SETVAR(_group,taskRadius,_taskRadius);
SETVAR(_group,taskWait,_wait);
SETVAR(_group,task,_task);
SETVAR(_group,TaskTimer,_taskTimer);
SETVAR(_group,occupyOption,_occupyOption);
SETVAR(_group,Waypoints,_waypoints);
SETVAR(_group,forceLights,_fl);
SETVAR(_group,surrender,_surrender);
SETVAR(_group,vehicleCargo,_vehicleCargo);
SETVAR(_group,Spawned,true);

//_group call CBA_fnc_clearWaypoints;
[_group,_behaviour,_combat,_speed,_formation] call FUNC(setGroupBehaviour);
{
    if !(isNull (assignedVehicle _x)) then {
        [_x] orderGetIn true;
    };
} forEach (units _group);
if (_fl) then {[_group] call FUNC(setFlashlights);};
if (_surrender) then {[_group] call FUNC(setSurrender);};
_group call _groupinit;
true
