#include "script_component.hpp"


params ["_logic",["_params",[],[[]]]];
private _cond = _logic getVariable [QGVAR(taskCondition),"true"];
private _onComp = _logic getVariable [QGVAR(taskOnComplete),"true"];
if (_cond isEqualType "STRING") then {_cond = compile _cond;};
if (typename _onComp isEqualTo "STRING") then {_onComp = compile _onComp;};
_params = [
    _logic,
    _cond,
    (GETVAR(_logic,TaskPriority,1)),
    (_logic getVariable [QGVAR(TaskTime),-1]),
    _onComp,
    (GETVAR(_logic,TaskId,0)),
    (GETVAR(_logic,taskRadius,100)),
    (GETVAR(_logic,taskSet,4)),
    (GETVAR(_logic,occupyOptionSet,0)),
    (GETVAR(_logic,changetaskWait,3)),
    (_logic getVariable [QGVAR(behaviourChange),"unchanged"]),
    (_logic getVariable [QGVAR(combatMode),"unchanged"]),
    (_logic getVariable [QGVAR(speed),"unchanged"]),
    (_logic getVariable [QGVAR(formation),"unchanged"]),
    (_logic getVariable [QGVAR(Stance),"unchanged"])
];
_params
