#include "script_component.hpp"

if (isServer) then
{
    [_this , false] call FUNC(FIREMIS_Dia_SetArtyReadyStatus);
    [_this , false] call FUNC(FIREMIS_Dia_SetArtyReadyStatus);
    terminate (_this getVariable [VAR_SART_FMHANDLE,scriptNULL]);

};
