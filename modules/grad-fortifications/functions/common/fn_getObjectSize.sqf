#include "script_component.hpp"
params ["_type"];


private _vehicle = _type createVehicleLocal [0,0,0];
private _dimensions = _vehicle call BIS_fnc_boundingBoxDimensions;
_dimensions params ["_h","_l","_w"];
private _size = sqrt(_h*_h + _l*_l + _w*_w);

//static weapons tend to be a little too small
if (_type isKindOf "StaticWeapon") then {_size = _size * 1.2};

deleteVehicle _vehicle;

_size
