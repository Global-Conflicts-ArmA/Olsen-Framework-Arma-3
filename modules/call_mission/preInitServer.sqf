#include "script_component.hpp"

GVAR(MissionCalls) = [];
GVAR(COC) = [];

GVAR(CallMissionEh) = ["frameworkCallMission", {_this call FUNC(CallMission);}] call CBA_fnc_addEventHandler;

private _waitTime = 60;
[{
	GVAR(COC) apply {
		private _coc = _x;
		private _found = false;

		(_coc select 1) apply {
			private _groupID = _x;

			if (_found) exitWith {};

				allGroups apply {
					private _group = _x;

					if (_group != grpNull && (groupID _group) == _groupID && (side leader _group) == (_coc select 0)) exitWith {
						if !((leader _group) getVariable ["FW_IsCO", false]) then {
							(leader _group) setVariable ["FW_IsCO", true, false];

							playableUnits apply {
								if (((side _x) == (side leader _group)) && _x != (leader _group)) then {
									_x setVariable ["FW_IsCO", false, false];
								};
							};
						};
						_found = true;
					};
				};
		};
	};
} , _waitTime, []] call CBA_fnc_addPerFrameHandler;

// Admin Call Options
["AdminBLUFOR", sideUnknown, "Call Mission BLUFOR Victory", [[west, "AdminCalled", true], [east, "AdminCalled", false], [independent, "AdminCalled", false], [civilian, "AdminCalled", false]]] call FUNC(RegisterMissionCall);
["AdminOPFOR", sideUnknown, "Call Mission OPFOR Victory", [[west, "AdminCalled", false], [east, "AdminCalled", true], [independent, "AdminCalled", false], [civilian, "AdminCalled", false]]] call FUNC(RegisterMissionCall);
["AdminINDFOR", sideUnknown, "Call Mission INDFOR Victory", [[west, "AdminCalled", false], [east, "AdminCalled", false], [independent, "AdminCalled", true], [civilian, "AdminCalled", false]]] call FUNC(RegisterMissionCall);
["AdminCIVFOR", sideUnknown, "Call Mission CIVFOR Victory", [[west, "AdminCalled", false], [east, "AdminCalled", false], [independent, "AdminCalled", false], [civilian, "AdminCalled", true]]] call FUNC(RegisterMissionCall);

#include "settings.sqf"
