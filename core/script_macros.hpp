#ifndef PREFIX
    #define PREFIX FW
#endif
#ifndef COMPONENT
    #define COMPONENT FW
#endif
#ifndef DEBUG_MODE_FULL
    #define DEBUG_MODE_FULL
#endif
#define VERSIONSTR "0.1.1"
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
