#include "..\script_macros.hpp"

#define random(MIN, MAX) \
([MIN, MAX] call FUNC(RandomRange))

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

#include "..\..\customization\gearSettings.sqf"
