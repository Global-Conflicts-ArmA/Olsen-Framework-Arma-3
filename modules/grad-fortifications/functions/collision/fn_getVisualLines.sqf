#include "script_component.hpp"
params ["_obj"];

private _boundingBox = boundingBoxReal _obj;
_boundingBox params ["_p0","_p1"];
_p0 params ["_x0","_y0","_z0"];
_p1 params ["_x1","_y1","_z1"];

[
    //x-axis
    [[_x0,_y0,_z0],[_x1,_y0,_z0]],
    [[_x0,_y0,_z1],[_x1,_y0,_z1]],
    [[_x0,_y1,_z0],[_x1,_y1,_z0]],
    [[_x0,_y1,_z1],[_x1,_y1,_z1]],

    //y-axis
    [[_x0,_y0,_z0],[_x0,_y1,_z0]],
    [[_x0,_y0,_z1],[_x0,_y1,_z1]],
    [[_x1,_y0,_z0],[_x1,_y1,_z0]],
    [[_x1,_y0,_z1],[_x1,_y1,_z1]],

    //z-axis
    [[_x0,_y0,_z1],[_x0,_y0,_z0]],
    [[_x1,_y0,_z1],[_x1,_y0,_z0]],
    [[_x0,_y1,_z1],[_x0,_y1,_z0]],
    [[_x1,_y1,_z1],[_x1,_y1,_z0]],

    //diagonals
    [[_x0,_y0,_z0],[_x1,_y1,_z1]],
    [[_x0,_y0,_z1],[_x1,_y1,_z0]],
    [[_x1,_y0,_z0],[_x0,_y1,_z1]],
    [[_x1,_y0,_z1],[_x0,_y1,_z0]]
]
