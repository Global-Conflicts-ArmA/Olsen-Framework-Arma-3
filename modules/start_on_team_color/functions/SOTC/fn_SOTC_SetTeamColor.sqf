#include "script_component.hpp"

params [
  ["_unit", objNull, [objNull]],
  ["_colour", "", [""]]
];

SETVAR(_unit, teamColour, _colour);
