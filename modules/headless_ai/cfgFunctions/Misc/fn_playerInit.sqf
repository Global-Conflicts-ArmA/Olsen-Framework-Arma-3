#include "..\..\script_macros.hpp"


if (GETPLVAR(hearingHandler,false)) exitwith {};

player addEventHandler ["FiredMan",{
	params [
		"_firer",
		"_weapon",
		"_muzzle",
		"_mode",
		"_ammo",
		"_magazine",
		"_projectile",
		"_gunner"
	];
	//check for lockout
	if (CBA_MissionTime < (GETPLVAR(revealLockout,-1))) exitWith {
		if (GVAR(UseMarkers)) then {
            //need debug
		};
	};
	SETPLVAR(revealLockout,CBA_MissionTime + 5);
	allUnits select {(!isplayer _x) && {(_x distance2d _firer <= GVAR(HearingDistance))}} apply {
		private _distance = _x distance _firer;
		private _travelTime = _distance / 343;
		private _revealValue = linearConversion [200,GVAR(HearingDistance),_distance,4,GVAR(HearingMinIncrease)];
		LOG_5("%1 got revealed to %2 at %3m, %4 seconds, %5 reveal value.",_firer,_x,_distance,_travelTime,_revealValue);
		[{
			params [
                "_firer",
                "_AIunit",
                "_revealValue"
            ];
			_AIunit reveal [_firer,_revealValue];
		}, [_firer,_x,_distance,_revealValue], _travelTime] call CBA_fnc_waitAndExecute;
	};
}];

SETPLVAR(hearingHandler,true);
