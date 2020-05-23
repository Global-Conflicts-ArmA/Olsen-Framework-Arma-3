#define COMPONENT PZAI
#define DEBUG_MODE_FULL
#include "..\..\core\script_macros.hpp"

//Script control
#define AI_EXEC_CHECK(ARG) \
private _argUpper = toUpper(#ARG);\
if (is3DEN) exitWith {};\
if ((_argUpper isEqualTo "SERVER") && {((!isServer) && {isMultiplayer})}) exitWith {};\
if ((_argUpper isEqualTo "CLIENT") && {(!hasinterface)}) exitWith {};\
if ((_argUpper isEqualTo "HC") && {((hasinterface || isServer) && {isMultiplayer})}) exitWith {};\
if ((_argUpper isEqualTo "CLIENTHC") && {((isDedicated) && {isMultiplayer})}) exitWith {};\
if ((_argUpper isEqualTo "SERVERHC") && {((hasinterface) && {isMultiplayer})}) exitWith {};

// Locality Check and Redirect
#define AI_LOC_CHECK(ARG1) \
private _argUpper = toUpper(#ARG1);\
if (isNil QGVAR(HC_ID)) then {_nul = [] call FUNC(checkifHC);};\
if ((_argUpper isEqualTo "HCONLY") && {(!isMultiplayer)}) exitWith {\
    LOG_1("script:%1 couldn't run, set to HC ONLY and in Singleplayer!",_fnc_scriptName);\
};\
if ((_argUpper isEqualTo "HCONLY") && {(hasInterface || isDedicated)}) exitwith {\
    if !(isNil QGVAR(HC_ID)) then {\
        if !(GVAR(HC_ID) isEqualTo clientowner) then {\
            _this remoteExec [_fnc_scriptName,GVAR(HC_ID)];\
        } else {\
            LOG_1("script:%1 couldn't run, set to HC ONLY and no HC detected!",_fnc_scriptName);\
        };\
    };\
};\
if ((_argUpper isEqualTo "AUTO") && {(!isNil QGVAR(HC_ID))}) then {\
    if (isMultiplayer) exitwith {\
        if !(GVAR(HC_ID) isEqualTo clientowner) then {\
            _this remoteExec [_fnc_scriptName,GVAR(HC_ID)];\
        };\
    };\
}
