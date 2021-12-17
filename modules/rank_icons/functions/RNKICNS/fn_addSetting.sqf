#include "script_component.hpp"

params[
  ["_selector", sideUnknown, [sideUnknown, grpNull, objNull, []]],
  ["_iconFile", "modules\rank_icons\res\chopper.paa", [""]]
];

INFO("Adding rank icon setting..");

if (_selector isEqualType sideUnknown || _selector isEqualType grpNull) exitWith {
    units _selector apply {
        [_x, _iconFile] call FUNC(setIcon);
    }
};

if (_selector isEqualType []) then {
    _selector apply {
        [_x, _iconFile] call FUNC(setIcon);
    };
} else {
    [_selector, _iconFile] call FUNC(setIcon);
};
