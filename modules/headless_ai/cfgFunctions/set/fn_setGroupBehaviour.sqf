#include "..\..\script_macros.hpp"


params [
    "_grp",
    ["_behaviour","SAFE",[""]],
    ["_combat","RED",[""]],
    ["_speed","LIMITED",[""]],
    ["_formation","WEDGE",[""]]
];
_grp setBehaviour _behaviour;
_grp setCombatMode _combat;
_grp setSpeedMode _speed;
_grp setFormation _formation;
true
