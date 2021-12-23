#include "..\..\script_macros.hpp"

params [["_unit", objNull, [objNull]], ["_unitsInGroup", [], [[]]]];
(group _unit) setBehaviour "SAFE";
(group _unit) setSpeedMode "LIMITED";
_unit setUnitPos "UP";
while {((behaviour _unit ) != "COMBAT") && ((behaviour _unit ) != "STEALTH") && ((behaviour _unit ) != "AWARE") && (alive _unit)} do {
	while { (diag_fps < 15) } do {
		sleep 60;
	};
	scopeName "SAFE_Loop1";
	_pos = getPos _unit;
	if ( (isOnRoad (getPos _unit)) && (alive _unit )) then {
		while { isOnRoad _pos } do {
			_pos = _unit getPos [4, (random 360)];
			sleep 0.1;
		};
		_unit doMove _pos;
		Waituntil {sleep 4; unitReady _unit;};
	};
	_CurrentAction = GETVAR(_unit,LOITERINGACT,0);
	if (((behaviour _unit) == "COMBAT") || ((behaviour _unit) == "AWARE") || ((behaviour _unit) == "STEALTH")) then {  breakOut "SAFE_Loop1";};
	_RandomAction = selectRandom ([1,3,4] - [_CurrentAction]);
	switch (_RandomAction) do {
		case 1:
		{
			//Wander around and play random animation
			//Get random position
			SETVAR(_unit,LoiteringAct,1);
			_rnd = random 10;
			_dist = (_rnd + 5);
			_dir = random 360;
			_UnitPosition = getposworld _unit ;
			_positions = [(_UnitPosition select 0) + (sin _dir) * _dist, (_UnitPosition select 1) + (cos _dir) * _dist, 0];
			if ( isOnRoad _positions) then {
				while {isOnRoad _positions} do {
					if (!(alive _unit ))exitWith {};
					_rnd = random 3;
					_dist = (_rnd + 5);
					_dir = random 360;
					_UnitPosition = getposworld _unit ;
					_positions = [(_UnitPosition select 0) + (sin _dir) * _dist, (_UnitPosition select 1) + (cos _dir) * _dist, 0];
				};
			};
			if (!(alive _unit ))exitWith {};
			_unit  doMove _positions;
			if (((behaviour _unit) == "COMBAT") || ((behaviour _unit) == "AWARE") || ((behaviour _unit) == "STEALTH")) then {  breakOut "SAFE_Loop1";};
			WaitUntil {sleep 2; (_unit  distance _positions) < 2};
			_RandomAnimationList = selectRandom ["Acts_CivilTalking_1","Acts_CivilTalking_2", "Acts_CivilIdle_1", "Acts_CivilIdle_2", "Acts_ShieldFromSun_loop"];
			[_unit ,_RandomAnimationList] remoteExec ["playMoveEverywhere",0];
		};

		case 3:
		{
			if (!(alive _unit ))exitWith {};
			SETVAR(_unit,LOITERINGACT,3);
			_ClosestUnit = [(_unitsInGroup - [_unit ]), _unit] call FUNC(ClosestObject);
			SETVAR(_ClosestUnit,LOITERINGACT,3);
			if (((behaviour _unit) == "COMBAT") || ((behaviour _unit) == "AWARE") || ((behaviour _unit) == "STEALTH")) then {  breakOut "SAFE_Loop1";};
			_rnd = random 10;
			_dist = (_rnd + 5);
			_dir = random 360;
			_UnitPosition = getposworld _unit ;
			_positions = [(_UnitPosition select 0) + (sin _dir) * _dist, (_UnitPosition select 1) + (cos _dir) * _dist, 0];
			if ( isOnRoad _positions) then {
				while {isOnRoad _positions} do {
					_rnd = random 3;
					_dist = (_rnd + 5);
					_dir = random 360;
					_UnitPosition = getposworld _unit ;
					_positions = [(_UnitPosition select 0) + (sin _dir) * _dist, (_UnitPosition select 1) + (cos _dir) * _dist, 0];
				};
			};
			_unit  doMove _positions;
			_ClosestUnit doMove _positions;
			_rnd = random 4;
			_dist = (_rnd + 3);
			_dir = random 360;
			_positions2 = [(_positions select 0) + (sin _dir) * _dist, (_positions select 1) + (cos _dir) * _dist, 0];
			_ClosestUnit doMove _positions2;
			WaitUntil {sleep 2;(_unit  distance _positions) < 5 && (_ClosestUnit distance _positions) < 5};


			if (!(alive _unit ))exitWith {};
			if ((behaviour _unit )  == "COMBAT") then {  breakOut "SAFE_Loop1";};
			sleep 10;

			_ClosestUnit spawn
			{
				_Counter = 0;
				While {(_Counter < 11) && (alive _this)} do
				{
					sleep (random 2);
					_RandomAnimationList = selectRandom ["AmovPercMstpSnonWnonDnon_exercisePushup","Acts_AidlPercMstpSlowWrflDnon_pissing","Acts_ShieldFromSun_loop","Acts_CivilIdle_1"];
					[_this,_RandomAnimationList] remoteExec ["playMoveEverywhere",0];
					_Counter = _Counter + 1;
					sleep 10;
				};
			};
			if (!(alive _unit ))exitWith {};
			_unit  spawn
			{
				_Counter = 0;
				While { ((_Counter < 11) && (alive _this)) } do
				{
					sleep (random 2);
					_RandomAnimationList = selectRandom ["AmovPercMstpSnonWnonDnon_exercisePushup","Acts_AidlPercMstpSlowWrflDnon_pissing","Acts_ShieldFromSun_loop","Acts_CivilIdle_1"];
					[_this,_RandomAnimationList] remoteExec ["playMoveEverywhere",0];
					_Counter = _Counter + 1;
					sleep 12;
				};
			};
		};

		case 4:
		{
			//Wander around and sitdown
			//Get random position
			SETVAR(_unit,LOITERINGACT,4);
			_rnd = random 10;
			_dist = (_rnd + 5);
			_dir = random 360;
			_UnitPosition = getposworld _unit ;
			_positions = [(_UnitPosition select 0) + (sin _dir) * _dist, (_UnitPosition select 1) + (cos _dir) * _dist, 0];
			if ( isOnRoad _positions) then {
				while {isOnRoad _positions} do {
					_rnd = random 3;
					_dist = (_rnd + 5);
					_dir = random 360;
					_UnitPosition = getposworld _unit ;
					_positions = [(_UnitPosition select 0) + (sin _dir) * _dist, (_UnitPosition select 1) + (cos _dir) * _dist, 0];
				};
			};
			if (((behaviour _unit) == "COMBAT") || ((behaviour _unit) == "AWARE") || ((behaviour _unit) == "STEALTH")) then {  breakOut "SAFE_Loop1";};
			_unit  doMove _positions;
			WaitUntil {sleep 2;((getPos _unit)  distance _positions) < 2};
			if (true) exitwith {
				breakOut "SAFE_Loop1";
				sleep 0.5;
				_unit setBehaviour "SAFE";
				sleep 2;
				doStop _unit;
				sleep 0.5;
				_unit action ["SitDown", _unit];
				sleep 0.5;
				doStop _unit;
			};
			//sleep 2;
			//doStop _unit;
			//sleep 0.5;
			//_unit action ["SitDown", _unit];
			//for "_i" from 0 to 10 do {
			//	if ((behaviour _unit )  == "COMBAT") then {  breakOut "SAFE_Loop1";};
			//	if (!(alive _unit ))exitWith {};
			//	sleep 10;
			//};
			//_unit action ["SitDown", _unit];
		};
	};

	if (((behaviour _unit) == "COMBAT") || ((behaviour _unit) == "AWARE") || ((behaviour _unit) == "STEALTH")) then {  breakOut "SAFE_Loop1";};
	for "_i" from 0 to 4 do {
		if (((behaviour _unit) == "COMBAT") || ((behaviour _unit) == "AWARE") || ((behaviour _unit) == "STEALTH")) then {  breakOut "SAFE_Loop1";};
		if (!(alive _unit ))exitWith {};
		sleep 5;
	};
	if (((behaviour _unit) == "COMBAT") || ((behaviour _unit) == "AWARE") || ((behaviour _unit) == "STEALTH")) then {  breakOut "SAFE_Loop1";};
};

{
	deleteWaypoint _x;
} foreach waypoints (group _unit);

sleep 300;
(group _unit) setBehaviour "SAFE";
sleep 10;
Waituntil {sleep 60; (!(alive _unit)) || ((behaviour _unit) != "COMBAT")};
