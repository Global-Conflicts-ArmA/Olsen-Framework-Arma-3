#include "script_component.hpp"
params ["_obj"];

private _boundingBox = boundingBoxReal _obj;
_boundingBox params ["_p0","_p1"];
_p0 params ["_x0","_y0","_z0"];
_p1 params ["_x1","_y1","_z1"];


private _groundLines = [
    //x-axis
    [[_x0,_y0,_z0],[_x1,_y0,_z0]],
    [[_x0,_y1,_z0],[_x1,_y1,_z0]],

    //y-axis
    [[_x0,_y0,_z0],[_x0,_y1,_z0]],
    [[_x1,_y0,_z0],[_x1,_y1,_z0]],

    //z-axis
    [[_x0,_y0,_z1],[_x0,_y0,_z0]],
    [[_x1,_y0,_z1],[_x1,_y0,_z0]],
    [[_x0,_y1,_z1],[_x0,_y1,_z0]],
    [[_x1,_y1,_z1],[_x1,_y1,_z0]]
];

for "_i" from 0 to 3 step 1 do {
    private _line = _groundLines select _i;
    private _p1 = _line select 0;
    private _p2 = _line select 1;

    _z0 = _p1 select 2;
    _z1 = _p2 select 2;

    _line set [0,(_line select 0) vectorMultiply 0.8];
    _line set [1,(_line select 1) vectorMultiply 0.8];

    _p1 = _line select 0;
    _p2 = _line select 1;
    _p1 set [2,_z0];
    _p2 set [2,_z1];
};

_groundLines
