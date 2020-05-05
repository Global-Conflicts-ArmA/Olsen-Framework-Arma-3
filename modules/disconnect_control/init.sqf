["Disconnect Control", "Controls when player bodies should be deleted", "Olsen and Perfk"] call FUNC(RegisterModule);

ace_respawn_RemoveDeadBodiesDisconnected = false;

if (isServer) then {
	FW_EventDisconnectHandle_BodyCleanup = addMissionEventHandler ["HandleDisconnect", {_this call FNC_EventDisconnect_BodyCleanup;}];
};

FNC_EventDisconnect_BodyCleanup = {

	private ["_unit"];

	_unit = _this select 0;

	if (GETVAR(_unit,Tracked,false)) then {
		
		#include "settings.sqf"

		if (time < disconnect_control_time * 60 && (side _unit) in disconnect_control_sides) then {

			deleteVehicle _unit;
			
		};
	
	};

};