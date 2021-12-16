#include "..\..\script_macros.hpp"

//This script will have the AI perform certain actions.
private ["_Unit", "_UnitGroup", "_CurrentAction", "_RandomAction", "_rnd", "_dist", "_dir", "_UnitPosition", "_positions", "_RandomAnimationList", "_ClosestUnit", "_positions2", "_Fire", "_Counter", "_SwitchMoveList", "_PlayActionList"];
_Unit = _this select 0;
_UnitGroup = _this select 1;


While {GETVAR(_Unit,LOITERING,true) && alive _Unit} do
{
	_CurrentAction = GETVAR(_Unit,LOITERINGACT,0);

	_RandomAction = ([1,2,3,4] - [_CurrentAction]) call BIS_fnc_selectrandom;
	switch (_RandomAction) do
	{
			case 1:
			{
				//Wander around and play random animation
				//Get random position
				SETVAR(_Unit,LOITERINGACT,1);
				_rnd = random 10;
				_dist = (_rnd + 5);
				_dir = random 360;
				_UnitPosition = getposworld _Unit;
				_positions = [(_UnitPosition select 0) + (sin _dir) * _dist, (_UnitPosition select 1) + (cos _dir) * _dist, 0];
				_Unit doMove _positions;
				WaitUntil {(_Unit distance _positions) < 2};
				_RandomAnimationList = ["AmovPercMstpSnonWnonDnon_exercisePushup","Acts_AidlPercMstpSloWWrflDnon_warmup_6_loop","Acts_Kore_Introducing"] call BIS_fnc_selectrandom;
				[_Unit,_RandomAnimationList] remoteExec ["playMoveEverywhere",0];
			};
			case 2:
			{
				SETVAR(_Unit,LOITERINGACT,2);
				_ClosestUnit = [(_UnitGroup - [_Unit]),_Unit] call FUNC(ClosestObject);
				SETVAR(_ClosestUnit,LOITERINGACT,2);

				_rnd = random 10;
				_dist = (_rnd + 5);
				_dir = random 360;
				_UnitPosition = getposworld _Unit;
				_positions = [(_UnitPosition select 0) + (sin _dir) * _dist, (_UnitPosition select 1) + (cos _dir) * _dist, 0];
				_positions2 = [(_positions select 0) + 5, (_positions select 1) + 5,_positions select 2];

				_Unit doMove _positions;
				_ClosestUnit doMove _positions2;

				WaitUntil {(_Unit distance _positions) < 2 && (_ClosestUnit distance _positions2) < 2};

				sleep 10;
				_Unit lookAt _ClosestUnit;
				_ClosestUnit lookAt _Unit;
				sleep 5;



				[_unit , (selectRandom ["Acts_Kore_Introducing","Acts_B_hub01_briefing", "Acts_B_M02_briefing", "Acts_A_M03_briefing", "Acts_HUBABriefing"])] remoteExec ["switchMoveEverywhere",0];
                sleep 2;
                [_ClosestUnit,"Acts_Kore_TalkingOverRadio_loop"] remoteExec ["switchMoveEverywhere",0];
                sleep 80;
                [_unit ,""]         remoteExec ["switchMoveEverywhere",0];
                [_ClosestUnit,""]   remoteExec ["switchMoveEverywhere",0];



			};
			case 3:
			{
				SETVAR(_Unit,LOITERINGACT,3);
				_ClosestUnit = [(_UnitGroup - [_Unit]),_Unit] call FUNC(ClosestObject);
				SETVAR(_ClosestUnit,LOITERINGACT,3);

				_rnd = random 10;
				_dist = (_rnd + 5);
				_dir = random 360;
				_UnitPosition = getposworld _Unit;
				_positions = [(_UnitPosition select 0) + (sin _dir) * _dist, (_UnitPosition select 1) + (cos _dir) * _dist, 0];


				_Unit doMove _positions;
				_ClosestUnit doMove _positions;

				WaitUntil {(_Unit distance _positions) < 5 && (_ClosestUnit distance _positions) < 5};

				_rnd = random 5;
				_dist = (_rnd + 3);
				_dir = random 360;
				_positions2 = [(_positions select 0) + (sin _dir) * _dist, (_positions select 1) + (cos _dir) * _dist, 0];
				_ClosestUnit doMove _positions2;

				sleep 10;

				_Fire = "FirePlace_burning_F" createvehicle _positions2;
				_Fire spawn {sleep 120;deletevehicle _this;};

				sleep 2;
				_ClosestUnit lookAt _Fire;
				_Unit lookAt _Fire;

				_ClosestUnit spawn
				{
					_Counter = 0;
					While {_Counter < 11} do
					{
						sleep (random 2);
						_RandomAnimationList = ["AmovPercMstpSnonWnonDnon_exercisePushup","SitDown","AmovPercMstpSnonWnonDnon_SaluteIn"] call BIS_fnc_selectrandom;
						[_this,_RandomAnimationList] remoteExec ["playMoveEverywhere",0];
						_Counter = _Counter + 1;
						sleep 10;
					};
				};

				_Unit spawn
				{
					_Counter = 0;
					While {_Counter < 11} do
					{
						sleep (random 2);
						_RandomAnimationList = ["AmovPercMstpSnonWnonDnon_exercisePushup","SitDown","AmovPercMstpSnonWnonDnon_SaluteIn"] call BIS_fnc_selectrandom;
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
				SETVAR(_Unit,LOITERINGACT,4);
				_rnd = random 10;
				_dist = (_rnd + 5);
				_dir = random 360;
				_UnitPosition = getposworld _Unit;
				_positions = [(_UnitPosition select 0) + (sin _dir) * _dist, (_UnitPosition select 1) + (cos _dir) * _dist, 0];
				_Unit doMove _positions;
				WaitUntil {(_Unit distance _positions) < 2};
				sleep 2;
				[_Unit,"SitDown"] remoteExec ["playActionNowEverywhere",0];
				sleep 100;
				[_Unit,"walkf"] remoteExec ["playActionNowEverywhere",0];


			};
	};

				//_SwitchMoveList = ["Acts_Kore_TalkingOverRadio_loop","Acts_B_hub01_briefing"];
			//_PlayActionList = ["reloadMagazine"];
			//[player,"Acts_WarmUp_actions"] remoteExec ["switchMoveEverywhere",0];
			//[player,"AmovPercMstpSrasWrflDnon_AmovPercMevaSrasWrflDb"] remoteExec ["playMoveEverywhere",0];
			//[player,"Acts_ComingInSpeakingWalkingOut_2"] remoteExec ["playMoveEverywhere",0];
			//[player,"grabdrag"] remoteExec ["playActionNowEverywhere",0];


sleep 120;
};
