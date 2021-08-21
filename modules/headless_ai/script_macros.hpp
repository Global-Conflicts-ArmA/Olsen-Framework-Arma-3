#define PREFIX HC
#define COMPONENT PZAI
#define DEBUG_MODE_FULL
#define VERSIONSTR "0.2.3"
#include "script_macros_common.hpp"
#include "script_macros_mission.hpp"

#define QUOTEIN(var1) QUOTE(QUOTE(var1))
#define QN(var1) QUOTE(QUOTE(var1))
#define QUOTE3(var1) QUOTE(QUOTE(QUOTE(var1)))

#define FUNC(var1) TRIPLES(COMPONENT,fnc,var1)

#define GETVAR_SYS(var1,var2) getVariable [ARR_2(QUOTE(DOUBLES(COMPONENT,var1)),var2)]
#define SETVAR_SYS(var1,var2) setVariable [ARR_2(QUOTE(DOUBLES(COMPONENT,var1)),var2)]
#define SETPVAR_SYS(var1,var2) setVariable [ARR_3(QUOTE(DOUBLES(COMPONENT,var1)),var2,true)]

#define QGETVAR_SYS(var1,var2) getVariable [ARR_2(QN(DOUBLES(COMPONENT,var1)),var2)]

#define GETVAR_SYS(var1,var2) getVariable [ARR_2(QUOTE(DOUBLES(COMPONENT,var1)),var2)]
#define SETVAR_SYS(var1,var2) setVariable [ARR_2(QUOTE(DOUBLES(COMPONENT,var1)),var2)]
#define SETPVAR_SYS(var1,var2) setVariable [ARR_3(QUOTE(DOUBLES(COMPONENT,var1)),var2,true)]

#define GETVAR(var1,var2,var3) var1 GETVAR_SYS(var2,var3)
#define GETMVAR(var1,var2) missionNamespace GETVAR_SYS(var1,var2)
#define GETPLVAR(var1,var2) player GETVAR_SYS(var1,var2)

#define QGETVAR(var1,var2,var3) var1 QGETVAR_SYS(var2,var3)
#define QGETMVAR(var1,var2) missionNamespace QGETVAR_SYS(var1,var2)

#define SETVAR(var1,var2,var3) var1 SETVAR_SYS(var2,var3)
#define SETPVAR(var1,var2,var3) var1 SETPVAR_SYS(var2,var3)
#define SETMVAR(var1,var2) missionNamespace SETVAR_SYS(var1,var2)
#define SETMPVAR(var1,var2) missionNamespace SETPVAR_SYS(var1,var2)
#define SETPLVAR(var1,var2) player SETVAR_SYS(var1,var2)
#define SETPLPVAR(var1,var2) player SETPVAR_SYS(var1,var2)

#define GVAR(varName) DOUBLES(COMPONENT,varName)
#define EGVAR(compName,varName) DOUBLES(compName,varName)
#define QGVAR(varName) QUOTE(DOUBLES(COMPONENT,varName))

#define UGROUP (group _unit)

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

#define CFGFUNCFOLDER(ModuleName,FolderName) \
__EXEC(_TEMPMODULE = #ModuleName) \
__EXEC(_TEMPFOLDER = #FolderName) \
class DOUBLES(ModuleName,FolderName) { \
    file = QUOTE(modules\headless_ai\cfgFunctions\FolderName)

#define CFGFUNC(ModuleName,FunctionName) \
__EXEC(_TEMPFNC = #FunctionName) \
class FunctionName { \
	scope = 1; \
	file = __EVAL("modules\headless_ai\cfgFunctions\" + _TEMPFOLDER + "\fn_" + #FunctionName + ".sqf"); \
}

#define CFGFUNCFOLDEREND \
}
