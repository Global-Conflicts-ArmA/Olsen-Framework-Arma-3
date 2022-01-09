#include "..\..\..\core\script_macros.hpp"
#include "..\functions\FIREMIS\defs.hpp"

FNC_DIA_BracketFiremissionOpenDialog =
{
	createDialog "DIA_BracketFiremission";
	[BFM_DIA_IDC_GUNSELECT,BFM_DIA_IDC_SHELLSELECT] call FUNC(FIREMIS_Dia_ArtLoadAvailableArtilleries);
};

FNC_DIA_BracketFiremissionSetArtillery =
{
	[BFM_DIA_IDC_SHELLSELECT,_this] call FUNC(FIREMIS_Dia_ArtSetArtillery);
};

FNC_DIA_BracketFiremissionCloseDialog =
{
	closeDialog BFM_DIA_IDD_DISPLAY;

};

FNC_DIA_BracketFiremissionFire =
{
	private _guns = player getVariable [VAR_SART_OBSGUNS,[]];
	private _usableGuns = [];
	{
		if(_x call FUNC(FIREMIS_Dia_IsArtyAvailable)) then
		{
			_usableGuns pushBack _x;
		};
	}forEach _guns;
	private _selectedUnit = objNull;
	 if((count _usableGuns) > 0) then { _selectedUnit = (_usableGuns select (lbCurSel BFM_DIA_IDC_GUNSELECT));};
	private _selectedAmmo = lbCurSel BFM_DIA_IDC_SHELLSELECT;
	private _startGrid = 	ctrlText BFM_DIA_IDC_STARTGRID;
	private _endGrid =  ctrlText BFM_DIA_IDC_ENDGRID;
 	private _burstNumber = (ctrlText BFM_DIA_IDC_BURSTNUMBER) call BIS_fnc_parseNumber;
	private _burstRounds = (ctrlText BFM_DIA_IDC_BURSTROUNDS) call BIS_fnc_parseNumber;
	private _burstDelay = (ctrlText BFM_DIA_IDC_BURSTDELAY) call BIS_fnc_parseNumber;
	private _spotting =  (ctrlText BFM_DIA_IDC_SPOTTING) call BIS_fnc_parseNumber;
	private _inputIsCorrect = true;
	_inputIsCorrect = _inputIsCorrect && [_selectedUnit,"No Arty selected/aviable"] call FUNC(FIREMIS_Dia_InputIsUnit);
	_inputIsCorrect = _inputIsCorrect && [_burstNumber,"Burst number is not a number"] call FUNC(FIREMIS_Dia_InputIsNumber);
	_inputIsCorrect = _inputIsCorrect && [_burstRounds,"Burst rounds is not a number"] call FUNC(FIREMIS_Dia_InputIsNumber);
	_inputIsCorrect = _inputIsCorrect && [_burstDelay,"Burst delay is not a number"] call FUNC(FIREMIS_Dia_InputIsNumber);
	_inputIsCorrect = _inputIsCorrect && [_spotting,"Spotting distance is not a number"] call FUNC(FIREMIS_Dia_InputIsNumber);

	if(_inputIsCorrect ) then
	{
						private _round =  ((_selectedUnit call FUNC(FIREMIS_Dia_GetArtyAmmo)) select _selectedAmmo) select 0;
						hint (([_selectedUnit,[_startGrid,true] call CBA_fnc_mapGridToPos,[_endGrid,true] call CBA_fnc_mapGridToPos,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo] call FUNC(FIREMIS_GetBracketFiremissionText))
							+ "Requested by:" + (name player)
							+ "\nETA: " + str (round ((_selectedUnit call FUNC(FIREMIS_Dia_GetArtyAimTime)) + ([_selectedUnit,[_startGrid,true] call CBA_fnc_mapGridToPos,_round] call FUNC(FIREMIS_Dia_GetArtyEta)))) + " s");
						["CallBracketFiremission", [player,_selectedUnit,_selectedAmmo,_startGrid,_endGrid,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo]] call CBA_fnc_serverEvent;
						[] call FNC_DIA_BracketFiremissionCloseDialog;
	};


};

FNC_DIA_Server_BracketFiremissionFire =
{
	private _requester  = _this select 0;
	private _selectedUnit = _this select 1;
	private _selectedAmmo = _this select 2;
	private _startGrid = _this select 3;
	private _endGrid = _this select 4;
	private _burstNumber = _this select 5;
	private _burstRounds = _this select 6;
	private _burstDelay = _this select 7;
	private _spotting =  _this select 8;

	[_selectedUnit,_requester] call FUNC(FIREMIS_Dia_SetArtyCaller);
	[_selectedUnit,[_startGrid,true] call CBA_fnc_mapGridToPos,[_endGrid,true] call CBA_fnc_mapGridToPos,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo]   call FUNC(FIREMIS_BracketFiremission);



};
if(isServer) then {["CallBracketFiremission", {_this call FNC_DIA_Server_BracketFiremissionFire;}] call CBA_fnc_addEventHandler;};
