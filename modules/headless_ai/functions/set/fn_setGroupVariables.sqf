#include "script_component.hpp"


params ["_group",["_groupSet",[],[[]]]];

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

SETVAR(_group,Pos,_groupPos);
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

SETVAR(_group,OriginalTask,_task);

//_group call CBA_fnc_clearWaypoints;
[_group,_behaviour,_combat,_speed,_formation] call FUNC(setGroupBehaviour);
{
    if !(isNull (assignedVehicle _x)) then {
        [_x] orderGetIn true;
    };
} forEach (units _group);
if (_fl) then {[_group] call FUNC(setFlashlights);};
if (_surrender) then {[_group] call FUNC(setSurrender);};
if (_groupInit isEqualType {}) then {
    _group call _groupinit
};
