//Applies textures, woo.

#include "settings.sqf"

if (billboards isEqualTo []) then {billboards = allMissionObjects "Land_Billboard_F"};

[{
	{
		if (billboards_textureArray isEqualTo []) then {billboards_textureArray = billboards_textureArray_base};

		private _randomTexture = selectRandom billboards_textureArray;

		_x setObjectTextureGlobal [0,_randomTexture];
		billboards_textureArray = billboards_textureArray - [_randomTexture];
	} forEach billboards;
}, [], 0] call CBA_fnc_waitAndExecute;
