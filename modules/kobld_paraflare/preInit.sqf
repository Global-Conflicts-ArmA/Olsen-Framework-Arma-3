["Paraflares", "Paraflares, old style.", "TinfoilHate"] call FNC_RegisterModule;

kobld_paraflare_flareAngle = 90;

kobld_paraflare_fnc_flareLight = {
	params ["_flareLight","_magColor"];

	_flareLight setLightBrightness 15;
	_flareLight setLightUseFlare false;
	_flareLight setLightColor _magColor;
};
["kobld_paraflare_evt_flareLight", kobld_paraflare_fnc_flareLight] call CBA_fnc_addEventHandler;

kobld_paraflare_fnc_flareFire = {
	private ["_pos", "_dir", "_flare"];

	_pos = player modelToWorld [0, 1, 0];
	_pos = [_pos select 0, _pos select 1, 1.5];
	_dir = getDir player;
	_magType = _this select 0;
	_magColor = [0,0,0];

	switch (_magType) do {
		case "FlareWhite_F":{_magColor = [1,1,1];};
		case "FlareGreen_F":{_magColor = [0.25,0.5,0.25];};
		case "FlareYellow_F":{_magColor = [0.5,0.5,0.25];};
		case "FlareRed_F":{_magColor = [0.5,0.25,0.25];};
	};

	_ammoType = getText (configFile >> "CfgMagazines" >> _magType >> "ammo");
	player removeMagazine _magType;

	[player,"Gear"] remoteExec ["playActionNow"];

	[{
		params ["_ammoType","_pos","_dir","_magColor"];
		
		[player,"tin_flareFire"] remoteExec ["say3D"];

		[{
			params ["_ammoType","_pos","_dir","_magColor"];

			_flare = _ammoType createVehicle _pos;
			_flare setVelocity [sin (_dir) * kobld_paraflare_flareAngle, cos (_dir) * kobld_paraflare_flareAngle, 80];

			[_flare,"tin_flareShot"] remoteExec ["say3D"];

			[{
				params ["_flare","_magColor"];
				
				_flareLight = "#lightpoint" createVehicle position _flare;
				_flareLight lightAttachObject [_flare, [0,0,0]];

				["kobld_paraflare_evt_flareLight", [_flareLight,_magColor]] call CBA_fnc_globalEvent;

				[{(getPosATL (_this # 0) # 2) < 1}, {
					if (alive (_this # 0)) then {deleteVehicle (_this # 0)};
					if (alive (_this # 1)) then {deleteVehicle (_this # 1)};
				}, [_flare,_flareLight], 40, {
					if (alive (_this # 0)) then {deleteVehicle (_this # 0)};
					if (alive (_this # 1)) then {deleteVehicle (_this # 1)};
				}] call CBA_fnc_waitUntilAndExecute;
			}, [_flare,_magColor], 2.6] call CBA_fnc_waitAndExecute;
		}, [_ammoType,_pos,_dir,_magColor], 0.95] call CBA_fnc_waitAndExecute;
	}, [_ammoType,_pos,_dir,_magColor], 1] call CBA_fnc_waitAndExecute;
};