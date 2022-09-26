#include "script_component.hpp"

GVAR(Markers) = [];
GVAR(MarkersDeleteAfterStart) = [];

#include "settings.sqf"

GVAR(Markers) apply {
    _x params [
        ["_side", blufor, [blufor, []]],
        ["_marker", "", [""]],
        ["_deleteAfterStart", false, [false]]
    ];

    private _playerSide = side player;

    if (
        _side isEqualType [] && {!(_playerSide in _side)} ||
        _side isEqualType blufor && {_side isNotEqualTo _playerSide}
    ) then {
        _marker setMarkerAlphaLocal 0;
    };

    if (_deleteAfterStart) then {
        GVAR(MarkersDeleteAfterStart) pushBackUnique _marker;
    };
};

[{CBA_missionTime > 0}, {
    _this apply {
        _x setMarkerAlphaLocal 0;
    };
}, GVAR(MarkersDeleteAfterStart)] call CBA_fnc_waitUntilAndExecute;
