#include "script_component.hpp"

params ["_className", ["_grenade", false, [false]]];

TRACE_2("",_className,_grenade);
private _ret = "Error";
private _foundIndex = GVAR(shotClassNames) findIf {_x isEqualTo _className};

TRACE_2("",_className,_foundIndex);
if (_foundIndex isEqualTo -1) then {
    private _cfgSection = ["CfgMagazines", "CfgAmmo"] select _grenade;
    TRACE_2("",_className,_cfgSection);
    _ret = getText (configFile >> _cfgSection >> _className >> "displayName");
    TRACE_2("",_className,_ret);
    GVAR(shotClassNames) pushBack _className;
    GVAR(shotClassNames) pushBack _ret;
} else {
    _ret = GVAR(shotClassNames) select (_foundIndex + 1);
};

_ret