#include "..\..\script_macros.hpp"


params ["_Unit"];
if (isPlayer _Unit) exitWith {};
if !((vehicle _Unit) isEqualTo _Unit) exitWith {};

//If the unit got hit recently, ignore this.
if (_Unit getVariable [QGVAR(GHit),false]) exitWith {};
_Unit setVariable [QGVAR(GHit),true];
_Unit setUnitPos "DOWN";
private _unCon = false;
if ((random 100) < 5) then {
    _unit setUnconscious true;
    _unCon = true;
};
[{
    params ["_Unit","_unCon"];
    _Unit setVariable [QGVAR(GHit),false];
    _Unit setUnitPos "AUTO";
    if (_unCon) then {
        _Unit setUnconscious false;
    };
}, [_Unit,_unCon], 30] call CBA_fnc_waitAndExecute;
