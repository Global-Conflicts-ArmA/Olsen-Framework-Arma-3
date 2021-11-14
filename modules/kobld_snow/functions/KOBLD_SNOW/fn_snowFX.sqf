#include "script_component.hpp"

params ["_fxType","_house"];

switch (_fxType) do {
	case "indoors": {
		if (!(kobld_snow_fxType isEqualTo "indoors")) then {
			kobld_snow_building = ((_house select 0) select 3);
			kobld_snow_buildingType= typeOf ((_house select 0) select 3);
			kobld_snow_buildingSize = sizeOf kobld_snow_buildingType;

			kobld_snow_particleSource setParticleCircle [kobld_snow_buildingSize,[0,0,0]];
			kobld_snow_particleSource setParticleRandom [0,[5,5,0],[0,0,0],0,0,[0,0,0,0],0,0.5];
			kobld_snow_particleSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1],"","Billboard",1,0.2,[0,0,1],[0,0,0],3,2,1,0,[0.1],[[1,1,1,1]],[1],0,1,"","modules\kobld_snow\functions\KOBLD_SNOW\fn_snow_drop.sqf",kobld_snow_building,0,true];
			kobld_snow_particleSource setDropInterval GVAR(snowTimer);

			kobld_snow_fxType = "indoors";
		};
	};

	case "under_water": {
		if (!(kobld_snow_fxType isEqualTo "under_water")) then {
			kobld_snow_machine setPosASL [getPosASL player select 0,getPosASL player select 1, 1];

			kobld_snow_particleSource setParticleCircle [0,[0,0,0]];
			kobld_snow_particleSource setParticleRandom [0,[25,25,0],[0,0,0],0,0.05,[0,0,0,0.1],1,1];
			kobld_snow_particleSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1],"","Billboard",1,4,[0,0,15],[0,0,0],3,2,1,0.7,[0.1],[[1,1,1,1]],[1],1,1,"","",kobld_snow_machine];
			kobld_snow_particleSource setDropInterval GVAR(snowTimer);

			kobld_snow_fxType = "under_water";
		};
	};

	case "deep_sea": {
		if (!(kobld_snow_fxType isEqualTo "deep_sea")) then {
			kobld_snow_particleSource setDropInterval -1;

			kobld_snow_fxType = "deep_sea";
		};
	};

	case "player_car": {
		if (!(kobld_snow_fxType isEqualTo "player_car")) then {
			kobld_snow_particleSource setParticleCircle [0,[0,0,0]];
			kobld_snow_particleSource setParticleRandom [0,[25,25,9],[0,0,0],0,0.05,[0,0,0,0.1],0,0];
			kobld_snow_particleSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1],"","Billboard",1,7,[0,0,10],[0,0,0],3,1.7,1,1,[0.1],[[1,1,1,1]],[1],0.3,1,"","",player];
			kobld_snow_particleSource setDropInterval GVAR(snowTimer);

			kobld_snow_fxType = "player_car";
		};
	};

	default {
		if (!(kobld_snow_fxType isEqualTo "open")) then {
			kobld_snow_particleSource setParticleCircle [0,[0,0,0]];
			kobld_snow_particleSource setParticleRandom [0,[25,25,9],[0,0,0],0,0.05,[0,0,0,0.1],0,0];
			kobld_snow_particleSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1],"","Billboard",1,7,[0,0,10],[0,0,0],3,1.7,1,1,[0.1],[[1,1,1,1]],[1],0.3,1,"","",player];
			kobld_snow_particleSource setDropInterval GVAR(snowTimer);

			kobld_snow_fxType = "open";
		};
	};
};
