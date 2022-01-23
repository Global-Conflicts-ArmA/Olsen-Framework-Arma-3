#include "script_component.hpp"
#include "..\..\dialog\defines.hpp"

params [["_mode", "UNDEFINED"],"_note","_message","_handwriting"];

disableSerialization;

switch (_mode) do {
  case "WRITE": {
    createDialog QGVAR(write);
    private _dialog = findDisplay LN_DIALOG;
    private _notepad = _dialog displayCtrl LN_NOTEPAD;
    private _editBox = _dialog displayCtrl LN_EDITBOX;

    _notepad ctrlSetText (getMissionPath "modules\notes\data\notepad.paa");

    if (GVAR(visibleHandwriting)) then {
        _handwriting = player getVariable [QGVAR(handwriting), ["",["","TahomaB"]]];
        _handwriting params ["_modifier", "_type"];
        _editBox ctrlSetFont (_type select 1);
    };
  };

  case "READ": {
    createDialog QGVAR(read);
    private _dialog = findDisplay LN_DIALOG;
    private _notepad = _dialog displayCtrl LN_NOTEPAD;
    _notepad ctrlSetText (getMissionPath "modules\notes\data\notepad.paa");
    private _textBox = _dialog displayCtrl LN_TEXTBOX;
    private _button2 = _dialog displayCtrl LN_BUTTON2;
    private _button3 = _dialog displayCtrl LN_BUTTON3;
    //_message = "";
    //_note = player getVariable [QGVAR(activeNote), objNull];

    if (_note isEqualType objNull) then {
        _button2 ctrlSetText "TAKE";
    };

    if (_note isEqualType 0) then {
        private _nodeName = format ["GVAR(myNotes_)%1", _note];
        _button2 ctrlSetText "DROP";
    };

    if !(player getVariable [QGVAR(canInspect), GVAR(canInspectDefault)]) then {
        _button3 ctrlShow false;
    };

    if (GVAR(visibleHandwriting)) then {
        _handwriting params ["_modifier", "_type"];
        _textBox ctrlSetFont (_type select 1);
    };

    _textBox ctrlSetText _message;

  };

  default {
      ERROR_1("%1 is not a valid mode.", _mode)
  };
};
