#include "script_component.hpp"

params ["_display"];

#include "..\..\customization\settings.sqf"

if !(GETMVAR(loadingScreen,false)) exitwith {};

private _image = getMissionConfigValue ["loadScreen", ""];
if (_image isEqualTo "") then {
    _image = getMissionConfigValue ["overViewPicture", ""];
};
private _author = getMissionConfigValue ["author", ""];
private _name = briefingName;
if (_name isEqualTo "") then {
    _name = getMissionConfigValue ["onLoadName", ""];
};
private _description = getMissionConfigValue ["OnLoadMission", ""];
if (_description isEqualTo "") then {
    _description = getMissionConfigValue ["overviewText", ""];
};

private _background = _display ctrlCreate ["RscPicture", -1];
_background ctrlSetPosition [
    safeZoneXAbs,
    0.075 * safezoneH + safezoneY,
    safeZoneWAbs,
    0.925 * safezoneH
];
_background ctrlCommit 0;
_background ctrlSetText "#(rgb,8,8,3)color(0,0,0,1)";

private _backgroundTop = _display ctrlCreate ["RscPicture", -1];
_backgroundTop ctrlSetPosition [
    safeZoneXAbs,
    0 * safezoneH + safezoneY,
    safeZoneWAbs,
    0.065 * safezoneH
];
_backgroundTop ctrlCommit 0;
_backgroundTop ctrlSetText "#(rgb,8,8,3)color(0,0,0,1)";

if !(_image isEqualTo "") then {
    private _ctrl = _display ctrlCreate ["RscPicture", -1];
    _ctrl ctrlSetPosition [
        safezoneX,
        0.075 * safezoneH + safezoneY,
        safezoneW,
        0.925 * safezoneH
    ];
    _ctrl ctrlCommit 0;
    _ctrl ctrlSetText _image;
};

if !(_name isEqualTo "") then {
    private _ctrl = _display ctrlCreate ["RscStructuredText", -1];
    _ctrl ctrlSetPosition [safezoneX,0.01 * safezoneH + safezoneY,1 * safezoneW,0.05 * safezoneH];
    _ctrl ctrlCommit 0;
    _ctrl ctrlSetStructuredText (parseText format ["<t size='1.5' align='center' valign='top' shadow='2' font='PuristaSemibold'>%1</t>", _name]);
};

if !(_author isEqualTo "") then {
    private _ctrl = _display ctrlCreate ["RscStructuredText", -1];
    _ctrl ctrlSetPosition [0.8 * safezoneW + safezoneX,0.02 * safezoneH + safezoneY,0.2 * safezoneW,0.1 * safezoneH];
    _ctrl ctrlCommit 0;
    _ctrl ctrlSetStructuredText (parseText format ["<t size='1.2' align='center' valign='top' shadow='2' font='PuristaSemibold'>By: %1</t>", _author]);
};

if !(_description isEqualTo "") then {
private _descriptionBox = _display ctrlCreate ["RscPicture", -1];
_descriptionBox ctrlSetPosition [0.25 * safezoneW + safezoneX,0.75 * safezoneH + safezoneY,0.5 * safezoneW,0.2 * safezoneH];
_descriptionBox ctrlCommit 0;
_descriptionBox ctrlSetText "#(rgb,8,8,3)color(0,0,0,0.5)";

    private _ctrl = _display ctrlCreate ["RscStructuredText", -1];
    _ctrl ctrlSetPosition [0.25 * safezoneW + safezoneX,0.755 * safezoneH + safezoneY,0.5 * safezoneW,0.19 * safezoneH];
    _ctrl ctrlCommit 0;
    _ctrl ctrlSetText _description;
    _ctrl ctrlSetStructuredText (parseText format ["<t size='1.25' align='center' valign='top' shadow='2' font='PuristaSemibold'>%1</t>", _description]);
};
