#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_accuracy", 1, [1]],
  ["_speed", 1, [1]]
];

_unit setVariable [VAR_SART_OBSACCURACY,_accuracy];
_unit setVariable [VAR_SART_OBSSPEED,_speed];
