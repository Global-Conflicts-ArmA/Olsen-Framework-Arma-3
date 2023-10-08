#include "script_component.hpp"

params ["_unit"];

private _target = _unit getVariable [QGVAR(SA_target), objNull];
//TRACE_2("sightAid combat func",_unit,_target);
if (_target isEqualTo objNull) exitwith {};
private _distance = _unit distance2D _target;
//TRACE_2("sightAid combat dist",_unit,_distance);
if (_distance > GETMVAR(SightAidDistance,800)) exitwith {};
private _knowsAbout = _unit knowsAbout _target;
if (_knowsAbout < 4) then {
    if (
        (_distance < GETMVAR(SightAidEngageDistance,200)) ||
        (
            INVEHICLE(_unit) &&
            {_distance < ((GETMVAR(SightAidEngageDistance,200)) * 2)}
        )
    ) then {
        _unit reveal [_target, 4];
        _unit doTarget _target;
        _unit doWatch _target;
    } else {
    	private _revealValue = linearConversion [100, GETMVAR(SightAidDistance,600), _distance, 4, GETMVAR(SightAidMinIncrease,1)];
    	_unit reveal [_target, _knowsAbout + _revealValue];
    	if (GETMVAR(VerboseDebug,false)) then {
    		LOG_4("revealing: %1 to %2, old knows: %3 new: %4",_target,_unit,_knowsAbout,(_unit knowsabout _target));
    	};
    };
} else {
    if (INVEHICLE(_unit)) then {
        if (
            _distance < ((GETMVAR(SightAidEngageDistance,200)) * 2) ||
            ([group _unit] call FUNC(isInCombat))
        ) then {
        	private _veh = vehicle _unit;
        	if (
        	    !(GETVAR(_unit,busy,false))
        	) then {
        		if (_unit isNotEqualTo (driver _veh)) then {
                    [_unit, _target, 5] call FUNC(PrepToFire);
        		};
        	};
        };
    } else {
        if (
            _distance < GETMVAR(SightAidEngageDistance,200) ||
            ([group _unit] call FUNC(isInCombat))
        ) then {
            if (
        	    !(GETVAR(_unit,busy,false))
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
        	                        [_unit, _UGL, _target] call FUNC(fireUGL);
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
        	                [_unit, _target] call FUNC(fireAT);
        	            };
        	        };
        	    };
        		if !(GETVAR(_unit,busy,false)) then {
        			[_unit, _target, 5] call FUNC(PrepToFire);
        		};
        	};
        };
    };
};
