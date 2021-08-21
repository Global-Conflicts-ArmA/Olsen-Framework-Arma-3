//This module is to allow selected sides to view only specific markers

//ADDMARKER(SIDE/TEAM, MARKER VARIABLE NAME, DELETE_AFTER_START
//SIDE is the side of the marker, NAME is the name of the marker.
//If you dont want anyone to see the marker use SYSTEM.
//DELETE_AFTER_START if set to true will delete the marker after briefing

//Example:
ADDMARKER(west, "uk", true);
ADDMARKER(east, "setup", false);
ADDMARKER(independent, "bunker", false);
ADDMARKER(civilian, "tower", false);