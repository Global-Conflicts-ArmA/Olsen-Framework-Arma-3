#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_guns", [], [[]]]
];

/* LOG_2("Setting guns for %1 = %2", _unit, _guns); */
_unit setVariable [VAR_SART_OBSGUNS, _guns, true];
