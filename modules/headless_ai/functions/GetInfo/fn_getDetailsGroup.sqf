#include "script_component.hpp"

params [
    "_unit",
    ["_pos",[],[[]]]
];

private _group = group _unit;
private _init = GETVAR(_group,Init,"");
if (_init isEqualType "") then {
    if (_init isNotEqualTo "") then {
         _init = compile _init;
    } else {
         _init = false;
    };
};
private _occupy = GETVAR(_group,occupy,"Off");
if (_occupy isNotEqualTo "Off") then {_occupy = floor(random [2,5,7])};
if (_pos isEqualTo []) then {
    _pos = (getposATL _unit) apply {parseNumber (_x toFixed 2)};
};
private _groupID = GETVAR(_group,groupID,"");
private _areaAssigned = GETVAR(_group,areaAssigned,"NONE");
private _assetType = GETVAR(_group,assetType,"INFANTRY");
private _taskPos = GETVAR(_group,taskPos,[ARR_3(0,0,0)]);
private _vehAssigned = ((assignedVehicleRole _unit) isNotEqualTo []);
private _waypoints = [waypoints _unit] call FUNC(getWaypointDetails);
//private _taskArray = [] call EFUNC(tasks,getTaskInfoGroup);
private _commanderArray = [];
private _storedVars = GETVAR(_group,storedVars,[]);
private _defaultTask = ["PATROL", "STATIONARY"] select (INVEHICLE(_unit));
private _getTask = _group getVariable [QGVAR(task), _defaultTask];
TRACE_2("",_group,_storedVars);

[side _unit,
_pos,
behaviour _unit,
combatMode _group,
speedMode _group,
formation _group,
GETVAR(_group,Stance,"AUTO"),
_init,
GETVAR(_group,createRadius,0),
GETVAR(_group,taskRadius,30),
GETVAR(_group,taskWait,3),
GETVAR(_group,startBuilding,false),
_getTask,
GETVAR(_group,TaskTimer,0),
GETVAR(_group,multiplier,0),
_occupy,
_vehAssigned,
_waypoints,
surfaceIsWater getposATL _unit,
GETVAR(_group,forceLights,false),
GETVAR(_group,surrender,false),
_storedVars,
GETVAR(_group,varName,""),
GETVAR(_group,groupID,""),
_areaAssigned,
_assetType]
