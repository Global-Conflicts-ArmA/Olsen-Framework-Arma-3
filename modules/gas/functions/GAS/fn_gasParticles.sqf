#include "script_component.hpp"

//Example, to be run only once, SERVER ONLY: ["GAS_PARTICLES", position player] call CBA_fnc_serverEvent;

if (!isDedicated && hasInterface) then {
	drop [["\ca\Data\ParticleEffects\Universal\Universal", 16, 8, 0, 0], "", "Billboard", 1, 18.5, _this, [0, 0, 0.5], 0, 10, 7.9, 0.275, [8.5, 10.5], [[1, 1, 0.25, 0], [1, 1, 0.25, 0.6], [1, 1, 0.25, 0.25], [1, 1, 0.25, 0.15], [1, 1, 0.25, 0.05], [1, 1, 0.25, 0]], [1], 1, 0, "", "", ""];
};
