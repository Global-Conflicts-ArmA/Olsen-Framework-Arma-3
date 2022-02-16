#include "script_component.hpp"


params ["_pos",["_radius",100,[0]],["_blds",[],[[]]]];
private _getblds = (_pos nearObjects ["building",_radius]) select {count (_x buildingPos -1) > 0 && {!(isObjectHidden _x)}};
if (count _getblds < 1) exitWith {[objNull]};
private _xbld = _getblds apply {[_x distance _pos, _x]};
_xbld sort true;
_blds = _xbld apply {_x select 1};
_blds
