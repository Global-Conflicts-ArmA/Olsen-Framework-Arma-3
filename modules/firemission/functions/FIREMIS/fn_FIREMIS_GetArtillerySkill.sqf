#include "script_component.hpp"

#include "..\..\Dia\Dia_Global.sqf"

_unit = _this select 0;
skills = [];
skills pushBack (_unit getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]);
skills pushBack (_unit getVariable [VAR_SART_ARTACCURACY,MEANPlOTTEDACCURACY]);
skills pushBack (_unit getVariable [VAR_SART_ARTSPOTACCURACY,MEANSPOTTINGACCURACY]);
skills pushBack (_unit getVariable [VAR_SART_ARTAIMSPEED,MEANAIMTIME]);
skills pushBack (_unit getVariable [VAR_SART_ARTCALCSPEED,MEANCALCULATIONTIME]);
skills pushBack (_unit getVariable [VAR_SART_ARTCUSTOMNAME,""]);
skills
