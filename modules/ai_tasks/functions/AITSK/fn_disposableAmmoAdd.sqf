#include "script_component.hpp"

params ["_unit", "_type"];

private _wepArray = ["rhs_weap_rpg26","rhs_weap_rshg2","rhs_weap_m136","rhs_weap_m136_hedp","rhs_weap_m136_hp","rhs_weap_m72a7","rhs_weap_panzerfaust60","rhs_weap_rpg75","rhs_weap_m80"];

_wepArray apply {
	if (toLower(secondaryWeapon _unit) isEqualTo _x) exitWith {
		private _magazine = getArray (configFile >> "CfgWeapons" >> _x >> "magazines") select 0;

		_unit addSecondaryWeaponItem _magazine;

		//hint format["Added %1:%2 to %3 - %4",_x,_magazine,_unit,secondaryWeaponItems _unit];
	};
};
