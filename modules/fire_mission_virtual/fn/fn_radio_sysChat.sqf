
_pre = param [0,1];
_msg = param [1,""];

if ([_pre] call tin_fnc_radio_checkFreq) then {systemChat _msg};