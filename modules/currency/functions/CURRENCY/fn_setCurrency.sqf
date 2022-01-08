#include "script_component.hpp"

params [
  ["_unit", objNull, [objNull]],
  ["_amount", 0.0, [0.0]]
];

if (0 > _amount) then {
  _amount = 0.0;
};

SETVAR(_unit, Currency, _amount);
