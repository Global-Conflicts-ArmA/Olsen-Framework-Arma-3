#include "..\..\script_macros.hpp"


params ["_unit"];

private _HasMine = false;
private _magazinesAmmo = magazinesAmmo _unit;
if (isNil "_magazinesAmmo") exitWith {
    [false,[],false,[]]
};
private _HASSATCHEL = false;
private _ActualObj = [];
private _SatchelArray = [];

{
	private _Magazine = _x select 0;
	private _value = (configfile >> "CfgMagazines" >> _Magazine >> "nameSound") call BIS_fnc_getCfgData;

	if (_value isEqualTo "satchelcharge") then {
		_SatchelArray pushback [((configfile >> "CfgMagazines" >> _Magazine >> "ammo") call BIS_fnc_getCfgData),_Magazine];
		_HASSATCHEL = true;
	};
	if (_value isEqualTo "mine") then {
		_HasMine = true;
		_ActualObj pushback [((configfile >> "CfgMagazines" >> _Magazine >> "ammo") call BIS_fnc_getCfgData),_Magazine];
	};


} forEach _magazinesAmmo;

private _PassArray = [_HASSATCHEL,_ActualObj,_HasMine,_SatchelArray];
LOG_2("MineCheck %1: %2",_unit,_PassArray);
_PassArray
