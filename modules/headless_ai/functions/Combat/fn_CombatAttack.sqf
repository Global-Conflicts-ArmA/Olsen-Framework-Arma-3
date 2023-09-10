#include "script_component.hpp"

params ["_group", "_targetPos", ["_radius", 50, [50]]];

// rewrite combat attack function to be more aggressive - or completely replace with assault
[_group, _targetPos, _radius] call FUNC(combatAssault);

//private _enemyDir = leader _group getDir _targetPos;
//
////private _formation = if ((random 2) > 1) then {"LINE"} else {"WEDGE"};
////_group setFormation _formation;
//_group setFormDir _enemyDir;
//
//[_group] call CBA_fnc_clearWaypoints;
//[_group, _targetPos, _radius, "SAD", "COMBAT", "RED"] call CBA_fnc_addWaypoint;
