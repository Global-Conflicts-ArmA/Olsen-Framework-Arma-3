#include "..\..\script_macros.hpp"

params ["_group", "_targetPos"];

private _leader = leader _group;
private _units = units _group;
private _vehicle = vehicle _leader;
private _pilot = driver _vehicle;

[_group] call CBA_fnc_clearWaypoints;
private _arrayTest = ["AUTOCOMBAT", "COVER", "SUPPRESSION", "AUTOTARGET", "TARGET", "FSM"];
_group enableAttack false;
_units apply {
    private _unit = _x;
    _arrayTest apply {
        _unit disableAI _x;
    };
};
_group setBehaviour "AWARE";
_group setCombatMode "BLUE";
_group setSpeedMode "FULL";

// manoeuvre function
private _landTaskPFH = [{
    params ["_args", "_idPFH"];
    _args params ["_group", "_targetPos", "_pilot", "_vehicle", ["_state", "FLYING", [""]]];
    _units = _units select {_x call EFUNC(FW,isAlive)};
    private _leader = leader _group;
    
    _group setCombatMode "BLUE";
    _group setBehaviour "AWARE";
    _group setSpeedMode "FULL";
    
    private _distance = _vehicle distance2d _targetPos;
    
    //TRACE_3("landTask",_vehicle,_state,_distance);
    
    switch (_state) do {
        case "FINDING LANDING": {
            //code
            if (landResult _vehicle isEqualTo "Found") then {
                _state = "LANDING";
                _args set [4, _state];
                SETVAR(_group,Task,"LANDING");
            };
        };
        case "LANDED": {
            //code
        };
        case "LANDING": {
            private _relVelocity = velocityModelSpace _vehicle;
            _relVelocity params ["", "_fVelocity", "_uVelocity"];
            private _vectorAdd =if (_uVelocity > 0) then {
                [0, 0, -(_uVelocity * 1.2)]
            } else {
                [0, 0, 0]
            };
            private _newVector = _relVelocity vectorAdd _vectorAdd;
            _newVector params ["_nvX", "_nvY", "_nvZ"];
            if (_nvZ > 0) then {_nvZ = -2.5};
            _vehicle setVelocityModelSpace [_nvX, _nvY, _nvZ];
            //if (_uVelocity > -1) then {
            //    private _vectorAdd = [0, 0, -(_uVelocity * 0.8) - 1];
            //    private _vectorFromTo = getposATL _vehicle vectorFromTo _targetPos;
            //    //private _newVector = _relVelocity vectorAdd _vectorAdd;
            //    //_vehicle setVelocityModelSpace _newVector;
            //    _vehicle setVelocity _vectorFromTo;
            //};
            //private _relDir = _vehicle getRelDir _targetPos;
            //if (_relDir > 25 || _relDir < (360 - 25)) then {
            //    private _torque = [100,0,0];
            //    _vehicle addTorque (_vehicle vectorModelToWorld s);
            //};
            if ((getPosATL _vehicle select 2) <= 5) then {
                _vehicle land "NONE";
                _vehicle flyInHeight 0;
                _state = "LANDED";
                _args set [4, _state];
                SETVAR(_group,Task,"LANDED");
            };
        };
        case "APPROACHING": {
            private _relVelocity = velocityModelSpace _vehicle;
            _relVelocity params ["", "_fVelocity", "_uVelocity"];
            if (_fVelocity >= 15 || _uVelocity >= 3) then {
                private _nFVelocity = if (_fVelocity < 15) then {
                    _fVelocity
                } else {
                    -(_fVelocity * 0.8)
                };
                private _nUVelocity = if (_uVelocity < 3) then {
                    _uVelocity
                } else {
                    -(_uVelocity * 1)
                };
                private _vectorAdd = [0, _nFVelocity, _nUVelocity];
                private _newVector = _relVelocity vectorAdd _vectorAdd;
                _vehicle setVelocityModelSpace _newVector;
            };
            if (_distance <= 350) then {
                _vehicle land "LAND";
                _state = "FINDING LANDING";
                _args set [4, _state];
                SETVAR(_group,Task,"FINDING LANDING");
            };
        };
        case "FLYING": {
            _pilot doMove _targetPos;
            if (_distance <= 500) then {
                _vehicle flyInHeight 30;
                _vehicle limitSpeed 35;
                _state = "APPROACHING";
                _args set [4, _state];
                SETVAR(_group,Task,"APPROACHING");
            };
        };
        default {};
    };
}, 3, [_group, _targetPos, _pilot, _vehicle]] call CBA_fnc_addPerFrameHandler;

SETVAR(_group,Task,"LAND");
