#include "script_component.hpp"

if (isServer) then {
    [_this , false] call FUNC(Dia_SetArtyReadyStatus);
    terminate (_this getVariable [VAR_SART_FMHANDLE,scriptNULL]);
};
