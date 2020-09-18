#include "script_component.hpp"

params [["_side", sideEmpty, [sideEmpty]], ["_magazine", "", [""]]];

switch (_side) do {
    case west: {
        private _findIndex = GVAR(west_ExpendedAmmo) findIf {_x isEqualTo _magazine};
        if (_findIndex isEqualTo -1) then {
            GVAR(west_ExpendedAmmo) pushBack _magazine;
            GVAR(west_ExpendedAmmo) pushBack 1;
        } else {
            GVAR(west_ExpendedAmmo) set [_findIndex + 1, (GVAR(west_ExpendedAmmo) select _findIndex + 1) + 1 ];
        };
    };
    case east: {
        private _findIndex = GVAR(east_ExpendedAmmo) findIf {_x isEqualTo _magazine};
        if (_findIndex isEqualTo -1) then {
            GVAR(east_ExpendedAmmo) pushBack _magazine;
            GVAR(east_ExpendedAmmo) pushBack 1;
        } else {
            GVAR(east_ExpendedAmmo) set [_findIndex + 1, (GVAR(east_ExpendedAmmo) select _findIndex + 1) + 1 ];
        };
    };
    case independent: {
        private _findIndex = GVAR(ind_ExpendedAmmo) findIf {_x isEqualTo _magazine};
        if (_findIndex isEqualTo -1) then {
            GVAR(ind_ExpendedAmmo) pushBack _magazine;
            GVAR(ind_ExpendedAmmo) pushBack 1;
        } else {
            GVAR(ind_ExpendedAmmo) set [_findIndex + 1, (GVAR(ind_ExpendedAmmo) select _findIndex + 1) + 1 ];
        };
    };
    case civilian: {
        private _findIndex = GVAR(civ_ExpendedAmmo) findIf {_x isEqualTo _magazine};
        if (_findIndex isEqualTo -1) then {
            GVAR(civ_ExpendedAmmo) pushBack _magazine;
            GVAR(civ_ExpendedAmmo) pushBack 1;
        } else {
            GVAR(civ_ExpendedAmmo) set [_findIndex + 1, (GVAR(civ_ExpendedAmmo) select _findIndex + 1) + 1 ];
        };
    };
};