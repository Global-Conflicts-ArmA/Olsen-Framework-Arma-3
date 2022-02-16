#include "script_component.hpp"

private _pre = param [0, 1];
private _msg = param [1, ""];

if ([_pre] call FUNC(radio_checkFreq)) then {systemChat _msg};
