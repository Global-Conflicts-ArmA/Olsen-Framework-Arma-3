//Applies textures, woo.

#include "settings.sqf"

if (isServer) then {
	if (kobld_billboards isEqualTo []) then {kobld_billboards = allMissionObjects "Land_Billboard_F"};

	[{
		{
			if (kobld_billboards_textureArray isEqualTo []) then {kobld_billboards_textureArray = kobld_billboards_textureArray_base};

			_randomTexture = selectRandom kobld_billboards_textureArray;

			_x setObjectTextureGlobal [0,_randomTexture];
			kobld_billboards_textureArray = kobld_billboards_textureArray - [_randomTexture];
		} forEach kobld_billboards;
	}, [], 0] call CBA_fnc_waitAndExecute;
};
