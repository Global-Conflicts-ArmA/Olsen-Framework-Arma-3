#include "script_component.hpp"

//params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
params ["_unit", "", "", "", "", "_magazine", "", ""];

//LOG_1("firedManEH fired for: %1",_unit);
if !(local _unit) exitWith {};
    
[QGVAR(ShotCountEvent), [side _unit, _magazine]] call CBA_fnc_serverEvent;


