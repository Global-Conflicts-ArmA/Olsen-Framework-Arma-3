#include "script_component.hpp"
#include "..\..\dialog\ui_toolkit.hpp"
#include "..\..\dialog\hint\defines.hpp"

params ["_open", ["_surfaceNormal",true]];
if (!hasInterface) exitWith {};

if (_open) then {
    titleRsc [QGVAR(hint), "PLAIN", 1, true];
};

disableSerialization;
private _hint = GETVAR(uiNamespace,hint,displayNull);

if (isNull _hint) exitWith {};

private _l1BG  = _hint displayCtrl HINT_BG_LINE1;
private _l1Txt = _hint displayCtrl HINT_TXT_LINE1;
private _l1Pic = _hint displayCtrl HINT_PIC_LINE1;
private _l2BG  = _hint displayCtrl HINT_BG_LINE2;
private _l2Txt = _hint displayCtrl HINT_TXT_LINE2;
private _l2Pic = _hint displayCtrl HINT_PIC_LINE2;
private _l3BG  = _hint displayCtrl HINT_BG_LINE3;
private _l3Txt = _hint displayCtrl HINT_TXT_LINE3;
private _l3Pic = _hint displayCtrl HINT_PIC_LINE3;
private _l4BG  = _hint displayCtrl HINT_BG_LINE4;
private _l4Txt = _hint displayCtrl HINT_TXT_LINE4;
private _l4Pic = _hint displayCtrl HINT_PIC_LINE4;
private _l5BG  = _hint displayCtrl HINT_BG_LINE5;
private _l5Txt = _hint displayCtrl HINT_TXT_LINE5;
private _l5Pic = _hint displayCtrl HINT_PIC_LINE5;

private _xScale = X_SCALE;

if (_open) then {
    _l1Txt ctrlSetText "ROTATE";
    _l1Pic ctrlSetText ("modules\grad-fortifications\data\shiftkey.paa");
    _l2Txt ctrlSetText "LOWER/RAISE";
    _l2Pic ctrlSetText ("modules\grad-fortifications\data\ctrlkey.paa");
    _l3Txt ctrlSetText "SPEED UP";
    _l3Pic ctrlSetText ("modules\grad-fortifications\data\altkey.paa");
    _l4Pic ctrlSetText ("modules\grad-fortifications\data\tabkey.paa");
    {
        private _lineNumber = _forEachIndex;
        {
            private _curPos = ctrlPosition _x;
            _x ctrlSetPosition [(_curPos select 0) - (0.28 * _xScale), HINT_Y +_lineNumber*(SPACING_Y + HINT_H)];
            _x ctrlCommit 0.5;
            false
        } count _x;
    } forEach [[_l1BG,_l1Txt,_l1Pic],[_l2BG,_l2Txt,_l2Pic],[_l3BG,_l3Txt,_l3Pic],[_l4BG,_l4Txt,_l4Pic],[_l5BG,_l5Txt,_l5Pic]];
} else {
    {
        private _lineNumber = _forEachIndex;
        _x apply {
            private _curPos = ctrlPosition _x;
            _x ctrlSetPosition [(_curPos select 0) + (0.28 * _xScale), HINT_Y + _lineNumber * (SPACING_Y + HINT_H)];
            _x ctrlCommit 0.5;
            false
        };
    } forEach [[_l1BG,_l1Txt,_l1Pic],[_l2BG,_l2Txt,_l2Pic],[_l3BG,_l3Txt,_l3Pic],[_l4BG,_l4Txt,_l4Pic],[_l5BG,_l5Txt,_l5Pic]];

    [{
        titleRsc [QGVAR(empty), "PLAIN"];
    },[],1] call CBA_fnc_waitAndExecute;
};
