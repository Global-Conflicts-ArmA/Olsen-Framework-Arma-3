#include "script_component.hpp"

params ["_unit"];

// reset sightAid targets
if (_unit getVariable [QGVAR(SA_needsReset), false]) then {
    [_unit, false, objNull] call FUNC(WatchEnemy);
};

//private _target = _unit getVariable [QGVAR(SA_target), objNull];
//private _genuineTarget = if (
//        !(_unit getVariable [QGVAR(busy), false]) &&
//        {_target isNotEqualTo objNull} &&
//        {[_target] call EFUNC(FW,isAlive)} &&
//        {[_unit, _target, false, false] call FUNC(LOSCheck)}
//    ) then {
//    true
//} else {
//    false
//};
//// if _genuineTarget, then keep target and simply move when next stage
//if (_genuineTarget) then {
//    [_unit, false, objNull] call FUNC(WatchEnemy);
//    _unit setVariable [QGVAR(SA_target), objNull];
//};
