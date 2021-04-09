#include "script_component.hpp"

private ["_unit", "_isRescued"];

_unit = _this;

_isRescued = _unit getVariable ["HOST_Rescued", false];

_isRescued;
