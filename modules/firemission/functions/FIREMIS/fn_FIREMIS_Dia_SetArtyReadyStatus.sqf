#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_isFiring", false, [false]]
];

_unit setVariable [VAR_SART_ARTINFIREMISSION,_isFiring,true];
["Event_ArtyIsReady", [_unit,_isFiring]] call CBA_fnc_globalEvent;
