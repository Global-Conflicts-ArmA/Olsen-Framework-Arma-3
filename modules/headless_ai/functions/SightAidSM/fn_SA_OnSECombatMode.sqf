#include "script_component.hpp"

params ["_unit"];

if (GETVAR(group _unit,forcedCombatMode,"Auto") isEqualTo "Auto") then {
	_unit setCombatMode "RED";
	_unit setBehaviour "COMBAT";
};

private _enemyTarget = GETVAR(_unit,SA_enemyTarget,objnull);
if (_enemyTarget isEqualTo objnull) exitwith {};
private _distance = GETVAR(_unit,SA_enemyDistance,600);
if (_distance > GETMVAR(SightAidDistance,600)) exitwith {};
private _knowsabouttarget = _unit knowsabout _enemyTarget;
private _cansee = [objNull, "VIEW"] checkVisibility [eyePos _Unit, eyePos _enemyTarget];
if (_knowsabouttarget < 4) then {
    if ((_cansee > 0.6) && {(_distance < GETMVAR(SightAidEngageDistance,200))}) then {
        _unit reveal [_enemyTarget, 4];
    } else {
        if (_cansee > 0.05) then {
    		private _revealValue = linearConversion [100, GETMVAR(SightAidDistance,600), _distance, 4, GETMVAR(SightAidMinIncrease,1)];
    		_unit reveal [_enemyTarget, _knowsabouttarget + _revealValue];
    		if (GETMVAR(UseMarkers,false)) then {
    			LOG_4("revealing: %1 to %2, old knows: %3 new: %4",_enemyTarget,_unit,_knowsabouttarget,(_unit knowsabout _enemyTarget));
    		};
    	};
    };
};

if (
    !(GETVAR(_unit,busy,false)) &&
    {_knowsabouttarget > 1.5}
) then {
    // Random grenade chance - random check, range check, then check for grenades, check for building, nearby friendlies to target, if none - throw grenade
    if (GETMVAR(forceGrenades,true)) then {
        private _chance = round random 100;
        if (
            _chance <= GETMVAR(grenadeChance,25) &&
            {_distance <= GETMVAR(grenadeRange,40)} &&
            {_distance > 5}
        ) then {
            private _grenades = [_unit] call FUNC(getGrenades);
            _grenades params [
                ["_frags", [], [[]]],
                ["_smokes", [], [[]]]
            ];
            if (_frags isNotEqualTo []) then {
                //throw frag at enemy
                TRACE_2("throwing frag at enemy!",_unit,_enemyTarget);
                //private _dir = _unit getDir _enemyTarget;
                //_unit setDir _dir;
                SETVAR(_unit,busy,true);
                [_unit, "HandGrenadeMuzzle"] call BIS_fnc_fire;
                [{
                    params ["_unit"];
                    SETVAR(_unit,busy,false);
                }, [
                    _unit
                ], 2] call CBA_fnc_waitAndExecute;
                //_unit forceWeaponFire ["HandGrenadeMuzzle","HandGrenadeMuzzle"];
                //_unit forceWeaponFire ["MiniGrenadeMuzzle","MiniGrenadeMuzzle"];
            };
        };
    };
    if (GETMVAR(forceUGLs,true)) then {
        private _chance = round random 100;
        if (
            _chance <= GETMVAR(UGLChance,25) &&
            {_distance <= GETMVAR(UGLMaxRange,200)} &&
            {_distance > GETMVAR(UGLMinRange,50)}
        ) then {
            private _UGL = _unit call FUNC(hasUGL);
            if (_UGL isNotEqualTo "") then {
                [_unit, _UGL, _enemyTarget] call FUNC(fireUGL);
            };
        };
    };
};
