#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_index", 0, [0]]
];

private _ret = ((_unit call FUNC(Dia_GetArtyAmmo)) select _index) select 0;
_ret
