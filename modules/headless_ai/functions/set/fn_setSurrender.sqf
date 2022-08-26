#include "script_component.hpp"


params [["_grp",grpNull,[grpNull]]];
if (isNull _grp) exitWith {
    LOG_1("SURRENDER - GROUP NULL | %1",_grp);
};
_grp setVariable[QGVAR(GroupCount), (count (units _grp))];
_grp setVariable[QGVAR(surrenderCount), ((count (units _grp)) * 0.5)];
{
    _x addMPEventHandler ["mpkilled", {
        if ( count (units (group (_this select 0))) < ((group (_this select 0)) getVariable[QGVAR(surrenderCount),999]) || !alive (leader (group (_this select 0))) ) then {
            {
                _x action ['surrender',_x];
            } forEach (units (group (_this select 0)));
        };
        (_this select 0) removeMPEventHandler ["mpkilled",_thisEventHandler];
    }];
} forEach units _grp;
true
