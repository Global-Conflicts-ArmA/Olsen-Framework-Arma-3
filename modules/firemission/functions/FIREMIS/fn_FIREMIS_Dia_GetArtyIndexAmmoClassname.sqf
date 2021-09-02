#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_index"]
];

private _ret = ((_unit call FUNC(FIREMIS_Dia_GetArtyAmmo)) select _index) select 0;
_ret
