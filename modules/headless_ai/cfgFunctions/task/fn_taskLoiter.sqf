#include "..\..\script_macros.hpp"


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

SETVAR(_group,InitialWPSet,true);
_group setVariable [QGVAR(Mission),"LOITER"];

//We need a list of actions that the AI can do for loitering.
private _UnitArray = units _group;
{
    if (_x isEqualTo (vehicle _x)) then {
        //Each AI will need to join their own group. The plan is to make them re-form when combat starts.
        //[_x] joinsilent grpnull;
        //(group _x) setVariable [QGVAR(Mission),"LOITERING"];
        _x setVariable [QGVAR(LOITERINGACT),0];
        [_x,_UnitArray] spawn FUNC(LoiterAction);
    };
} foreach _UnitArray;
[_group] call FUNC(taskRelease);
true
