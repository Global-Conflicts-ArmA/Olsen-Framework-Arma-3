#include "script_component.hpp"

params [
  ["_unit", objNull, [objNull]],
  ["_color", "", [""]]
];

SETVAR(_unit, FW_TeamColor, _color);
