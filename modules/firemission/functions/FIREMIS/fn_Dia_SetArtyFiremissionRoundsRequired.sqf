#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_roundsFired", 0, [0]],
  ["_roundsRequired", 0, [0]]
];

_unit setVariable [VAR_SART_ARTROUNDSFIRED,[_roundsFired,_roundsRequired],true];
