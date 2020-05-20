/*
    Header: script_macros_mission.hpp

    Description:
        Modifies script_common_macros.hpp for compatiblity with missions.
        Some addon specific functionality might be lost.

    Authors:
        Muzzleflash

    Changes from script_macros_mission.hpp:
        Follows Standard:
            Object variables: PREFIX_COMPONENT
            Main-object variables: PREFIX_main
            Paths: PREFIX\COMPONENT\SCRIPTNAME.sqf
                Or if CUSTOM_FOLDER is defined:
                CUSTOM_FOLDER\SCRIPTNAME.sqf
            eg. six\sys_menu\fDate.sqf

    Usage:
        Define PREFIX and COMPONENT, then include this file:
            #include "\x\cba\addons\main\script_macros_mission.hpp"

*/

/*
    CUSTOM_FOLDER

    Custom folder to search for files in. Will not change variable names.
    Default is PREFIX\COMPONENT

    Example:
        (begin example)
            #define CUSTOM_FOLDER MyPackage\ScriptA
        (end)

        (begin example)
            #define CUSTOM_FOLDER COMPONENT\functions
        (end)


*/

#include "script_macros_common.hpp"

#define QUOTEIN(var1) QUOTE(QUOTE(var1))
#define QN(var1) QUOTE(QUOTE(var1))
#define QUOTE3(var1) QUOTE(QUOTE(QUOTE(var1)))

#define FUNC(var1) TRIPLES(COMPONENT,fnc,var1)
#define EFUNC(var1,var2) TRIPLES(var1,fnc,var2)

#define GETVARM_SYS(var1,var2) getVariable [ARR_2(QUOTE(DOUBLES(PREFIX,var1)),var2)]
#define SETVARM_SYS(var1,var2) setVariable [ARR_2(QUOTE(DOUBLES(PREFIX,var1)),var2)]
#define SETPVARM_SYS(var1,var2) setVariable [ARR_3(QUOTE(DOUBLES(PREFIX,var1)),var2,true)]

#define GETVAR_SYS(var1,var2) getVariable [ARR_2(QUOTE(DOUBLES(COMPONENT,var1)),var2)]
#define EGETVAR_SYS(var1,var2,var3) getVariable [ARR_2(QUOTE(DOUBLES(var1,var2)),var3)]

#define SETVAR_SYS(var1,var2) setVariable [ARR_2(QUOTE(DOUBLES(COMPONENT,var1)),var2)]
#define ESETVAR_SYS(var1,var2,var3) setVariable [ARR_2(QUOTE(DOUBLES(var1,var2)),var3)]

#define SETPVAR_SYS(var1,var2) setVariable [ARR_3(QUOTE(DOUBLES(COMPONENT,var1)),var2,true)]
#define ESETPVAR_SYS(var1,var2,var3) setVariable [ARR_3(QUOTE(DOUBLES(var1,var2)),var3,true)]

#define MGETVAR(var1,var2,var3) var1 GETVARM_SYS(var2,var3)
#define MGETPLVAR(var1,var2) player GETVARM_SYS(var1,var2)
#define MGETMVAR(var1,var2) missionNamespace GETVARM_SYS(var1,var2)

#define GETVAR(var1,var2,var3) var1 GETVAR_SYS(var2,var3)
#define EGETVAR(var1,var2,var3,var4) var1 EGETVAR_SYS(var2,var3,var4)

#define GETPLVAR(var1,var2) player GETVAR_SYS(var1,var2)
#define EGETPLVAR(var1,var2,var3) player EGETVAR_SYS(var1,var2,var3)

#define GETMVAR(var1,var2) missionNamespace GETVAR_SYS(var1,var2)
#define EGETMVAR(var1,var2,var3) missionNamespace EGETVAR_SYS(var1,var2,var3)

