#define PREFIX FW
#ifndef COMPONENT
    #define COMPONENT FW
#endif
#define DEBUG_MODE_NORMAL
//#define DEBUG_MODE_FULL
#define VERSIONSTR "1.1.5"
#define VERSION 1.1
#define VERSION_AR 1,1,5
#include "script_macros_mission.hpp"

#define RNG(var1) var1 > random 1
#define INVEHICLE(var1) (vehicle var1) isNotEqualTo var1
#define RNDRANGE(var1,var2) var1 + (floor(random (1 + var2 - var1)))
#define GETTEAMVAR(var1,var2,var3) private var1 = [var2, var3] call EFUNC(FW,GetTeamVariable)

#define ERROR(MESSAGE) MESSAGE call EFUNC(FW,DebugMessage); \
LOG_SYS('ERROR',MESSAGE)

#define POS_X(N) ((N) * safezoneW + safezoneX)
#define POS_Y(N) ((N) * safezoneH + safezoneY)
#define POS_W(N) ((N) * safezoneW)
#define POS_H(N) ((N) * safezoneH)
