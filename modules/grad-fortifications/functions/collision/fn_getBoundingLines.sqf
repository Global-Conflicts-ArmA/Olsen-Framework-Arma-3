#include "script_component.hpp"
params ["_obj","_boundingBoxSize","_boundingBoxOffset"];

// resize to 2 here to get rid of boundingboxSphere value
private _boundingBox = boundingBoxReal _obj;
_boundingBox resize 2;
_boundingBox = _boundingBox apply {_x vectorAdd _boundingBoxOffset};

_boundingBox params ["_p0","_p1"];
_p0 params ["_x0","_y0","_z0"];
_p1 params ["_x1","_y1","_z1"];

private _lines = [
    //x-axis
    [[0,0,0],[0,0,0]],
    [[_x0,_y0,_z1],[_x1,_y0,_z1]],
    [[0,0,0],[0,0,0]],
    [[_x0,_y1,_z1],[_x1,_y1,_z1]],

    //y-axis
    [[0,0,0],[0,0,0]],
    [[_x0,_y0,_z1],[_x0,_y1,_z1]],
    [[0,0,0],[0,0,0]],
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
];

private _smallLines = _lines apply {[(_x select 0) vectorMultiply (0.8 * _boundingBoxSize * GVAR(boundingBoxSizeFactor)), (_x select 1) vectorMultiply (0.8 * _boundingBoxSize * GVAR(boundingBoxSizeFactor))]};

_smallLines
