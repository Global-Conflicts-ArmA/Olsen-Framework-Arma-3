#include "..\..\script_macros.hpp"

AI_EXEC_CHECK(HC);

params ["_unit"];

if !(local _unit) exitwith {};
if !(GETVAR(_unit,spawned,false)) exitwith {};

private _group = group _unit;
private _groupStance = GETVAR(_group,Stance,"AUTO");
private _unitStance = GETVAR(_unit,unitStance,"AUTO");

[_unit, _groupStance, _unitStance] call FUNC(setStance);

private _identity = GETVAR(_unit,identityArray,[]);
if !(_identity isEqualTo []) then {
    [[_unit, _identity], {
        params ["_unit", "_identity"];
        _identity params ["_unitName", "_face", "_speaker", "_nameSound", "_pitch"];
        if !(_unitName isEqualTo "") then {
            _unit setName _unitName;
        };
        if !(_face isEqualTo "") then {
            _unit setFace _face;
        };
        if !(_speaker isEqualTo "") then {
            _unit setSpeaker _speaker;
        };
        if !(_nameSound isEqualTo "") then {
            _unit setNameSound _nameSound;
        };
        if !(_pitch isEqualTo 0.99) then {
            _unit setPitch _pitch;
        };
    }] remoteExec ["BIS_fnc_call", 0, true];
};

private _unitInit = GETVAR(_unit,unitInit,false);
if (_unitInit isEqualType {}) then {
    _unit call _unitInit;
};
