#include "script_component.hpp"
#include "\a3\ui_f\hpp\definedikcodes.inc"
#include "\A3\Functions_F_Exp_A\EGSpectatorCommonDefines.inc"

params ["_display"];

TRACE_1("",_display);

_display displayAddEventHandler ["KeyDown", {
    params ["_ctrl","_key","_BtnShift","_BtnCtrl","_BtnAlt"];
    if (_key isEqualTo DIK_APOSTROPHE) then {
        TRACE_1("attempting to exit spectator",_this);
        private _terminated = ["Terminate"] call BIS_fnc_EGSpectator;
        [{
            _this select 0
        },{
            [] call BIS_fnc_camera;
        }, [_terminated]] call CBA_fnc_waitUntilAndExecute;
		//[] call BIS_fnc_camera;
	};
    if (_key isEqualTo DIK_B) then {
        if (GETMVAR(SpectatorBriefingDisplayOpen,false)) then {
            ["HIDE"] call FUNC(spectatorBriefing);
        } else {
            ["SHOW"] call FUNC(spectatorBriefing);
        };
    };
}];

private _controlGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
_controlGroup ctrlSetPosition [
    POS_X(0.225008),
    POS_Y(0.1),
    POS_W(0.538117),
    POS_H(0.685968)
];
_controlGroup ctrlCommit 0;

private _frame = _display ctrlCreate ["IGUIBack", -1, _controlGroup];
_frame ctrlSetPosition [
    0,
    0,
    POS_W(0.538117),
    POS_H(0.685968)
];
_frame ctrlCommit 0;
_frame ctrlSetText "#(rgb,8,8,3)color(0,0,0,0.2)";

private _teamCombo = _display ctrlCreate ["RscCombo", -1, _controlGroup];
_teamCombo ctrlSetPosition [
    POS_W(0.00719067),
    POS_H(0.00801841),
    POS_W(0.118123),
    POS_H(0.041998)
];
_teamCombo ctrlCommit 0;
_teamCombo ctrlSetText "#(rgb,8,8,3)color(0.6,0.6,0.6,1)";
_teamCombo ctrlSetBackgroundColor [0, 0, 0, 0.5];

private _entryList = _display ctrlCreate ["RscListbox", -1, _controlGroup];
_entryList ctrlSetPosition [
    POS_W(0.00719098),
    POS_H(0.0640158),
    POS_W(0.118123),
    POS_H(0.615971)
];
_entryList ctrlCommit 0;
_entryList ctrlSetText "#(rgb,8,8,3)color(0.6,0.6,0.6,1)";

private _textControlGroup = _display ctrlCreate ["RscControlsGroup", -1, _controlGroup];
_textControlGroup ctrlSetPosition [
    POS_X(0.12 + 0.235 + 0.01),
    POS_Y(0.1 + 0.00801841 + 0.05),
    POS_W(0.41),
    POS_H(0.671968)
];
_textControlGroup ctrlCommit 0;
_textControlGroup ctrlSetBackgroundColor [0, 0, 0, 0.8];

private _text = _display ctrlCreate ["RscStructuredText", -1, _textControlGroup];
_text ctrlSetPosition [
    0,
    0,
    POS_W(0.405),
    POS_H(0.671968)
];
//_text ctrlSetPosition [0,0,0,0];
_text ctrlCommit 0;
_text ctrlSetText "#(rgb,8,8,3)color(1,1,1,1)";
_text ctrlSetBackgroundColor [0, 0, 0, 0.3];
//75 total 

