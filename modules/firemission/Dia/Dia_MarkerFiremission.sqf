#include "..\..\..\core\script_macros.hpp"
#include "..\functions\FIREMIS\defs.hpp"

FNC_DIA_MarkerFiremissionOpenDialog =
{
	INFO("INFO: Marker firemission open called.");
	createDialog "DIA_MarkerFiremission";
	[MFM_DIA_IDC_GUNSELECT,MFM_DIA_IDC_SHELLSELECT] call EFUNC(FIREMIS,Dia_ArtLoadAvailableArtilleries);
};

FNC_DIA_MarkerFiremissionSetArtillery =
{
	[MFM_DIA_IDC_SHELLSELECT,_this] call EFUNC(FIREMIS,Dia_ArtSetArtillery);
};

FNC_DIA_MarkerFiremissionCloseDialog =
{
	closeDialog MFM_DIA_IDD_DISPLAY;

};

FNC_DIA_MarkerFiremissionFire =
{
	private _guns = player getVariable [VAR_SART_OBSGUNS,[]];
	private _usableGuns = [];
	_guns apply {
		if(_x call EFUNC(FIREMIS,Dia_IsArtyAvailable)) then
		{
			_usableGuns pushBack _x;
		};
	};
	private _selectedUnit = objNull;
	 if((count _usableGuns) > 0) then { _selectedUnit = (_usableGuns select (lbCurSel MFM_DIA_IDC_GUNSELECT));};
	/* diag_log format ["INFO: MFM_DIA_IDC_SHELLSELECT = %1", MFM_DIA_IDC_SHELLSELECT]; */
	private _selectedAmmo = lbCurSel MFM_DIA_IDC_SHELLSELECT;
	private _name = ctrlText MFM_DIA_IDC_NAME;
	private _dispersion = (ctrlText MFM_DIA_IDC_DISPERSION) call BIS_fnc_parseNumber;
 	private _burstNumber = (ctrlText MFM_DIA_IDC_BURSTNUMBER) call BIS_fnc_parseNumber;
	private _burstRounds = (ctrlText MFM_DIA_IDC_BURSTROUNDS) call BIS_fnc_parseNumber;
	private _burstDelay = (ctrlText MFM_DIA_IDC_BURSTDELAY) call BIS_fnc_parseNumber;
	private _spotting =  (ctrlText MFM_DIA_IDC_SPOTTING) call BIS_fnc_parseNumber;

	private _inputIsCorrect = true;
	_inputIsCorrect = _inputIsCorrect && [_selectedUnit,"No Arty selected/aviable"] call EFUNC(FIREMIS,Dia_InputIsUnit);
	_inputIsCorrect = _inputIsCorrect && [_dispersion,"Dispersion is not a number"] call EFUNC(FIREMIS,Dia_InputIsNumber);
	_inputIsCorrect = _inputIsCorrect && [_burstNumber,"Burst number is not a number"] call EFUNC(FIREMIS,Dia_InputIsNumber);
	_inputIsCorrect = _inputIsCorrect && [_burstRounds,"Burst rounds is not a number"] call EFUNC(FIREMIS,Dia_InputIsNumber);
	_inputIsCorrect = _inputIsCorrect && [_burstDelay,"Burst delay is not a number"] call EFUNC(FIREMIS,Dia_InputIsNumber);
	_inputIsCorrect = _inputIsCorrect && [_spotting,"Spotting distance is not a number"] call EFUNC(FIREMIS,Dia_InputIsNumber);
	private _marker = _name call EFUNC(FIREMIS,Dia_FindMarkerOnMap);
	if(_marker == "") then { _inputIsCorrect = false;hint "marker does not exist";	};
	if(_inputIsCorrect) then
	{
		diag_log format ["INFO: _selectedAmmo = %1", _selectedAmmo];
		private _round =  ((_selectedUnit call EFUNC(FIREMIS,Dia_GetArtyAmmo)) select _selectedAmmo) select 0;

		hint (([_selectedUnit,_name,_dispersion,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo] call EFUNC(FIREMIS,GetMarkerFiremissionText))
			+ "Requested by: " + (name player)
			+ "\nETA: " + str (round ((_selectedUnit call EFUNC(FIREMIS,Dia_GetArtyAimTime)) + ([_selectedUnit,getMarkerPos (_marker),_round] call EFUNC(FIREMIS,Dia_GetArtyEta)))) + " s");
		["CallMarkerFiremission",  [player,_selectedUnit,_name,_dispersion,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo]] call CBA_fnc_serverEvent;
		[] call FNC_DIA_MarkerFiremissionCloseDialog;

	};



};

FNC_DIA_Server_MarkerFiremissionFire =
{
	private _requester  = _this select 0;
	private	_selectedUnit = _this select 1;
	private _marker = _this select 2;
	private _dispersion = _this select 3;
	private _burstNumber = _this select 4;
	private _burstRounds = _this select 5;
	private _burstDelay = _this select 6;
	private _spotting =  _this select 7;
	private _selectedAmmo = _this select 8;

	[_selectedUnit,_requester] call EFUNC(FIREMIS,Dia_SetArtyCaller);
	[_selectedUnit,_marker,_dispersion,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo] call EFUNC(FIREMIS,DynamicMarkerFiremission);


};
if(isServer) then {["CallMarkerFiremission", {_this call FNC_DIA_Server_MarkerFiremissionFire;}] call CBA_fnc_addEventHandler;};
