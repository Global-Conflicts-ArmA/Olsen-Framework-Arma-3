#include "script_component.hpp"


//FUNC(CombatResponse)

params [
    "_group",
    ["_radioEnemy", objnull, [objnull]]
];

private _leader = leader _group;
if (behaviour _leader isEqualTo "SAFE") then {
	_group setbehaviour "AWARE";
};
private _currenttarget = GETVAR(_group,CurrentTarget,objnull);
if (
    _radioEnemy isNotEqualTo objnull &&
    {_currenttarget isEqualTo objnull}
) then {
	_currenttarget = _radioEnemy;
	SETVAR(_group,CurrentTarget,_radioEnemy);
};
private _enemydir = _leader getdir _currenttarget;
private _enemydist = _leader distance _currenttarget;

[_group, _currenttarget] call FUNC(CombatDefend);
