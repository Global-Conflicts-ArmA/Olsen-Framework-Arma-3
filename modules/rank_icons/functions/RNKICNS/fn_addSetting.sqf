#include "script_component.hpp"

params[
  ["_selector", blufor, [blufor, objNull, grpNull]],
  ["_iconFile", "modules\rank_icons\res\chopper.paa", [""]]
];

INFO("Adding rank icon setting..");

private _sideStrings = ["WEST", "EAST", "GUER", "CIV"];

if ((str _selector) in _sideStrings) exitWith {
  allUnits apply {
    private _unit = _x;
    private _sideString = (str (side _unit));

    if (_sideString isEqualTo (str _selector)) then {
      [_unit, _iconFile] call FUNC(setIcon);
    };
  };
};

allGroups apply {
  private _groupName = _x;

  if (_groupName isEqualTo _selector) exitWith {
    (units _x) apply {
      private _unit = _x;
      [_unit, _iconFile] call FUNC(setIcon);
    };
  };
};

allUnits apply {
  private _unit = _x;

  if (_unit isEqualTo _selector) exitWith {
    [_unit, _iconFile] call FUNC(setIcon);
  };
};
