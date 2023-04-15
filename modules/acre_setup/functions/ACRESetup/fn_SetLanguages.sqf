#include "script_component.hpp"

params [
  ["_unit", objNull, [objNull]],
  ["_languages", ["en"], [[""]]]
];

_unit setVariable ["ACRE_Languages", _languages, false];
