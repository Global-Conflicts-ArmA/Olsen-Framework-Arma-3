FNC_SetLanguages = {
	params ["_unit", "_languages"];

	_unit setVariable ["ACRE_Languages", _languages, false];
};

FNC_SetRadio = {

	params [
		["_unit", objNull, [objNull]],
		["_radio", "", [""]],
		["_channel", 0, [0]],
		["_spatial", "CENTER", [""]]
	];

	private _channels = _unit getVariable ["ACRE_Channels", []];

	_channels pushBack [_radio, _channel, _spatial];

	_unit setVariable ["ACRE_Channels", _channels, false];

};

FNC_SetScramble = {
	params ["_unit", "_side"];

	_unit setVariable ["ACRE_CustomScramble", _side, false];
};
