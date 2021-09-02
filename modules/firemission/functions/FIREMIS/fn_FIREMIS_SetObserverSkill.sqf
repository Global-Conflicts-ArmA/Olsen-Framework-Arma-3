#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_accuracy"],
  ["_speed"]
];

_unit setVariable [VAR_SART_OBSACCURACY,_accuracy];
_unit setVariable [VAR_SART_OBSSPEED,_speed];
