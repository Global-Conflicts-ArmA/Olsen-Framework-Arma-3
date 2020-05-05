#include "..\..\script_macros.hpp"


params [
    "_group"
];

{
    _x setvariable [QGVAR(BUNKER),true];
} foreach (units _group);
SETVAR(_group,InitialWPSet,true);
_group setVariable [QGVAR(Mission),"BUNKER"];
true
