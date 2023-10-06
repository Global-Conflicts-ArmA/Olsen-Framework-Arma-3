#include "script_component.hpp"


//FUNC(CombatResponse)

params [
    "_group",
    ["_radioEnemy", objNull, [objNull]]
];

private _leader = leader _group;
if (behaviour _leader isEqualTo "SAFE") then {
	_group setbehaviour "AWARE";
};
private _currenttarget = GETVAR(_group,CurrentTarget,objNull);
if (
    _radioEnemy isNotEqualTo objNull &&
    {_currenttarget isEqualTo objNull}
) then {
	_currenttarget = _radioEnemy;
	SETVAR(_group,CurrentTarget,_radioEnemy);
};
private _enemydir = _leader getdir _currenttarget;
private _enemydist = _leader distance _currenttarget;

[_group, _currenttarget] call FUNC(taskAttack);
