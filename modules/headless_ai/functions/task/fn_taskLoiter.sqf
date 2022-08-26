#include "script_component.hpp"


params [
    "_group",
    "_pos",
    ["_radius", 30, [0]],
    ["_wait", 3, [0]],
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]]
];

_group setVariable [QGVAR(Task),"LOITER"];
[_group] call FUNC(taskRelease);

//We need a list of actions that the AI can do for loitering.
private _units = units _group;
_units apply {
    if (_x isEqualTo (vehicle _x)) then {
        //Each AI will need to join their own group. The plan is to make them re-form when combat starts.
        //[_x] joinsilent grpnull;
        //(group _x) setVariable [QGVAR(Mission),"LOITERING"];
        _x setVariable [QGVAR(LOITERINGACT),0];
        [_x, _units] spawn FUNC(LoiterAction);
    };
};
true
