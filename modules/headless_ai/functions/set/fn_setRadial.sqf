#include "script_component.hpp"


params["_value"];
private _leader = leader ((get3DENSelected 'Group') select 0);
set3DENAttributes [[[_leader],'size2',[_value,_value]]];
true
