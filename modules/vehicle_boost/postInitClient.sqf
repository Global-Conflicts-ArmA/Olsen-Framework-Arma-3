#include "script_component.hpp"

[{(!isNull ACE_player)}, {
    [{
        params ["_argNested", "_idPFH"];
        _argNested params [];
        if !([ACE_player] call EFUNC(FW,isAlive)) exitWith {};
        if !(INVEHICLE(ACE_player)) exitWith {};
        private _vehicle = vehicle ACE_player;
        if !(local _vehicle) exitWith {};
        if !(alive _vehicle) exitWith {};
        if !(driver _vehicle isEqualTo ACE_player) exitWith {};
        private _alreadyChecked = _vehicle getVariable [QGVAR(validCheck), -1];
        if (_alreadyChecked isEqualType false && {!_alreadyChecked}) exitWith {};
        private _className = typeOf _vehicle;
        // check if vehicle is valid and get values of max speeds
        if !(_className in GVAR(BoostClasses)) then {
            private _valid = false;
            {
                if ((!(_x in ["Car", "Tank", "Ship"])) && {_vehicle isKindOf _x}) then {
                    GVAR(BoostClasses) pushBackUnique _className;
                    GVAR(BoostNamespace) set [typeOf _vehicle, _y];
                    _valid = true;
                    break;
                };
            } forEach GVAR(BoostNamespace);
            if !(_valid) then {
                if (_vehicle isKindOf "Car") then {
                    private _carVal = GVAR(BoostNamespace) getOrDefault ["Car", -1];
                    if (_carVal isNotEqualTo -1) then {
                        GVAR(BoostClasses) pushBackUnique _className;
                        GVAR(BoostNamespace) set [_className, _carVal];;
                        _valid = true;
                    };
                } else {
                    if (_vehicle isKindOf "Tank") then {
                        private _carVal = GVAR(BoostNamespace) getOrDefault ["Tank", -1];
                        if (_carVal isNotEqualTo -1) then {
                            GVAR(BoostClasses) pushBackUnique _className;
                            GVAR(BoostNamespace) set [_className, _carVal];
                            _valid = true;
                        };
                    } else {
                        if (_vehicle isKindOf "Ship") then {
                            private _carVal = GVAR(BoostNamespace) getOrDefault ["Ship", -1];
                            if (_carVal isNotEqualTo -1) then {
                                GVAR(BoostClasses) pushBackUnique _className;
                                GVAR(BoostNamespace) set [_className, _carVal];
                                _valid = true;
                            };
                        };
                    };
                };
            };
            _vehicle setVariable [QGVAR(validCheck), _valid];
            //TRACE_2("vehicle valid for boost",_vehicle,_valid);
        } else {
            private _vehValue = GVAR(BoostNamespace) getOrDefault [_className, -1];
            if (_vehValue isEqualType -1) exitWith {
                ERROR_1("error getting boost data for vehicle class",_className);
            };
            //TRACE_2("vehicle valid for boost",_vehicle,_vehValue);
            _vehValue params [
                ["_maxSpeed", -1, [0]],
                ["_maxSpeedInWater", -1, [0]]
            ];
            private _speed = speed _vehicle;
            private _inWater = surfaceIsWater position _vehicle;
            private _maxSpeed = [_maxSpeed, _maxSpeedInWater] select _inWater;
            if (_maxSpeed isEqualTo -1) exitWith {};
            if (_speed < _maxSpeed) then {
                private _velocity = velocity _vehicle;
                private _dir = direction _vehicle;
                if (inputAction "CarFastForward" > 0) then {
                    _vehicle setVelocity [
                        (_velocity select 0) + 0.01 * (sin _dir),
                        (_velocity select 1) + 0.01 * (cos _dir),
                        _velocity select 2
                    ];
                };
            };
        };
    }, 0, []] call CBA_fnc_addPerFrameHandler;
}] call CBA_fnc_waitUntilAndExecute;
