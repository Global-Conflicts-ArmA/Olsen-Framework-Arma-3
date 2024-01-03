#include "script_component.hpp"

params["_magType"];

private _pos = player modelToWorld [0, 1, 0];
_pos = [_pos select 0, _pos select 1, (_pos select 2)+1.5];
private _dir = getDir player;
private _ammoType = "",

switch (_magType) do {
	// ace throwable flares
	case "ACE_HandFlare_White":{_ammoType = getText (configFile >> "CfgMagazines" >> "vn_m127_mag" >> "ammo");};
	case "ACE_HandFlare_Green":{_ammoType = getText (configFile >> "CfgMagazines" >> "vn_m128_mag" >> "ammo");};
	case "ACE_HandFlare_Yellow":{_ammoType = getText (configFile >> "CfgMagazines" >> "vn_m127_mag" >> "ammo");};
	case "ACE_HandFlare_Red":{_ammoType = getText (configFile >> "CfgMagazines" >> "vn_m129_mag" >> "ammo");};
	
	// karts flaregun ammo
	case "FlareWhite_F":{_ammoType = getText (configFile >> "CfgMagazines" >> "vn_m127_mag" >> "ammo");};
	case "FlareGreen_F":{_ammoType = getText (configFile >> "CfgMagazines" >> "vn_m128_mag" >> "ammo");};
	case "FlareYellow_F":{_ammoType = getText (configFile >> "CfgMagazines" >> "vn_m127_mag" >> "ammo");};
	case "FlareRed_F":{_ammoType = getText (configFile >> "CfgMagazines" >> "vn_m129_mag" >> "ammo");};
	
	// SOG dispoable Flarelauncher Ammo
	case "vn_m127_mag":{_ammoType = getText (configFile >> "CfgMagazines" >> "vn_m127_mag" >> "ammo");};
	case "vn_m128_mag":{_ammoType = getText (configFile >> "CfgMagazines" >> "vn_m128_mag" >> "ammo");};
	case "vn_m129_mag":{_ammoType = getText (configFile >> "CfgMagazines" >> "vn_m129_mag" >> "ammo");};
};

player removeMagazine _magType;

[player, "Gear"] remoteExec ["playActionNow"];

[{
  Params ["_ammoType", "_pos", "_dir"];

  [player, "tin_flareFire"] remoteExec ["say3D"];

  [{
	params ["_ammoType", "_pos", "_dir"];

    private _flare = _ammoType createVehicle _pos;

	_flare setVectorDirAndUp [[sin _dir * cos  GVAR(flareAngle), cos _dir * cos  GVAR(flareAngle), sin  GVAR(flareAngle)], [0,0,1]];

    [_flare, "tin_flareShot"] remoteExec ["say3D"];
	
  }, [_ammoType, _pos, _dir], 0.95] call CBA_fnc_waitAndExecute;
}, [_ammoType, _pos, _dir], 1] call CBA_fnc_waitAndExecute;
