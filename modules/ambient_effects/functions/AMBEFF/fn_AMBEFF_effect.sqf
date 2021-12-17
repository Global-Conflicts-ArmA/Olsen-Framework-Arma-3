#include "script_component.hpp"

params [
    ["_object", objNull, [objNull]],
    ["_big", false, [false]]
];

private _effects = if (_big) then {
    ["FireSparks", [0 ,-2, 0]],
    ["AmmoSmokeParticles2", [0, -2, -1]],
    ["FireSparks", [0, 1, 0]],
    ["AmmoSmokeParticles2", [0, 2, -1]],
    ["AmmoSmokeParticles2", [0, 0, -1]]
} else {
    ["FireSparks", [0, 0, 0]],
    ["FuelFire1", [0, 0, 0]],
    ["AmmoSmokeParticles2", [0, 0, -1]]
};

[_object, _effects] call FUNC(particleEffect);
