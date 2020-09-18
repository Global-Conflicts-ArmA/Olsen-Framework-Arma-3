#include "..\..\script_macros.hpp"


params [["_pos",[0,0,0],[[]]],["_rangeMin",0,[0]],["_rangeMax",100,[0]],["_posCount",5,[0]],["_water",false,[false]]];
private _return = [];
private _max = (_posCount * 5);
if (_rangeMax < _max) then {
    _rangeMax = _max;
};
for "_i" from 0 to _max step 1 do {
    if (_i >= _posCount) exitwith {};
    private _angle = random 360;
    private _dist = _rangeMin + (random (_rangeMax - _rangeMin));
    private _newPos = [_pos, _dist, _angle] call BIS_fnc_relPos;
    if ((!_water) && {surfaceIsWater _newPos}) then {
        _i = _i - 1;
        _newPos = [];
    };
    if (!(_newPos isEqualTo [])) then {
        _return pushBack _newPos;
    };
};
_return
