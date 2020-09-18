#include "..\..\script_macros.hpp"


/* HC_fnc_checkHC
Checks whether client is headless client or not

SETS
- HC_var_isHC (bool) to true where client is HC
- HC_var_HCs  (array) contains all present HCs

RETURNS
true/false for HC/not-HC
*/

LOG("Running CheckIfHC");

private _hc = false;
GVAR(HC_isHC) = false;
GVAR(HC_ID) = false;

//listen server and SP
if ((!isMultiplayer) || ((isMultiplayer) && {isServer} && {hasinterface})) then {
    _hc = true;
    GVAR(HC_isHC) = true;
    SETMPVAR(HC_ID,clientowner);
};

//headless client
if (!hasInterface && {!isDedicated}) then {
    _hc = true;
    GVAR(HC_isHC) = true;
    SETMPVAR(HC_ID,clientowner);
};

//server or client
if (isServer) then {
    LOG("clientID: SERVER");
} else {
    LOG_1("clientID: %1",clientowner);
};
if !(isNil QGVAR(HC_ID)) then {
    LOG_1("HC_ID: %1",GVAR(HC_ID));
};

LOG_2("Running CheckIfHC: %1 for client %2",_hc,clientowner);
_hc;

