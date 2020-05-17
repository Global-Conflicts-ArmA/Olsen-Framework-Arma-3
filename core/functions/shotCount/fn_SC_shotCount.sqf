#include "..\..\script_macros.hpp"

params [["_side", sideEmpty, [sideEmpty]], ["_magazine", "", [""]]];

switch (_side) do {
    case west: {
        private _findIndex = GVAR(SC_west_ExpendedAmmo) findIf {_x isEqualTo _magazine};
        if (_findIndex isEqualTo -1) then {
            GVAR(SC_west_ExpendedAmmo) pushBack _magazine;
            GVAR(SC_west_ExpendedAmmo) pushBack 1;
        } else {
            GVAR(SC_west_ExpendedAmmo) set [_findIndex + 1, (GVAR(SC_west_ExpendedAmmo) select _findIndex + 1) + 1 ];
        };
    };
    case east: {
        private _findIndex = GVAR(SC_east_ExpendedAmmo) findIf {_x isEqualTo _magazine};
        if (_findIndex isEqualTo -1) then {
            GVAR(SC_east_ExpendedAmmo) pushBack _magazine;
            GVAR(SC_east_ExpendedAmmo) pushBack 1;
        } else {
            GVAR(SC_east_ExpendedAmmo) set [_findIndex + 1, (GVAR(SC_east_ExpendedAmmo) select _findIndex + 1) + 1 ];
        };
    };
    case independent: {
        private _findIndex = GVAR(SC_ind_ExpendedAmmo) findIf {_x isEqualTo _magazine};
        if (_findIndex isEqualTo -1) then {
            GVAR(SC_ind_ExpendedAmmo) pushBack _magazine;
            GVAR(SC_ind_ExpendedAmmo) pushBack 1;
        } else {
            GVAR(SC_ind_ExpendedAmmo) set [_findIndex + 1, (GVAR(SC_ind_ExpendedAmmo) select _findIndex + 1) + 1 ];
        };
    };
    case civilian: {
        private _findIndex = GVAR(SC_civ_ExpendedAmmo) findIf {_x isEqualTo _magazine};
        if (_findIndex isEqualTo -1) then {
            GVAR(SC_civ_ExpendedAmmo) pushBack _magazine;
            GVAR(SC_civ_ExpendedAmmo) pushBack 1;
        } else {
            GVAR(SC_civ_ExpendedAmmo) set [_findIndex + 1, (GVAR(SC_civ_ExpendedAmmo) select _findIndex + 1) + 1 ];
        };
    };
};