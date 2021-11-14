#include "script_component.hpp"

private _house = lineIntersectsSurfaces [getPosWorld player, getPosWorld player vectorAdd [0,0,50], player, objNull, true, 1, "GEOM", "NONE"];

if (_house isEqualTo []) then {_house = [[0,0,kobld_snow_machine,kobld_snow_machine]]};

kobld_snow_posType = "";

if (!(kobld_snow_posType isEqualTo "indoors") && {((_house select 0) select 3) isKindOf "house"}) then {
	kobld_snow_posType = "indoors";
} else {
	if (!(kobld_snow_posType isEqualTo "under_water") && {(getPosASL player select 2 < 0)} && {(getPosASL player select 2 > -3)}) then {
		kobld_snow_posType = "under_water";
	} else {
		if (!(kobld_snow_posType isEqualTo "deep_sea") && {getPosASL player select 2 < -3}) then {
			kobld_snow_posType = "deep_sea";
		} else {
			if (!(kobld_snow_posType isEqualTo "player_car") && {(player != vehicle player)} && {(getPosASL player select 2 > 0)}) then {
				kobld_snow_posType = "player_car";
			};
		};
	};
};

[kobld_snow_posType,_house] call FUNC(snowFX);
