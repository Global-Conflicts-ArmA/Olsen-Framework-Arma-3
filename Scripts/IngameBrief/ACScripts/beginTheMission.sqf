if (isServer) then 
{ 
		
	[] spawn 
	{
	
	waitUntil {bluforIsReady && opforIsReady};
	sleep 5;

	[-2, {hint "Both sides are ready, the mission will begin in:\n 15 seconds";}] call CBA_fnc_globalExecute;
	sleep 5;
	
	[-2, {hint "Mission begins in:\n 10 seconds";}] call CBA_fnc_globalExecute;
	sleep 5;
	
	[-2, {hint "Mission begins in:\n 5 seconds";}] call CBA_fnc_globalExecute;
	sleep 5;
	
	missionStarter = True;
	publicVariable "missionStarter";
	
	sleep 0.3;
	
	[-2, {hint "Mission is LIVE";}] call CBA_fnc_globalExecute;
	};

};