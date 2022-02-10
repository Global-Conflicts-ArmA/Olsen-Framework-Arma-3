#include "script_component.hpp"

#include "settings.sqf"

["tin_evt_callPolarFiremission", FUNC(dia_server_polarFiremissionFire)] call CBA_fnc_addEventHandler;
["tin_evt_callPolarFiremissionRepeat", FUNC(dia_server_polarFiremissionRepeat)] call CBA_fnc_addEventHandler;
