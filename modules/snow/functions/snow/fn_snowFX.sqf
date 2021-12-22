#include "script_component.hpp"

params [["_fxType", "", [""]], "_house"];

switch (_fxType) do {
	case "indoors": {
		if (!(GVAR(fxType) isEqualTo "indoors")) then {
			GVAR(building) = ((_house select 0) select 3);
			GVAR(buildingType)= typeOf ((_house select 0) select 3);
			GVAR(buildingSize) = sizeOf GVAR(buildingType);
			if (GVAR(snowfall)) then {
				GVAR(particleSource) setParticleCircle [GVAR(buildingSize),[0,0,0]];
				GVAR(particleSource) setParticleRandom [0,[5,5,0],[0,0,0],0,0,[0,0,0,0],0,0.5];
				GVAR(particleSource) setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1],"","Billboard",1,0.2,[0,0,1],[0,0,0],3,2,1,0,[0.1],[[1,1,1,1]],[1],0,1,"","",GVAR(building),0,true];
				GVAR(particleSource) setDropInterval GVAR(snowTimer);
			};
			if (GVAR(snowFog)) then {
				deleteVehicle GVAR(particleSourceLocalFog);
				GVAR(particleSourceLocalFog) = "#particlesource" createVehicleLocal getPosATL player;
				GVAR(particleSourceLocalFog) setParticleCircle [GVAR(buildingSize),[3,3,0]];
				GVAR(particleSourceLocalFog) setParticleRandom [0,[0.25,0.25,0],[1,1,0],1,1,[0,0,0,0.1],0,0];
				GVAR(particleSourceLocalFog) setParticleParams [["\A3\data_f\cl_basic",1,0,1],"","Billboard",1,4,[0,0,0],[-1,-1,0],3,10.15,7.9,0.03,[5,10,20],[[0.5,0.5,0.5,0],[0.5,0.5,0.5,0.1],[1,1,1,0]],[1],1, 0,"","",player];
				GVAR(particleSourceLocalFog) setDropInterval 0.1;
			};
			GVAR(fxType) = "indoors";
		};
	};
	case "under_water": {
		if (!(GVAR(fxType) isEqualTo "under_water")) then {
			if (GVAR(snowFog)) then {
				deleteVehicle GVAR(particleSourceLocalFog);
			};
			GVAR(machine) setPosASL [getPosASL player select 0,getPosASL player select 1, 1];
			if (GVAR(snowfall)) then {
				GVAR(particleSource) setParticleCircle [0,[0,0,0]];
				GVAR(particleSource) setParticleRandom [0,[25,25,0],[0,0,0],0,0.05,[0,0,0,0.1],1,1];
				GVAR(particleSource) setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1],"","Billboard",1,4,[0,0,15],[0,0,0],3,2,1,0.7,[0.1],[[1,1,1,1]],[1],1,1,"","",GVAR(machine)];
				GVAR(particleSource) setDropInterval GVAR(snowTimer);
			};
			GVAR(fxType) = "under_water";
		};
	};
	case "deep_sea": {
		if (!(GVAR(fxType) isEqualTo "deep_sea")) then {
			if (GVAR(snowFog)) then {
				deleteVehicle GVAR(particleSourceLocalFog);
			};
			if (GVAR(snowfall)) then {
				GVAR(particleSource) setDropInterval -1;
			};
			GVAR(fxType) = "deep_sea";
		};
	};
	case "player_car": {
		if (!(GVAR(fxType) isEqualTo "player_car")) then {
			if (GVAR(snowfall)) then {
				GVAR(particleSource) setParticleCircle [0,[0,0,0]];
				GVAR(particleSource) setParticleRandom [0,[25,25,9],[0,0,0],0,0.05,[0,0,0,0.1],0,0];
				GVAR(particleSource) setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1],"","Billboard",1,7,[0,0,10],[0,0,0],3,1.7,1,1,[0.1],[[1,1,1,1]],[1],0.3,1,"","",player];
				GVAR(particleSource) setDropInterval GVAR(snowTimer);
			};
			if (GVAR(snowFog)) then {
				deleteVehicle GVAR(particleSourceLocalFog);
				GVAR(particleSourceLocalFog) = "#particlesource" createVehicleLocal getPosATL player;
				GVAR(particleSourceLocalFog) setParticleCircle [30,[3,3,0]];
				GVAR(particleSourceLocalFog) setParticleRandom [0,[0.25,0.25,0],[1,1,0],1,1,[0,0,0,0.1],0,0];
				GVAR(particleSourceLocalFog) setParticleParams [["\A3\data_f\cl_basic",1,0,1],"","Billboard",1,4,[0,0,0],[-1,-1,0],3,10.15,7.9,0.03,[5,10,20],[[0.5,0.5,0.5,0],[0.5,0.5,0.5,0.1],[1,1,1,0]],[1],1, 0,"","",player];
				GVAR(particleSourceLocalFog) setDropInterval 0.1;
			};
			GVAR(fxType) = "player_car";
		};
	};
	default {
		if (!(GVAR(fxType) isEqualTo "open")) then {
			if (GVAR(snowfall)) then {
				GVAR(particleSource) setParticleCircle [0,[0,0,0]];
				GVAR(particleSource) setParticleRandom [0,[25,25,9],[0,0,0],0,0.05,[0,0,0,0.1],0,0];
				GVAR(particleSource) setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1],"","Billboard",1,7,[0,0,10],[0,0,0],3,1.7,1,1,[0.1],[[1,1,1,1]],[1],0.3,1,"","",player];
				GVAR(particleSource) setDropInterval GVAR(snowTimer);
			};
			if (GVAR(snowFog)) then {
				deleteVehicle GVAR(particleSourceLocalFog);
				GVAR(particleSourceLocalFog) = "#particlesource" createVehicleLocal getPosATL player;
				GVAR(particleSourceLocalFog) setParticleCircle [10,[3,3,0]];
				GVAR(particleSourceLocalFog) setParticleRandom [2,[0.25,0.25,0],[1,1,0],1,1,[0,0,0,0.1],0,0];
				GVAR(particleSourceLocalFog) setParticleParams [["\A3\data_f\cl_basic",1,0,1],"","Billboard",1,8,[0,0,0],[-1,-1,0],3,10.15,7.9,0.03,[5,10,10],[[0.5,0.5,0.5,0],[0.5,0.5,0.5,0.1],[1,1,1,0]],[1],1, 0,"","",player];
				GVAR(particleSourceLocalFog) setDropInterval 0.1;
			};
			GVAR(fxType) = "open";
		};
	};
};
