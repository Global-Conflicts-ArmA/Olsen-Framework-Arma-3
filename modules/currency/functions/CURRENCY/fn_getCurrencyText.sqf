#include "script_component.hpp"

params [
  ["_unit", objNull, [objNull]],
  ["_showSymbol", true, [true]],
  ["_showShortName", true, [true]],
  ["_showFullName", false, [false]]
];

private _currency = [_unit] call FUNC(getCurrency);
private _symbol = "";
private _shortName = "";
private _fullName = "";

if (_showSymbol) then {
  _symbol = GVAR(Symbol);
};

if (_showShortName) then {
  _shortName = GVAR(Short_Name);
};

if (_showFullName) then {
  _fullName + GVAR(Name);
};

private _finalString = trim (format ["%1%2 %3 %4", _symbol, _currency, _shortName, _fullName]);

_finalString
