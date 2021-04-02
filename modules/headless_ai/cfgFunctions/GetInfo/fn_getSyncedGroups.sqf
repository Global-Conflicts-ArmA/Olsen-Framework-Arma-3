#include "..\..\script_macros.hpp"

params [
    ["_logic",objNull,[objNull]],
    ["_group",[],[[]]],
    ["_syncedUnits",[],[[]]],
    ["_syncedGroups",[],[[]]]
];

if (_logic isEqualTo objnull) exitwith {
    ERROR_1("logic %1 was null on getSyncedGroups check!",_logic);
};

private _synced = synchronizedObjects _logic;
_synced apply {
    private _unit = _x;
    if (!(_unit isKindOf "Logic")) then {
        if (_unit isKindOf "Man") then {
            _syncedUnits pushBack _unit;
        };
        if (
            _unit isKindOf "Air" || 
            _unit isKindOf "Ship" || 
            _unit isKindOf "LandVehicle" || 
            _unit isKindOf "StaticWeapon" || 
            _unit isKindOf "Static"
        ) then {
            _syncedUnits pushBack ((crew _unit) select 0);
        };
    };
};

if !(_syncedUnits isEqualTo []) then {
    _syncedUnits apply {
        _syncedGroups pushBack (group _x);
    };
    _group = _syncedGroups arrayIntersect _syncedGroups;
};
    
_group
