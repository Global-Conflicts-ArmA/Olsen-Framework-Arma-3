#include "script_component.hpp"

#include "..\..\Dia\Dia_Global.sqf"

[-1, {_this call FUNC(FIREMIS_StopArtillery);},_this] call CBA_fnc_globalExecute;
