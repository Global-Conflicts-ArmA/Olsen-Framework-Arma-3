#include "script_component.hpp"

if (!isMultiplayer || !hasInterface) then { // If this is the server or headless client
	private _handle = _this spawn
	{
		private _observer = _this select 0;
		private _batteries = _this select 1;
		private _minimumKnowledge = _this select 2;
		private _minRange = _this select 3;
		private _range = _this select 4;
		private _standardDispersion = _this select 5;
		private _standardRoundCount = _this select 6;
		private _standardRoundBurst = _this select 7;
		private _standardRoundBurstWait = _this select 8;
		private _minSpottedDistance = _this select 9;
		private _standardRound = _this select 10;
		private _obsSide = side _observer;

		private _currentShotTargets = [];
		while{alive _observer} do
		{
				private _possibleTargets = _observer nearTargets _range;
				_possibleTargets apply {
					if([_obsSide, _x select 2] call BIS_fnc_sideIsEnemy) then
					{

							//found an enemy
							private _target = _x select 4;
							private _distance2DToClosestFiremission = 1000;
							_currentShotTargets apply {
								if( _distance2DToClosestFiremission > _target distance2D (_x select 1)) then
								{
										_distance2DToClosestFiremission = _target distance2D (_x select 1);
								};
							};

							if((_observer knowsAbout  _target >= _minimumKnowledge) && (_distance2DToClosestFiremission > _minRange) && (((getPosATL _target) select 2) < 10 ) ) then
							{
									//we know enough about it
									//calculate position
									private _pos = [[[_target,(_observer getVariable [VAR_SART_OBSACCURACY,OBSACCURACY]) * (_target distance2D _observer) /  _range ]],[]] call BIS_fnc_randomPos;
									sleep(_observer getVariable [VAR_SART_OBSSPEED,OBSSPEED]);
									if(alive _observer) then {
										private _hasFired = false;
										//fire a firemission
										_batteries apply {
												if((!(_x getVariable [VAR_SART_ARTINFIREMISSION,false])) && !(_hasFired) ) then {
														_currentShotTargets pushBack [_x,_pos];
														[_x,_pos,_standardDispersion,_standardRoundCount,_standardRoundBurst,_standardRoundBurstWait,_minSpottedDistance,_standardRound] call FUNC(FIREMIS_PointFiremission);
														_hasFired = true;
												};
													/* private _freeBattery = _batteries; */
										};
									};
							};
					};
				};

			sleep(5);
			private _tempAdd = [];
			_currentShotTargets apply {
					if((_x select 0) getVariable [VAR_SART_ARTINFIREMISSION,false]) then
					{
							_tempAdd pushBack (_x);
					};
			};
			_currentShotTargets = _tempAdd;
		};
	};
		(_this select 0) setVariable [VAR_SART_FMHANDLE,_handle,true];
};
