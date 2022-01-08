#include "script_component.hpp"

params["_magType"];

private _pos = player modelToWorld [0, 1, 0];
_pos = [_pos select 0, _pos select 1, 1.5];
private _dir = getDir player;
private _magColor = [0, 0, 0];

switch (_magType) do {
  case "FlareWhite_F":{_magColor = [1,1,1];};
  case "FlareGreen_F":{_magColor = [0.25,0.5,0.25];};
  case "FlareYellow_F":{_magColor = [0.5,0.5,0.25];};
  case "FlareRed_F":{_magColor = [0.5,0.25,0.25];};
};

private _ammoType = getText (configFile >> "CfgMagazines" >> _magType >> "ammo");
player removeMagazine _magType;

[player, "Gear"] remoteExec ["playActionNow"];

[{
  params ["_ammoType", "_pos", "_dir", "_magColor"];

  [player, "tin_flareFire"] remoteExec ["say3D"];

  [{
    params ["_ammoType", "_pos", "_dir", "_magColor"];

    private _flare = _ammoType createVehicle _pos;
    _flare setVelocity [sin (_dir) * GVAR(flareAngle), cos (_dir) * GVAR(flareAngle), 80];

    [_flare, "tin_flareShot"] remoteExec ["say3D"];

    [{
      params ["_flare", "_magColor"];

      private _flareLight = "#lightpoint" createVehicle position _flare;
      _flareLight lightAttachObject [_flare, [0, 0, 0]];

      ["paraflare_evt_flareLight", [_flareLight, _magColor]] call CBA_fnc_globalEvent;

      [{(getPosATL (_this select 0) select 2) < 1}, {
        if (alive (_this select 0)) then {deleteVehicle (_this select 0)};
        if (alive (_this select 1)) then {deleteVehicle (_this select 1)};
      }, [_flare,_flareLight], 40, {
        if (alive (_this select 0)) then {deleteVehicle (_this select 0)};
        if (alive (_this select 1)) then {deleteVehicle (_this select 1)};
      }] call CBA_fnc_waitUntilAndExecute;
    }, [_flare, _magColor], 2.6] call CBA_fnc_waitAndExecute;
  }, [_ammoType, _pos, _dir, _magColor], 0.95] call CBA_fnc_waitAndExecute;
}, [_ammoType, _pos, _dir, _magColor], 1] call CBA_fnc_waitAndExecute;
