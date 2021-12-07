#include "script_component.hpp"

private _version = 0.1;

["Call Mission", "Adds a new sections to the framework menu that allows COs and admins to call the mission.", "Starfox64 &amp; StatusRed", _version] call EFUNC(FW,RegisterModule);

GVAR(IsAdmin) = false;
GVAR(MissionCalls) = [];
GVAR(COC) = [];

private _waitTime = 60;
[{
	/* diag_log format ["INFO: COC = %1", GVAR(COC)]; */
	GVAR(COC) apply {
		private _coc = _x;
		private _found = false;

		(_coc select 1) apply {
			private _groupID = _x;

			if (_found) exitWith {};

				allGroups apply {
					private _group = _x;

					/* diag_log format ["INFO: This group = %1", (groupID _group)]; */

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

[{!isnull (findDisplay 46)}, {
  // serverCommandAvailable must be executed from a UI Eh.
  (findDisplay 46) displayAddEventHandler ["MouseMoving", {
    if (serverCommandAvailable "#kick") then {
      GVAR(IsAdmin) = true;
    } else {
      GVAR(IsAdmin) = false;
    };
  }];
}, []] call CBA_fnc_waitUntilAndExecute;

// Admin Call Options
["AdminBLUFOR", sideUnknown, "Call Mission BLUFOR Victory", [[west, "AdminCalled", true], [east, "AdminCalled", false], [independent, "AdminCalled", false], [civilian, "AdminCalled", false]]] call FUNC(RegisterMissionCall);
["AdminOPFOR", sideUnknown, "Call Mission OPFOR Victory", [[west, "AdminCalled", false], [east, "AdminCalled", true], [independent, "AdminCalled", false], [civilian, "AdminCalled", false]]] call FUNC(RegisterMissionCall);
["AdminINDFOR", sideUnknown, "Call Mission INDFOR Victory", [[west, "AdminCalled", false], [east, "AdminCalled", false], [independent, "AdminCalled", true], [civilian, "AdminCalled", false]]] call FUNC(RegisterMissionCall);
["AdminCIVFOR", sideUnknown, "Call Mission CIVFOR Victory", [[west, "AdminCalled", false], [east, "AdminCalled", false], [independent, "AdminCalled", false], [civilian, "AdminCalled", true]]] call FUNC(RegisterMissionCall);

#include "settings.sqf"

if (!isDedicated) then {
  private _sleepTime = 0.1;

  [{
		#include "menu.sqf"
  }, [], _sleepTime] call CBA_fnc_waitAndExecute;
};
