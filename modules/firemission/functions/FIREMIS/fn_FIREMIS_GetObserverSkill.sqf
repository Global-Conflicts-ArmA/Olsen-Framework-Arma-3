#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]]
];

private _ret = [];
_ret pushBack (_unit getVariable [VAR_SART_OBSACCURACY,OBSACCURACY]);
_ret pushBack (_unit getVariable [VAR_SART_OBSSPEED,OBSSPEED]);
_ret
