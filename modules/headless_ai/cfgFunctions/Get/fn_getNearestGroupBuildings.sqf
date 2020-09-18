#include "..\..\script_macros.hpp"


params ["_pos",["_radius",500,[0]],["_amount",3,[0]],["_blds",[],[[]]]];
_blds = [_pos,_radius,_amount] call FUNC(getNearestBuildings);
_blds
