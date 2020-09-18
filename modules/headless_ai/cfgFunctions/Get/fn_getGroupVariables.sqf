#include "..\..\script_macros.hpp"


params ["_grp",["_vars",[],[[]]]];
_vars = [
    _grp getVariable [QGVAR(GroupPos),[]],
    _grp getVariable [QGVAR(behaviour),'safe'],
    _grp getVariable [QGVAR(combatMode),'red'],
    _grp getVariable [QGVAR(speed),'limited'],
    _grp getVariable [QGVAR(formation),'wedge'],
    _grp getVariable [QGVAR(taskRadius),30],
    _grp getVariable [QGVAR(taskWait),3],
    _grp getVariable [QGVAR(task),4],
    _grp getVariable [QGVAR(TaskTimer),0],
    _grp getVariable [QGVAR(occupyOption),0],
    _grp getVariable [QGVAR(Waypoints),[]],
    _grp getVariable [QGVAR(tasks),[]],
    _grp getVariable [QGVAR(forceLights),false],
    _grp getVariable [QGVAR(surrender),false],
    _grp getVariable [QGVAR(Tracker),false]
];
_vars
