#include "script_component.hpp"

//check if mission is live or not
private _jiptime = 30;
if (!isNil "FW_JIPDENYTIME") then {
	_jiptime = GVAR(JIPDENYTIME);
};

private _unit = player;
private _var = _unit getvariable "StartInVehicle";
if (CBA_missionTime > _jiptime) exitwith {};
if (isNil "_var") exitwith {};
if (count "_var" <= 0) exitwith {};
_var params ["_vehicle",["_seattype","ANY"],["_seatindex",0]];

[_unit,_vehicle,_seattype,_seatindex] call FUNC(StartInVehicle_moveInVehicle);
