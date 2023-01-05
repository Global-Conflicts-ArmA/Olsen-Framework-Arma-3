#include "script_component.hpp"

params ["_unit"];

if !(local _unit) exitwith {};
if !(GETVAR(_unit,spawned,false)) exitwith {};

private _group = group _unit;
private _groupStance = GETVAR(_group,stance,"AUTO");
private _unitStance = GETVAR(_unit,stance,"AUTO");

[_unit, _groupStance, _unitStance] call FUNC(setStance);

private _identity = GETVAR(_unit,identityArray,[]);
if (_identity isNotEqualTo []) then {
    [[_unit, _identity], {
        params ["_unit", "_identity"];
        _identity params ["_unitName", "_face", "_speaker", "_nameSound", "_pitch"];
        if (_unitName isNotEqualTo "") then {
            _unit setName _unitName;
        };
        if (_face isNotEqualTo "") then {
            _unit setFace _face;
        };
        if (_speaker isNotEqualTo "") then {
            _unit setSpeaker _speaker;
        };
        if (_nameSound isNotEqualTo "") then {
            _unit setNameSound _nameSound;
        };
        if (_pitch isNotEqualTo 0.99) then {
            _unit setPitch _pitch;
        };
    }] remoteExec ["BIS_fnc_call", 0, true];
};

private _init = GETVAR(_unit,init,false);
if (_init isEqualType {}) then {
    _unit call _init;
};
