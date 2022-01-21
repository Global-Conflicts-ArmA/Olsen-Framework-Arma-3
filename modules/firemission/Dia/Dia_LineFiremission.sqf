#include "..\..\..\core\script_macros.hpp"
#include "..\functions\FIREMIS\defs.hpp"

FNC_DIA_LineFiremissionOpenDialog =
{
	createDialog "DIA_LineFiremission";
	[LFM_DIA_IDC_GUNSELECT,LFM_DIA_IDC_SHELLSELECT] call EFUNC(FIREMIS,Dia_ArtLoadAvailableArtilleries);
};

FNC_DIA_LineFiremissionSetArtillery =
{
	[LFM_DIA_IDC_SHELLSELECT,_this] call EFUNC(FIREMIS,Dia_ArtSetArtillery);
};

FNC_DIA_LineFiremissionCloseDialog =
{
	closeDialog LFM_DIA_IDD_DISPLAY;

};

FNC_DIA_LineFiremissionFire =
{
	private _guns = player getVariable [VAR_SART_OBSGUNS,[]];
	private _usableGuns = [];
	{
		if(_x call EFUNC(FIREMIS,Dia_IsArtyAvailable)) then
		{
			_usableGuns pushBack _x;
		};
	}forEach _guns;
	private _selectedUnit = objNull;
	 if((count _usableGuns) > 0) then { _selectedUnit = (_usableGuns select (lbCurSel LFM_DIA_IDC_GUNSELECT));};
	private _selectedAmmo = lbCurSel LFM_DIA_IDC_SHELLSELECT;
	private _startGrid = 	ctrlText LFM_DIA_IDC_STARTGRID;
	private _endGrid =  ctrlText LFM_DIA_IDC_ENDGRID;
 	private _burstNumber = (ctrlText LFM_DIA_IDC_BURSTNUMBER) call BIS_fnc_parseNumber;
	private _burstRounds = (ctrlText LFM_DIA_IDC_BURSTROUNDS) call BIS_fnc_parseNumber;
	private _burstDelay = (ctrlText LFM_DIA_IDC_BURSTDELAY) call BIS_fnc_parseNumber;
	private _spotting =  (ctrlText LFM_DIA_IDC_SPOTTING) call BIS_fnc_parseNumber;

	private _inputIsCorrect = true;
	_inputIsCorrect = _inputIsCorrect && [_selectedUnit,"No Arty selected/aviable"] call EFUNC(FIREMIS,Dia_InputIsUnit);
	_inputIsCorrect = _inputIsCorrect && [_burstNumber,"Burst number is not a number"] call EFUNC(FIREMIS,Dia_InputIsNumber);
	_inputIsCorrect = _inputIsCorrect && [_burstRounds,"Burst rounds is not a number"] call EFUNC(FIREMIS,Dia_InputIsNumber);
	_inputIsCorrect = _inputIsCorrect && [_burstDelay,"Burst delay is not a number"] call EFUNC(FIREMIS,Dia_InputIsNumber);
	_inputIsCorrect = _inputIsCorrect && [_spotting,"Spotting distance is not a number"] call EFUNC(FIREMIS,Dia_InputIsNumber);

	if(_inputIsCorrect ) then
	{

						private _round =  ((_selectedUnit call EFUNC(FIREMIS,Dia_GetArtyAmmo)) select _selectedAmmo) select 0;
						hint (([_selectedUnit,[_startGrid,true] call CBA_fnc_mapGridToPos,[_endGrid,true] call CBA_fnc_mapGridToPos,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo] call EFUNC(FIREMIS,GetLineFiremissionText))
							+ "Requested by: " + (name player)
							+ "\nETA: " + str (round ((_selectedUnit call EFUNC(FIREMIS,Dia_GetArtyAimTime)) + ([_selectedUnit,[_startGrid,true] call CBA_fnc_mapGridToPos,_round] call EFUNC(FIREMIS,Dia_GetArtyEta)))) + " s");
							["CallLineFiremission", [player,_selectedUnit,_selectedAmmo,_startGrid,_endGrid,_burstNumber,_burstRounds,_burstDelay,_spotting]] call CBA_fnc_serverEvent;
						[] call FNC_DIA_LineFiremissionCloseDialog;
	};



};

FNC_DIA_Server_LineFiremissionFire =
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

	[_selectedUnit,_requester] call EFUNC(FIREMIS,Dia_SetArtyCaller);
	[_selectedUnit,[_startGrid,true] call CBA_fnc_mapGridToPos,[_endGrid,true] call CBA_fnc_mapGridToPos,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo] call EFUNC(FIREMIS,LineFiremission);


};
if(isServer) then {["CallLineFiremission", {_this call FNC_DIA_Server_LineFiremissionFire;}] call CBA_fnc_addEventHandler;};
