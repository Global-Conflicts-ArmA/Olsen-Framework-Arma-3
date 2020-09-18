#include "script_component.hpp"
GVAR(checkCollisionPFH) = [{
    params ["_args", "_handle"];
    _args params ["_builder","_visualLines","_boundingLines","_groundLines","_fort","_canFloat","_canCollide","_canPlaceOnRoad","_surfaceNormal","_surfaceNormalForced"];

    if (isNull _fort) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};

    private _visualLinesWorld = [_visualLines,_fort] call FUNC(linesToWorld);
    private _boundingLinesWorld = [_boundingLines,_fort] call FUNC(linesToWorld);
    private _groundLinesWorld = [_groundLines,_fort] call FUNC(linesToWorld);

    private _isOnGround = if (_canFloat) then {true} else {[_groundLinesWorld,_fort] call FUNC(isOnGround)};
    private _isOnRoad = if (_canPlaceOnRoad) then {false} else {isOnRoad _fort};
    private _customCondition = [_fort,_builder] call compile ([missionConfigFile >> "CfgGradFortifications" >> "Fortifications" >> typeOf _fort >> "condition","text","true"] call CBA_fnc_getConfigEntry);

    //check bounding box
    _builder setVariable [QGVAR(isColliding),false];
    _builder setVariable [QGVAR(isOnGround),_isOnGround];
    _builder setVariable [QGVAR(isOnRoad),_isOnRoad];
    _builder setVariable [QGVAR(isCustomCondition),_customCondition];
    {
        private _isColliding = if (_canCollide) then {false} else {[_x,_fort] call FUNC(isColliding)};

        private _color = [0,1,0,1];
        if (_isColliding) then {
            _color = [1,0,0,1];
            _builder setVariable [QGVAR(isColliding),true];
        };

        if (!_isOnGround || {_isOnRoad} || {!_customCondition}) then {
            _color = [1,1,0,1];
        };

        if (missionNamespace getVariable [QGVAR(collisionDebugMode),false]) then {
            drawLine3D [_x select 0, _x select 1, _color];
        } else {
            private _visualLine = _visualLinesWorld select _forEachIndex;
            drawLine3D [_visualLine select 0, _visualLine select 1, _color];
        };
    } forEach _boundingLinesWorld;


    //draw ground lines if debug mode
    if (missionNamespace getVariable [QGVAR(collisionDebugMode),false]) then {
        private _color = if (!_isOnGround) then {[1,1,0,1]} else {[0,1,0,1]};
        {
            drawLine3D [_x select 0,_x select 1,_color];
            false
        } count _groundLinesWorld;
    };


    //update hint
    switch (true) do {
        case (!_customCondition): {
            ["CUSTOM",_surfaceNormal,_surfaceNormalForced,_builder,typeOf _fort] call FUNC(updateHint);
        };
        case (!_isOnGround): {
            ["FLOATING",_surfaceNormal,_surfaceNormalForced,_builder] call FUNC(updateHint);
        };
        case (_isOnRoad): {
            ["ONROAD",_surfaceNormal,_surfaceNormalForced,_builder] call FUNC(updateHint);
        };
        case (_builder getVariable [QGVAR(isColliding),true]): {
            ["COLLIDING",_surfaceNormal,_surfaceNormalForced,_builder] call FUNC(updateHint);
        };
        default {
            ["CANPLACE",_surfaceNormal,_surfaceNormalForced,_builder] call FUNC(updateHint);
        };
    };
}, 0, _this] call CBA_fnc_addPerFrameHandler;

GVAR(checkCollisionPFH)
