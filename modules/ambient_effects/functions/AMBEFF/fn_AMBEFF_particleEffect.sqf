#include "script_component.hpp"

//Parameters
params[
  ["_object", objNull, [objNull]],
  ["_effects", [], [[]]]
];

//The effects container
private _container = [];

//Loop classes and start effects
_effects apply {
  //Parameters
  _x params [
    ["_class", "AmmoSmokeParticles2", [""]],
    ["_attachTo", [], [[]]]
  ];

  //Particle effect
  private _effect = "#particlesource" createVehicleLocal position _object;
  _effect setParticleClass _class;
  private _li = "#lightpoint" createVehicleLocal position _object;
  _li setLightAmbient[0.8, 0.6, 0.2];
  _li setLightColor[1, 0.5, 0.4];
  _li setLightBrightness 0.1;

  //Should effect be attached to object?
  if (count _attachTo > 0) then {
    _effect attachto [_object, _attachTo];
    _li lightAttachObject [_object, _attachTo];
  };

  //Store in container
  _container pushBack _effect;

};

//Return
_container