GVAR(allBriefings) params ["_westBriefing", "_eastBriefing", "_indBriefing", "_civBriefing", "_missionNotes"];
private _playerSide = GETPLVAR(BriefingSide,west);
private _teamSides = GETMVAR(TeamSides,[west]);
{
    _x params ["_name", "_side", "_icon", "_briefingArray"];
    if (_side in _teamSides) then {
        private _lbAdd = _teamCombo lbadd _name;
        _teamCombo lbSetPicture [_lbAdd, "\a3\3DEN\Data\Displays\Display3DEN\PanelRight\" + _icon];
        private _active = (_side isEqualTo _playerSide);
        if (_active) then {
            _teamCombo lbSetCurSel _lbAdd;
            _briefingArray apply {
                _entryList lbAdd (_x select 0);
            };
            _entryList lbSetCurSel 0;
            private _string = ((_briefingArray select 0) select 1);
            _text ctrlSetStructuredText parseText _string;
            _text ctrlSetPositionH ((ctrlTextHeight _text + 0.05) max (0.671968 * safezoneH));
            _text ctrlCommit 0;
        };
    };
} foreach [
    [GETMVAR(TeamName_Blufor,"BLUFOR"), west, "side_west_ca.paa", _westBriefing],
    [GETMVAR(TeamName_Opfor,"OPFOR"), east, "side_east_ca.paa", _eastBriefing],
    [GETMVAR(TeamName_Indfor,"INDFOR"), independent, "side_guer_ca.paa", _indBriefing],
    [GETMVAR(TeamName_Civ,"CIVILIAN"), civilian, "side_civ_ca.paa", _civBriefing]
];

private _lbAdd = _teamCombo lbadd "Mission Notes";

[{
    !(_this select 0 isEqualTo controlNull) && {!(_this select 1 isEqualTo controlNull)}
},{
    params ["_teamCombo", "_entryList"];
    _teamCombo ctrlAddEventHandler ["LBSelChanged",{["COMBOCHANGE", _this] call FUNC(spectatorBriefing)}];
    _entryList ctrlAddEventHandler ["LBSelChanged",{["LISTCHANGE", _this] call FUNC(spectatorBriefing)}];
}, [_teamCombo, _entryList]] call CBA_fnc_waitUntilAndExecute;

GVAR(SpectatorBriefingDisplayControls) = [_controlGroup, _frame, _teamCombo, _entryList, _text, _textControlGroup];
GVAR(SpectatorBriefingDisplayControls) apply {
    _x ctrlShow false
};

//TODO: override controls to add in custom controls
private _help = _display displayCtrl 73189;
private _background = _display displayCtrl 72812;

private _fnc_addControls = {
    params ["_help", "_background"];
    private _oldCount = lnbSize _help;
    private _hasFocus = !isNull (["GetFocus"] call { _this call (uiNamespace getVariable ["RscDisplayEGSpectator_script", {}]) });
	private _cameraMode = ["GetCameraMode"] call { _this call (missionNamespace getVariable ["BIS_fnc_EGSpectatorCamera", {}]) };
    private _allowFreeCamera = missionNamespace getVariable [VAR_ALLOW_FREE_CAMERA, true];
	private _allow3PPCamera = missionNamespace getVariable [VAR_ALLOW_3PP_CAMERA, true];
    TRACE_1("Help Controls"_oldCount);
    private _newHelpArray = [
        ["[B]", "Toggle Briefing"],
        ["[K]", "Toggle Kill Cam"],
        ["[']", "Toggle Camera"]
    ];
    
    //for "_i" from 0 to (count _oldCount - 1) step 1 do {
    //    private _left = _help lnbText [_i, 0];
    //    private _right = _help lnbText [_i, 1];
    //    _newHelpArray pushBack [_left, _right];
    //};
    if (_cameraMode != MODE_FPS && {_cameraMode != MODE_FREE || {_allowFreeCamera}}) then {
		_newHelpArray pushback ["[RMB]", localize "STR_A3_Spectator_Helper_CameraRotation"];
	};

	if (_hasFocus) then {
		if (_allowFreeCamera) then {
			_newHelpArray pushBack ["[LMB]", localize "STR_A3_Spectator_Helper_Unfocus"];
		};

		if (_allowFreeCamera || _allow3PPCamera) then {
			_newHelpArray pushBack ["[SPACE]", localize "STR_A3_Spectator_Helper_CameraMode"];
		};
	}
	else
	{
		if (_allowFreeCamera) then {
			_newHelpArray pushBack ["[LMB]", localize "STR_A3_Spectator_Helper_Focus"];
		};
	};

	if (_cameraMode == MODE_FREE && {_allowFreeCamera}) then {
		_newHelpArray pushback ["[W/S]", localize "STR_A3_Spectator_Helper_Movement"];
		_newHelpArray pushback ["[A/D]", localize "STR_A3_Spectator_Helper_Strafing"];
		_newHelpArray pushback ["[Q/Z]", localize "STR_A3_Spectator_Helper_Height"];
	};

	_newHelpArray pushback ["[BACK]", localize "STR_A3_Spectator_Helper_Interface"];
	_newHelpArray pushback ["[F1]", localize "STR_A3_Spectator_Helper_Controls"];

	if (_cameraMode == MODE_FREE) then {
		_newHelpArray pushback ["[LSHIFT]", localize "STR_A3_Spectator_Helper_Shift"];
		_newHelpArray pushback ["[LALT]", localize "STR_A3_Spectator_Helper_Alt"];
		_newHelpArray pushback ["[LALT + LSHIFT]", localize "STR_A3_Spectator_Helper_ShiftAlt"];
	};
    
    TRACE_1("Help Controls"_newHelpArray);
    private _x = uiNamespace getVariable [VAR_DEFAULT_HELP_X, (ctrlPosition _help) select 0];
	private _y = uiNamespace getVariable [VAR_DEFAULT_HELP_Y, (ctrlPosition _help) select 1];
	private _w = uiNamespace getVariable [VAR_DEFAULT_HELP_W, (ctrlPosition _help) select 2];
	private _h = uiNamespace getVariable [VAR_DEFAULT_HELP_H, (ctrlPosition _help) select 3];
    private _amount = (_h + 0.01) / 12;
    private _newH = _amount * count _newHelpArray + 0.01;
    private _newY = safezoneY + safezoneH - _newH;
	private _newW = _w;
	private _newX = safezoneX + safezoneW - _newW;

    lnbClear _help;
    {
        _help lnbAddRow [_x select 0, _x select 1];
        _help lnbSetColor [[_forEachIndex, 0], [0.75,0.6,0,1]];
    } forEach _newHelpArray;

    {
    	_x ctrlSetPosition [_newX, _newY, _newW, _newH];
    	_x ctrlCommit 0;
    } forEach [_background, _help];
};

private _observeHelpControlsPFH = [{
    params ["_args", "_idPFH"];
    _args params ["_help", "_background", "_fnc_addControls", "_display"];
    if (_display isEqualTo displayNull || {_help isEqualTo controlNull}) exitwith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _firstText = _help lnbText [0, 0];
    if (_firstText isEqualTo "[B]") exitwith {};
    [_help, _background] call _fnc_addControls;
}, 0, [_help, _background, _fnc_addControls, _display]] call CBA_fnc_addPerFrameHandler;

[_help, _background] call _fnc_addControls;