#include "script_component.hpp"
params ["_onOff"];

missionNamespace setVariable [QGVAR(collisionDebugMode),_onOff];
