#include "..\..\script_macros.hpp"


params [["_logic",objNull,[objNull]],["_group",[],[[]]],["_syncedUnits",[],[[]]],["_syncedGroups",[],[[]]]];
if (!isNull _logic) then {
    private _synced = synchronizedObjects _logic;
    {
        private _unit = _x;
        if (!(_unit isKindOf "Logic")) then {
            if (_unit isKindOf "Man") then {
                _syncedUnits pushBack _unit;
            };
            if (_unit isKindOf "Air" || _unit isKindOf "Ship" || _unit isKindOf "LandVehicle" || _unit isKindOf "StaticWeapon" || _unit isKindOf "Static") then {
                _syncedUnits pushBack ((crew _unit) select 0);
            };
        };
    } foreach _synced;
    if !(_syncedUnits isEqualTo []) then {
        {
            _syncedGroups pushBack (group _x);
        } forEach _syncedUnits;
        _group = _syncedGroups arrayIntersect _syncedGroups;
    };
};
_group
