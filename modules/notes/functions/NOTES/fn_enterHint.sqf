#include "script_component.hpp"

#include "..\..\dialog\defines.hpp"

private _enterHint = uiNamespace getVariable [QGVAR(currentEnterHint), scriptNull];
if (!scriptDone _enterHint) exitWith {};

_enterHint = [] spawn {
    disableSerialization;

    private _dialog = findDisplay LN_DIALOG;
    if (isNull _dialog) exitWith {};

    private _title = _dialog displayCtrl LN_TITLE;
    private _closeButton = _dialog displayCtrl LN_CLOSEBUTTON;

    private _oldText = ctrlText _title;
    private _oldColor = [
        profilenamespace getvariable ['GUI_BCG_RGB_R',0],
        profilenamespace getvariable ['GUI_BCG_RGB_G',0],
        profilenamespace getvariable ['GUI_BCG_RGB_B',0],
        1
    ];

    private _red = [0.9,0.13,0.13,1];

    player say "HintCollapse";
    _closeButton ctrlShow false;
    _title ctrlSetText "SHIFT + ENTER FOR NEW LINE";


    for "_i" from 0 to 1 do {
        if (isNull _dialog) exitWith {};
        _title ctrlSetBackgroundColor _red;
        sleep 0.5;

        if (isNull _dialog) exitWith {};
        _title ctrlSetBackgroundColor _oldColor;
        /*if (_i != 1) then {sleep 0.5};*/
        sleep 0.5;
    };

    if (isNull _dialog) exitWith {};
    _title ctrlSetText _oldText;
    _closeButton ctrlShow true;
};

uiNamespace setVariable [QGVAR(currentEnterHint), _enterHint];
