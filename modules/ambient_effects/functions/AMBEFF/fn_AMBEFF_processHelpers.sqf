#include "script_component.hpp"

private _hideArray = [];

(allMissionObjects "Sign_Arrow_Large_Pink_F") apply {	//Large Pink Arrows - Burning Vehicle
  _delay = random 1;
  [[_x, [
    ["FireSparks", [0 ,-2, 0]],
    ["AmmoSmokeParticles2", [0, -2, -1]],
    ["FireSparks", [0, 1, 0]],
    ["AmmoSmokeParticles2", [0, 2, -1]],
    ["AmmoSmokeParticles2", [0, 0, -1]]
  ]],"FW_fnc_AMBEFF_particleEffect", true, true] spawn BIS_fnc_MP;
  [{[_this, "FW_fnc_AMBEFF_audio_carBurning2", true, true] spawn BIS_fnc_MP}, _x, _delay] call CBA_fnc_waitAndExecute;

  _hideArray pushBack _x;
};

(allMissionObjects "Sign_Arrow_Pink_F") apply {	//Pink Arrows - Small Fire
  _delay = random 1;
  [[_x, [
    ["FireSparks", [0, 0, 0]],
    ["FuelFire1", [0, 0, 0]],
    ["AmmoSmokeParticles2", [0, 0, -1]]
  ]],"FW_fnc_AMBEFF_particleEffect", true, true] spawn BIS_fnc_MP;
  [{[_this, "FW_fnc_AMBEFF_audio_carBurning1", true, true] spawn BIS_fnc_MP}, _x, _delay] call CBA_fnc_waitAndExecute;
  _hideArray pushBack _x;
};

[_hideArray, "FW_fnc_AMBEFF_hideHelperObjects", true, true] spawn BIS_fnc_MP;

//Return Complete
true
