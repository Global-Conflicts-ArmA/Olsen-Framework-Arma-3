#include "script_component.hpp"
#include "..\..\settings.sqf"

private ["_TimeParam", "_date"];

_TimeParam = ["TimeOfDay", -1] call BIS_fnc_getParamValue;

private _t = -1;

if (_TimeParam in [-2,-3,-4,-5]) then {

  _sunsetSunrise = [] call BIS_fnc_sunriseSunsetTime;
  if (_sunsetSunrise in [[-1,0],[0,-1]]) then {
    _t = -1;
  } else {

    switch (_TimeParam) do {
      case -2: {
        _t = (_sunsetSunrise select 0) - 1.25;
      };
      case -3: {
        _t = (_sunsetSunrise select 0) - 0.75;
      };
      case -4: {
        _t = (_sunsetSunrise select 1);
      };
      case -5: {
        _t = (_sunsetSunrise select 1) + 0.5;
      };
    };
  };
} else {
  _t = _TimeParam;
};
if (-10 == _t) then {
  _t = random 23.9;
};

if (-1 != _t) then {
  _t = [floor _t, floor ((_t % 1) * 60)];

  _date = date;
  _date set [3, _t select 0];
  _date set [4, _t select 1];
  [_date] call BIS_fnc_setDate;

};
