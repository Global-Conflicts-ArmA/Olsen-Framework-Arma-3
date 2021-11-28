/*
This module covers the area on the map outside of the AO Marker. The first AO marker in the array is the initial AO shown to all players.
Specific units can be given the ability to switch AOs with this setvariable ["HasAltMaps",true];
You can script an AO change using [MARKERNAMEINQUOTES,ISCENTERED,ZOOMLEVEL,NAME VISIBLE IN SELF INTERACT, BACKGROUND COLOR] call FNC_AOCoverAndCenterMap;
You could have different groups/teams with different AOs, or a briefing AO different from specific AOs in game if needed.
A list of map colours are available here: https://community.bistudio.com/wiki/Arma_3_CfgMarkerColors

Examples:
  _AOMarkers = [MARKERNAMEINQUOTES,ISCENTERED,ZOOMLEVEL,NAME VISIBLE IN SELF INTERACT, BACKGROUND COLOR];
  _AOMarkers = [["AOMarker_1",true,0.4,"Bahnhof","ColorBlack"]];
*/

// Global Map Marker Array
private _AOMarkers = [
  ["AOMarker_1", true, 0.4, "AO", "ColorGrey"],
  ["AOMarker_2", true, 0.8, "AO 2", "ColorGrey"]
];
