#include "..\..\..\core\script_macros.hpp"
#include "..\functions\FIREMIS\defs.hpp"

FNC_DIA_DonutFiremissionOpenDialog =
{
	createDialog "DIA_DonutFiremission";
	[DFM_DIA_IDC_GUNSELECT,DFM_DIA_IDC_SHELLSELECT] call FUNC(FIREMIS_Dia_ArtLoadAvailableArtilleries);
};

FNC_DIA_DonutFiremissionSetArtillery =
{
	[DFM_DIA_IDC_SHELLSELECT,_this] call FUNC(FIREMIS_Dia_ArtSetArtillery);
};

FNC_DIA_DonutFiremissionCloseDialog =
{
	closeDialog DFM_DIA_IDD_DISPLAY;

};

FNC_DIA_DonutFiremissionFire =
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
	 if((count _usableGuns) > 0) then { _selectedUnit = (_usableGuns select (lbCurSel DFM_DIA_IDC_GUNSELECT));};
	private _selectedAmmo = lbCurSel DFM_DIA_IDC_SHELLSELECT;
	private _grid = 	ctrlText DFM_DIA_IDC_GRID;
	private _innerRadius = ( ctrlText DFM_DIA_IDC_INNERRADIUS) call BIS_fnc_parseNumber;
	private _outerRadius = ( ctrlText DFM_DIA_IDC_OUTERRADIUS) call BIS_fnc_parseNumber;
 	private _burstNumber = (ctrlText DFM_DIA_IDC_BURSTNUMBER) call BIS_fnc_parseNumber;
	private _burstRounds = (ctrlText DFM_DIA_IDC_BURSTROUNDS) call BIS_fnc_parseNumber;
	private _burstDelay = (ctrlText DFM_DIA_IDC_BURSTDELAY) call BIS_fnc_parseNumber;
	private _spotting =  (ctrlText DFM_DIA_IDC_SPOTTING) call BIS_fnc_parseNumber;
	private _inputIsCorrect = true;
	_inputIsCorrect = _inputIsCorrect && [_selectedUnit,"No Arty selected/aviable"] call FUNC(FIREMIS_Dia_InputIsUnit);
	_inputIsCorrect = _inputIsCorrect && [_innerRadius,"Inner radius is not a number"] call FUNC(FIREMIS_Dia_InputIsNumber);
	_inputIsCorrect = _inputIsCorrect && [_outerRadius,"Outer radius is not a number"] call FUNC(FIREMIS_Dia_InputIsNumber);
	_inputIsCorrect = _inputIsCorrect && [_burstNumber,"Burst number is not a number"] call FUNC(FIREMIS_Dia_InputIsNumber);
	_inputIsCorrect = _inputIsCorrect && [_burstRounds,"Burst rounds is not a number"] call FUNC(FIREMIS_Dia_InputIsNumber);
	_inputIsCorrect = _inputIsCorrect && [_burstDelay,"Burst delay is not a number"] call FUNC(FIREMIS_Dia_InputIsNumber);
	_inputIsCorrect = _inputIsCorrect && [_spotting,"Spotting distance is not a number"] call FUNC(FIREMIS_Dia_InputIsNumber);
	if(_innerRadius > _outerRadius) then {_inputIsCorrect = false;hint "Inner Radius bigger than outer."};
	if(_inputIsCorrect ) then
	{

								private _round =  ((_selectedUnit call FUNC(FIREMIS_Dia_GetArtyAmmo)) select _selectedAmmo) select 0;
								hint (([_selectedUnit,_grid call CBA_fnc_mapGridToPos,_innerRadius,_outerRadius,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo] call FUNC(FIREMIS_GetDonutFiremissionText))
									+ "Requested by:" + (name player)
									+ "\nETA: " + str (round ((_selectedUnit call FUNC(FIREMIS_Dia_GetArtyAimTime)) + ([_selectedUnit,[_grid,true] call CBA_fnc_mapGridToPos,_round] call FUNC(FIREMIS_Dia_GetArtyEta)))) + " s");
									["CallDonutFiremission", [player,_selectedUnit,_selectedAmmo,_grid,_innerRadius,_outerRadius,_burstNumber,_burstRounds,_burstDelay,_spotting]] call CBA_fnc_serverEvent;
								[] call FNC_DIA_DonutFiremissionCloseDialog;

	};




};

FNC_DIA_Server_DonutFiremissionFire =
{
	private _requester  = _this select 0;
	private _selectedUnit = _this select 1;
	private _selectedAmmo = _this select 2;
	private _grid = _this select 3;
	private _innerRadius = _this select 4;
	private _outerRadius = _this select 5;
	private _burstNumber = _this select 6;
	private _burstRounds = _this select 7;
	private _burstDelay = _this select 8;
	private _spotting =  _this select 9;

	[_selectedUnit,_requester] call FUNC(FIREMIS_Dia_SetArtyCaller);
	[_selectedUnit ,[_grid,true] call CBA_fnc_mapGridToPos,_innerRadius,_outerRadius,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo]   call FUNC(FIREMIS_DonutFiremission);


};

if(isServer) then {["CallDonutFiremission", {_this call FNC_DIA_Server_DonutFiremissionFire;}] call CBA_fnc_addEventHandler;};
