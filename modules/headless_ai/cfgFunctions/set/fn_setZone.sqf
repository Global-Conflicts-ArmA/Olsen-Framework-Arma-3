#include "..\..\script_macros.hpp"


params[["_zoneModules",[],[[]]],["_status",0,[0]]];
if (count _zoneModules > 0) then {
    {
        private _zoneModule = _x;
        private _set = if (_status isEqualTo 2) then {([1,0] select (([_zoneModule,GVAR(Zones)] call FUNC(getDetails)) select 3))} else {_status};
        ([_zoneModule,GVAR(Zones)] call FUNC(getDetails)) set [3, _set];
    } foreach _zoneModules;
};
true
