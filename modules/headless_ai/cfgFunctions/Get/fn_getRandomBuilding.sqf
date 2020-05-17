#include "..\..\script_macros.hpp"


params ["_pos",["_radius",500,[0]],["_rbld",objNull,[objNull]]];
_rbld = selectRandom ([_pos,_radius] call FUNC(getBuildings));
_rbld
