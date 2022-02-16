#include "script_macros.hpp"
#define postInitServer

["west","east","guer","civ"] apply {
    private _team = _x;
    private _markerName = format ["respawn_%1", _team];
    createMarker [_markerName, [0, 0, 0]];
    _markerName setMarkerShape "ICON";
    _markerName setMarkerType "EMPTY";
};

GVAR(EventDisconnectHandle) = addMissionEventHandler ["HandleDisconnect", {_this call FUNC(EventDisconnect);}];

[{
    getClientStateNumber > 10
},{
    diag_log "getClientStateNumber trigered";
    LOG_1("getClientStateNumber EH triggered with time: %1",CBA_missionTime);
}, []] call CBA_fnc_waitUntilAndExecute;

setViewDistance GVAR(ServerViewDistance);

[{
	GVAR(endConditionsPFH) = [{
	    params ["_args", "_idPFH"];

		if (GETMVAR(Disable_Endconditions,false)) exitWith {
			[_idPFH] call CBA_fnc_removePerFrameHandler;
		};

		#include "..\customization\endConditions.sqf" //DO NOT REMOVE

		//The time limit in minutes variable called GVAR(TimeLimit) is set in customization/settings.sqf, to disable the time limit set it to 0
		if ((GVAR(TimeLimit) > 0) && {((CBA_MissionTime / 60) >= GVAR(TimeLimit))}) exitWith { //It is recommended that you do not remove the time limit end condition
			GVAR(TimeLimitMessage) call FUNC(EndMission);
			[_idPFH] call CBA_fnc_removePerFrameHandler;
		};

		if (missionNamespace getVariable [QGVAR(MissionEnded), false]) exitWith {
			[_idPFH] call CBA_fnc_removePerFrameHandler;
		};

	}, GVAR(EndConditionFrequency), []] call CBA_fnc_addPerFrameHandler;
}, [], 3] call CBA_fnc_waitAndExecute;

// Chain of Command (CoC) logic
GVAR(CO_Blufor) = objNull;
GVAR(CO_Opfor) = objNull;
GVAR(CO_Indfor) = objNull;
GVAR(CO_Civfor) = objNull;

[{
  GVAR(CO_Blufor) = [blufor] call FUNC(getCO);
  GVAR(CO_Opfor) = [opfor] call FUNC(getCO);
  GVAR(CO_Indfor) = [independent] call FUNC(getCO);
  GVAR(CO_Civfor) = [civilian] call FUNC(getCO);

  /* TRACE_4("COs - Blu = %1, Op = %2, Ind = %3, Civ = %4", GVAR(CO_Blufor), GVAR(CO_Opfor), GVAR(CO_Indfor), GVAR(CO_Civfor)); */
}, GVAR(CoC_CheckFrequency), []] call CBA_fnc_addPerFrameHandler;

#include "..\customization\inits\PostInitServer.sqf" //DO NOT REMOVE
#include "..\modules\modules.sqf" //DO NOT REMOVE
