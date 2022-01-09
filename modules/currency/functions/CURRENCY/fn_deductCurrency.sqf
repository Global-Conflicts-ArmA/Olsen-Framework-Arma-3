#include "script_component.hpp"

params [
  ["_unit", objNull, [objNull]],
  ["_amountToDeduct", 0.0, [0.0]]
];

private _currency = GETVAR(_unit, Currency, 0.0);
private _newCurrency = _currency - _amountToDeduct;

[_unit, _newCurrency] call FUNC(setCurrency);
