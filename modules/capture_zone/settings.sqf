/*
To detect a capturezone being held by a side for use in a trigger or end conditions, use:

missionNamespace getVariable ["captureZone1", sideEmpty] isEqualTo <SIDE>

eg in end conditions:

if (missionNamespace getVariable ["captureZone1", sideEmpty] isEqualTo west) exitwith {
    // mission end function call
};

*/


[
    "testCap", // Marker name
    "Capture Zone 1", // Display name of capture zone
    "captureZone1", // mission variable name used to determine control of zone
    [
        [
            blufor, // team side
            30, // seconds needed to capture
            1 // ratio needed to capture (1.5 would be a ratio of 1.5:1)
        ],
        [east, 30, 1]
    ],
    "REPEAT", /* mode the capture zone operates in. (default REPEAT, optional)
            HOLD means a team must have eligble units inside a zone or it will default back to uncontested. It can be recaptured.
            ONCE means it will start controlled or uncontrolled, depending on starting units, then can only be captured once.
            REPEAT means it will start controlled or uncontrolled, depending on starting units, then can be recaptured.
            */
    false, // Whether to only count players as eligble units (default false, optional)
    5, // Interval to check capture zone in seconds (default 5 seconds, optional)
    50, // Percentage of time of the time needed to capture for the team colour to start fading in from grey. A value of -1 makes this immediate. (default 50%, optional)
    ["Blufor is capturing the zone", "Opfor is capturing the zone", "Resistance is capturing the zone", "Civilian is capturing the zone", "The zone is contested", "The zone is uncontested"], // Custom messages, Todo: implment custom messages alongside custom FW team names
    ["ColorBlue", "ColorRed", "ColorGreen", "ColorYellow", "ColorWhite", "ColorKhaki"] // Custom team and uncontested values for colours, optional
] call FUNC(setCaptureZone);
