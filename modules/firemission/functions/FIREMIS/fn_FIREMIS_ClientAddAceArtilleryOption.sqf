#include "script_component.hpp"

private _guns = _this;

if(!(player getVariable [VAR_SART_PLAYERRECEIVEDGUNS,false])) then
{
  private _action = ["Artillery_Menu", "Artillery Menu", "", {true}, {(count (player getVariable [VAR_SART_OBSGUNS,[]])) > 0}] call ace_interact_menu_fnc_createAction;
  [player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

  _action = ["Artillery_Call_Menu", "Call Firemission", "", {true}, {true}] call ace_interact_menu_fnc_createAction;
  [player, 1, ["ACE_SelfActions","Artillery_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

  _action = ["PointFiremission", "Point Firemission", "", {[] call FNC_DIA_PointFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
  [player, 1, ["ACE_SelfActions","Artillery_Menu","Artillery_Call_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

  _action = ["LineFiremission", "Line Firemission", "", {[] call FNC_DIA_LineFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
  [player, 1, ["ACE_SelfActions","Artillery_Menu","Artillery_Call_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

  _action = ["BracketFiremission", "Bracket Firemission", "", {[] call FNC_DIA_BracketFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
  [player, 1, ["ACE_SelfActions","Artillery_Menu","Artillery_Call_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

  _action = ["DonutFiremission", "Donut Firemission", "", {[] call FNC_DIA_DonutFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
  [player, 1, ["ACE_SelfActions","Artillery_Menu","Artillery_Call_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

  _action = ["MarkerFiremission", "Marker Firemission", "", {[] call FNC_DIA_MarkerFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
  [player, 1, ["ACE_SelfActions","Artillery_Menu","Artillery_Call_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

  _action = ["PolarFiremission", "Polar Firemission", "", {[] call FNC_DIA_PolarFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
  [player, 1, ["ACE_SelfActions","Artillery_Menu","Artillery_Call_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

  _action = ["SpottingFiremission", "Call Spotting Round", "", {true}, {true}] call ace_interact_menu_fnc_createAction;
  [player, 1, ["ACE_SelfActions","Artillery_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;


  _action = ["SpottingFiremission", "Polar Spotting Round", "", {[] call FNC_DIA_PolarSpottingFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
  [player, 1, ["ACE_SelfActions","Artillery_Menu","SpottingFiremission"], _action] call ace_interact_menu_fnc_addActionToObject;

  _action = ["SpottingFiremission", "Grid Spotting Round", "", {[] call FNC_DIA_GridSpottingFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
  [player, 1, ["ACE_SelfActions","Artillery_Menu","SpottingFiremission"], _action] call ace_interact_menu_fnc_addActionToObject;

  _action = ["FiremissionInformation", "Firemission Information", "", {true}, {true}] call ace_interact_menu_fnc_createAction;
  [player, 1, ["ACE_SelfActions","Artillery_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

  _action = ["StopFiremission", "Stop Firemissions", "", {true}, {true}] call ace_interact_menu_fnc_createAction;
  [player, 1, ["ACE_SelfActions","Artillery_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;
  _guns apply {
    private _artyName =_x call FUNC(FIREMIS_Dia_GetArtyDisplayName);
    private _text = ("Stop " + _artyName);
    _action = ["Stop",_text , "", {(_this select 2) call FUNC(FIREMIS_StopArtilleryClient); }, {!(( _this select 2) call FUNC(FIREMIS_Dia_IsArtyAvailable))},{},_x] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","Artillery_Menu","StopFiremission"], _action] call ace_interact_menu_fnc_addActionToObject;
  };

  _guns apply {
    private _artyName =_x call FUNC(FIREMIS_Dia_GetArtyDisplayName);
    private _text = ("Info " + _artyName);
    _action = ["Info",_text , "",{hint ((_this select 2) call FUNC(FIREMIS_Dia_GetCompleteInfoText)); }, { !((_this select 2) call FUNC(FIREMIS_Dia_IsArtyAvailable))},{},_x] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","Artillery_Menu","FiremissionInformation"], _action] call ace_interact_menu_fnc_addActionToObject;
  };

  ["Event_ArtyIsReady",
  {
    [PFM_DIA_IDC_GUNSELECT] call FUNC(FIREMIS_Dia_ArtLoadAvailableArtilleries);
    [LFM_DIA_IDC_GUNSELECT] call FUNC(FIREMIS_Dia_ArtLoadAvailableArtilleries);
    [BFM_DIA_IDC_GUNSELECT] call FUNC(FIREMIS_Dia_ArtLoadAvailableArtilleries);
    [DFM_DIA_IDC_GUNSELECT] call FUNC(FIREMIS_Dia_ArtLoadAvailableArtilleries);
    [MFM_DIA_IDC_GUNSELECT] call FUNC(FIREMIS_Dia_ArtLoadAvailableArtilleries);
    [PSFM_DIA_IDC_GUNSELECT] call FUNC(FIREMIS_Dia_ArtLoadAvailableArtilleries);
    [GSFM_DIA_IDC_GUNSELECT] call FUNC(FIREMIS_Dia_ArtLoadAvailableArtilleries);
  }] call CBA_fnc_addEventHandler;
  player setVariable [VAR_SART_PLAYERRECEIVEDGUNS,true,true];
};
