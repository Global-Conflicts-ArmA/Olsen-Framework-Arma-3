#include "script_component.hpp"

params [
  ["_unit", objNull, [objNull]],
  ["_side", blufor, blufor]
];

_unit setVariable ["ACRE_CustomScramble", _side, false];
