#include "..\..\script_macros.hpp"


params ["_newPos","_grpldr","_unit",["_pos",[],[[]]]];
private _grpPos = getPosATL _grpldr;
private _unitPos = getpos _unit;
private _dist = _grpPos distance _unitPos;
private _dir = _grpPos getDir _unitPos;
_pos = _newPos getpos [_dist, _dir];
LOG_3("GetNewPos for %1 Old Pos: %2 New: %3",_unit,_newPos,_pos);
_pos
