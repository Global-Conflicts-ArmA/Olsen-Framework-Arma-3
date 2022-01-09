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
  _symbol = [missionConfigFile >> "CfgCurrency" >> "Currencies" >> GVAR(Currency) >> "symbol", "text", "£"] call CBA_fnc_getConfigEntry;
};

if (_showShortName) then {
  _shortName = [missionConfigFile >> "CfgCurrency" >> "Currencies" >> GVAR(Currency) >> "short_name", "text", "GBP"] call CBA_fnc_getConfigEntry;
};

if (_showFullName) then {
  _fullName = [missionConfigFile >> "CfgCurrency" >> "Currencies" >> GVAR(Currency) >> "name", "text", "Great British Pounds"] call CBA_fnc_getConfigEntry;
};

private _finalString = trim (format ["%1%2 %3 %4", _symbol, _currency, _shortName, _fullName]);

_finalString
