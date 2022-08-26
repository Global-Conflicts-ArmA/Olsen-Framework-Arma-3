#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_text", "", [""]]
];

["Event_ArtyReceiveHint", _text, _unit] call CBA_fnc_targetEvent;
