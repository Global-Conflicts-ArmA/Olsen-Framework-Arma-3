#include "script_component.hpp"

params ["_unit"];

private _unitDir = getDir _unit;

// LOG_2("stanceMachine check: %1 with unitDir: %2",_unit,_unitDir);

// if (
//     (stance _unit isEqualTo "PRONE")
//     && {canStand _unit}
//     && {!(GETVAR(_unit,reloading,false))}
//     && {!([_unit, _unitDir, 0.25] call FUNC(checkView))}
// ) then {
//     LOG_1("stance: %1 was prone!",_unit);
//     if ([_unit, _unitDir, 1] call FUNC(checkView)) then {
//         _unit setUnitPos "MIDDLE";
//         SETVAR(_unit,US_SetStance,true);
//         LOG_1("Set to MIDDLE",_unit);
//     } else {
//         _unit setUnitPos "UP";
//         SETVAR(_unit,US_SetStance,true);
//     };
// } else {
//     LOG_1("stance: %1 was NOT prone!",_unit);
//     if (
//         (stance _unit isEqualTo "CROUCH")
//         && {!(GETVAR(_unit,reloading,false))}
//         && {([_unit, _unitDir, 0.25] call FUNC(checkView))}
//         && {(insideBuilding _unit) > 0.5}
//     ) then {
//         LOG_1("stance: %1 was crouched, can see prone!",_unit);
//         _unit setUnitPos "DOWN";
//         SETVAR(_unit,US_SetStance,true);
//         TRACE_1("Set to DOWN",_unit);
//     };
//     if (
//         (stance _unit isEqualTo "STAND")
//         && {([_unit, _unitDir, 1] call FUNC(checkView))}
//     ) then {
//         LOG_1("stance: %1 was standing, can see crouched!",_unit);
//         _unit setUnitPos "MIDDLE";
//         SETVAR(_unit,US_SetStance,true);
//         TRACE_1("Set to MIDDLE",_unit);
//     };
// };
