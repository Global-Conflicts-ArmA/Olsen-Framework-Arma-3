#include "..\..\script_macros.hpp"

params ["_className"];

private _ret = "Error";
private _foundIndex = GVAR(SC_classNames) findIf {_x isEqualTo _className};

if (_foundIndex isEqualTo -1) then {
    private _cfg = configFile >> "CfgMagazines" >> _className;
    _ret = 	getText (_cfg >> "displayName");
    GVAR(SC_classNames) pushBack _className;
    GVAR(SC_classNames) pushBack _ret;
} else {
    _ret = GVAR(SC_classNames) select (_foundIndex + 1);
};

_ret