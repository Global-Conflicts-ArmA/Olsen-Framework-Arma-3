#include "script_component.hpp"

#define random(var1, var2) RNDRANGE(var1,var2)

private _temp = "";

#define SET_GROUP(groupName) _temp = #groupName + package;\
call compile format ['%1 = {

#define END_GROUP };', _temp]

#define ADD_GROUP(groupName) call call compile format ["%1", #groupName + package]

params ["_unit", "_type", ["_groupId", "", [""]]];

if !(_groupId isEqualTo "") then {
	(group _unit) setGroupId [_groupId];
};

if !(local _unit) exitWith {};

SETPVAR(_unit,Loadout,_type);
_unit setVariable ["BIS_enableRandomization", false];

FUNC(AddItem) = {([_unit, _type] + _this) call FUNC(AddItemOrg);};
FUNC(AddItemRandom) = {([[_unit, _type]] + [_this]) call FUNC(AddItemRandomOrg);};

switch _type do {
	#include "..\..\customization\loadouts.sqf"
	default {
		ERROR_2("UNIT: %1 USING TYPE: %2 IS USING AN INVALID GEAR TYPE!",_unit,_type);
	};
};