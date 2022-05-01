/**
 * This file is run when the mission starts, here you can customise how
 * headless AI units will spawn in and what behaviour they'll have
 */
#include "script_component.hpp"

#include "settings.sqf"

[{CBA_missionTime > 0}, {
  params["_groups"];

  private _hcPresent = !isNil "HC_1";

  private _doSpawn = {
    /*
     * Change the code below to alter the behaviour of headless AI spawned units
     * This function is an example and elements of it are commented out to show
     * what you could possibly do.
     */
    private _run = 1;
    /* while {True} do { */
      private _group = nil;
      /* sleep (300); // Sleep for 5 minutes between waves */

      _groups apply {
        private _crewGroup = nil;

        _group = _x call FUNC(spawnUnits);
        _group setBehaviour "AWARE";
        /* _group addWaypoint [(getMarkerPos "marker_wp1"), -1];
        _group addWaypoint [(getMarkerPos "marker_wp2"), -1];
        _group addWaypoint [(getMarkerPos "marker_wp3"), -1];
        _group addWaypoint [(getMarkerPos "marker_wp4"), -1];

        // Vehicle round
        private _veh = nil;
        if (((_run % 4) == 0) || ((_run % 2) == 0)) then {
          if ((_run % 4) == 0) then { // Every 4th time
            _veh = "rhs_bmp1_msv" createVehicle getMarkerPos "marker_wp1";

          } else { // Every other time
            _veh = "UK3CB_ARD_O_UAZ_MG" createVehicle getMarkerPos "marker_wp1";
          };

          sleep(5);

          _crewGroup = [(getMarkerPos "marker_spawn"), [["O_Soldier_F", "USMCRiflePlatoon_RF"], ["O_Soldier_F", "USMCRiflePlatoon_RF"]], opfor] call FUNC(spawnUnits);
          _crewGroup addVehicle _veh;
          _crewGroup setBehaviour "AWARE";

          private _wp = _crewGroup addWaypoint [(getMarkerPos "marker_wp1"), -1];
          _wp setWaypointType 'GETIN';
          _crewGroup addWaypoint [(getMarkerPos "marker_wp2"), -1];
          _crewGroup addWaypoint [(getMarkerPos "marker_wp3"), -1];
          _crewGroup addWaypoint [(getMarkerPos "marker_wp4"), -1];
        };

        // Ural spawning each time
        _veh = "UK3CB_ARD_O_Ural_Open" createVehicle getMarkerPos "marker_wp1";

        sleep(5);

        _crewGroup = [(getMarkerPos "marker_spawn"), [["O_Soldier_F", "USMCRiflePlatoon_RF"], ["O_Soldier_F", "USMCRiflePlatoon_RF"]], opfor] call FUNC(spawnUnits);
        _crewGroup addVehicle _veh;
        _crewGroup setBehaviour "AWARE";

        _wp = _crewGroup addWaypoint [(getMarkerPos "marker_wp1"), -1];
        _wp setWaypointType 'GETIN';
        _crewGroup addWaypoint [(getMarkerPos "marker_wp2"), -1];
        _crewGroup addWaypoint [(getMarkerPos "marker_wp3"), -1];
        _crewGroup addWaypoint [(getMarkerPos "marker_wp4"), -1]; */

      /* }; */
      _run = _run + 1;
    };
  };

  // Leave this code alone
   if (isMultiplayer && {_hcPresent}) then { // If HC is connected
    if (!isServer && {!hasInterface}) then { // If this unit is the HC
      call _doSpawn;
    } else {
      // Do nothing.
    };
  } else {
    if (isServer) then { // If HC isn't connected and this is the server
      call _doSpawn;
    } else {
      // Do nothing.
    };
  };
}, [_groups]] call CBA_fnc_waitUntilAndExecute;
