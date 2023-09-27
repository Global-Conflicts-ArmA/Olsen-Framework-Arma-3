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
    if (_cansee > 0.6 && {_distance < GETMVAR(SightAidEngageDistance,200)}) then {
        _unit reveal [_enemyTarget, 4];
    } else {
        if (_cansee > 0.6) then {
    		private _revealValue = linearConversion [100, GETMVAR(SightAidDistance,600), _distance, 4, GETMVAR(SightAidMinIncrease,1)];
    		_unit reveal [_enemyTarget, _knowsabouttarget + _revealValue];
    		if (GETMVAR(UseMarkers,false)) then {
    			LOG_4("revealing: %1 to %2, old knows: %3 new: %4",_enemyTarget,_unit,_knowsabouttarget,(_unit knowsabout _enemyTarget));
    		};
    	};
    };
};

if (_cansee > 0.6 && {_distance < GETMVAR(SightAidEngageDistance,200)}) then {
	if (INVEHICLE(_unit)) then {
		private _veh = vehicle _unit;
		if (
		    !(GETVAR(_unit,busy,false)) &&
		    {_knowsabouttarget > 2.5}
		) then {
			if (_unit isEqualTo (gunner _veh)) then {
				[_unit, true, _enemyTarget] call FUNC(watchEnemy);
				[{
					[_this select 0] call FUNC(isAimed);
				}, {
					[_unit] call FUNC(fireWeapon);
				}, [_unit], 2, {}] call CBA_fnc_waitUntilAndExecute;
			};
		};
	} else {
		if (
		    !(GETVAR(_unit,busy,false)) &&
		    {_knowsabouttarget > 2.5}
		) then {
		    // Random grenade chance - random check, range check, then check for grenades, check for building, nearby friendlies to target, if none - throw grenade
		    if (GETMVAR(forceGrenades,true) && {!(GETVAR(_unit,busy,false))}) then {
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
		                [_unit, _frags] call FUNC(throwGrenade);
		            };
		        };
		    };
		    if (GETMVAR(forceUGLs,true) && {!(GETVAR(_unit,busy,false))}) then {
		        private _chance = round random 100;
		        if (
		            _chance <= GETMVAR(UGLChance,25) &&
		            {_distance <= GETMVAR(UGLMaxRange,200)} &&
		            {_distance > GETMVAR(UGLMinRange,50)}
		        ) then {
		            private _UGL = _unit call FUNC(hasUGL);
		            TRACE_2("",_unit,_UGL);
		            if (_UGL isNotEqualTo "") then {
		                private _magList = [_unit, _UGL, false] call FUNC(muzzleMags);
		                TRACE_2("",_unit,_magList);
		                if (_magList isNotEqualTo []) then {
		                    private _index = _magList findIf {
		                        private _type = [_x] call FUNC(UGLRoundType);
		                        (_type isEqualTo 1)
		                    };
		                    if (_index isNotEqualTo -1) then {
		                        _unit loadMagazine [[0], currentWeapon _unit, _magList select _index];
		                        [_unit, _UGL, _enemyTarget] call FUNC(fireUGL);
		                    };
		                };
		            };
		        };
		    };
		    if (GETMVAR(forceAT,true) && {!(GETVAR(_unit,busy,false))}) then {
		        private _chance = round random 100;
		        if (
		            _chance <= GETMVAR(ATChance,25) &&
		            {_distance <= GETMVAR(ATMaxRange,200)} &&
		            {_distance > GETMVAR(ATMinRange,50)}
		        ) then {
		            if (_unit call FUNC(hasAT)) then {
		                [_unit, _enemyTarget] call FUNC(fireAT);
		            };
		        };
		    };
			if !(GETVAR(_unit,busy,false)) then {
				[_unit, true, _enemyTarget] call FUNC(watchEnemy);
				[{
					[_this select 0] call FUNC(isAimed);
				}, {
					[_unit] call FUNC(fireWeapon);
				}, [_unit], 2, {}] call CBA_fnc_waitUntilAndExecute;
			};
		};
	};
};