#define MSETVAR(var1,var2,var3) var1 SETVARM_SYS(var2,var3)
#define MSETMVAR(var1,var2) missionNamespace SETVARM_SYS(var1,var2)
#define MSETMPVAR(var1,var2) missionNamespace SETPVARM_SYS(var1,var2)
#define MSETPVAR(var1,var2,var3) var1 SETPVARM_SYS(var2,var3)
#define MSETPLPVAR(var1,var2) player SETPVARM_SYS(var1,var2)

#define SETVAR(var1,var2,var3) var1 SETVAR_SYS(var2,var3)
#define ESETVAR(var1,var2,var3,var4) var1 ESETVAR_SYS(var2,var3,var4)

#define SETPVAR(var1,var2,var3) var1 SETPVAR_SYS(var2,var3)
#define ESETPVAR(var1,var2,var3,var4) var1 ESETPVAR_SYS(var2,var3,var4)

#define SETMVAR(var1,var2) missionNamespace SETVAR_SYS(var1,var2)
#define ESETMVAR(var1,var2,var3) missionNamespace ESETVAR_SYS(var1,var2,var3)
#define FWSETMVAR(var1,var2,var3) missionNamespace ESETVAR_SYS(var1,var2,var3)

#define SETMPVAR(var1,var2) missionNamespace SETPVAR_SYS(var1,var2)
#define ESETMPVAR(var1,var2,var3) missionNamespace ESETPVAR_SYS(var1,var2,var3)

#define SETPLVAR(var1,var2) player SETVAR_SYS(var1,var2)
#define ESETPLVAR(var1,var2,var3) player ESETVAR_SYS(var1,var2,var3)
#define SETPLPVAR(var1,var2) player SETPVAR_SYS(var1,var2)
#define ESETPLPVAR(var1,var2,var3) player ESETPVAR_SYS(var1,var2,var3)

#define QQGVAR(var1) QUOTE(QGVAR(var1))
#define QQEGVAR(var1,var2) QUOTE(QEGVAR(var1,var2))

#define GVAR(var1) DOUBLES(COMPONENT,var1)
#define EGVAR(var1,var2) DOUBLES(var1,var2)
#define QGVAR(var1) QUOTE(DOUBLES(COMPONENT,var1))
#define QEGVAR(var1,var2) QUOTE(DOUBLES(var1,var2))

#define QGETVAR_SYS(var1,var2) getVariable [ARR_2(QN(DOUBLES(COMPONENT,var1)),var2)]

#define QGETVAR(var1,var2,var3) var1 QGETVAR_SYS(var2,var3)
#define QGETMVAR(var1,var2) missionNamespace QGETVAR_SYS(var1,var2)

#define UGROUP (group _unit)

#ifdef CUSTOM_FOLDER
    #define PATHTO_SYS(var1,var2,var3) ##CUSTOM_FOLDER\##var3.sqf
    #define PATHTOF_SYS(var1,var2,var3) ##CUSTOM_FOLDER\##var3
    #define PATHTOF2_SYS(var1,var2,var3) ##CUSTOM_FOLDER\##var3
#else
    #define PATHTO_SYS(var1,var2,var3) ##var1\##var2\##var3.sqf
    #define PATHTOF_SYS(var1,var2,var3) ##var1\##var2\##var3
    #define PATHTOF2_SYS(var1,var2,var3) ##var1\##var2\##var3
#endif

/************************** REMOVAL OF MACROS ***********************/

#undef MAINPREFIX
#undef SUBPREFIX
#undef VERSION_AR
#undef VERSION_CONFIG

#undef VERSIONING_SYS
#undef VERSIONING

#undef PRELOAD_ADDONS

#undef BWC_CONFIG

#undef XEH_DISABLED
#undef XEH_PRE_INIT
#undef XEH_PRE_CINIT
#undef XEH_PRE_SINIT
#undef XEH_POST_INIT
#undef XEH_POST_CINIT
#undef XEH_POST_SINIT

#undef PATHTO_FNC
#define PATHTO_FNC(func) class func {\
    file = QUOTE(DOUBLES(fnc,func).sqf);\
    RECOMPILE;\
}
