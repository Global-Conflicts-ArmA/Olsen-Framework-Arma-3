
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
    "REPEAT", /* mode the capture zone operates in.
            HOLD means a team must have eligble units inside a zone or it will default back to uncontested. It can be recaptured.
            ONCE means it will start controlled or uncontrolled, depending on starting units, then can only be captured once.
            REPEAT means it will start controlled or uncontrolled, depending on starting units, then can be recaptured.
            */
    false, // Whether to only count players as eligble units
    5 // Interval to check capture zone in seconds
] call FUNC(setCaptureZone);
