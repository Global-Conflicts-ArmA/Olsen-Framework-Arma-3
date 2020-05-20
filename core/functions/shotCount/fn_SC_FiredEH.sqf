#include "script_component.hpp"

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

//LOG_1("firedManEH fired for: %1",_unit);

[QGVAR(SC_CountEvent), [side _unit, _magazine]] call CBA_fnc_serverEvent;