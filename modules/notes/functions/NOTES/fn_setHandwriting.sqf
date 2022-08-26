#include "script_component.hpp"

params ["_unit"];

if (!isServer && !local _unit) exitWith {};

private _types = [
    ["small","PuristaLight"],
    ["fine","PuristaMedium"],
    ["sloppy","PuristaSemiBold"],
    ["messy","PuristaBold"],
    ["angular","LucidaConsoleB"],
    ["elegant","EtelkaMonospacePro"],
    ["meticulous","EtelkaMonospaceProBold"],
    ["cramped","EtelkaNarrowMediumPro"],
    ["bold","TahomaB"]
];

private _modifiers = [
    "somewhat",
    "quite",
    "remarkably"
];


private _handwriting = [selectRandom _modifiers, selectRandom _types];
_unit setVariable [QGVAR(handwriting), _handwriting, true];
