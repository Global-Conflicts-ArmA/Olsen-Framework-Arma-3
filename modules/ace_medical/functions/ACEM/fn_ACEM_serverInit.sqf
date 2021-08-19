#include "script_component.hpp"
#include "..\..\settings.sqf"

_medicalParam = ["MedicalType", 1] call BIS_fnc_getParamValue;
if (_medicalParam == 1) then {
	ACE_medical_enableRevive = 1;
} else {
	ACE_medical_enableRevive = 0;
};
