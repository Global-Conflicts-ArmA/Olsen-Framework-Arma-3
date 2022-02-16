viewDistance = 2500; //View distance for the server (the ai's)

timeLimit = 30; //Time limit in minutes, to disable the time limit set it to 0
timeLimitMessage = "TIME LIMIT REACHED!"; //The message displayed when the time runs out
endConditionFrequency = 60; // Frequency in seconds that the end conditions are checked

/*
Time for how long disconnected players should be deleted since mission start (in minutes)
Set this to 0 or a negative number to disable behaviour
*/
disconnectBodyCleanupTime = 2;

class Teams {
    class west {
        name = "USMC";
        type = "player"
        /*
            Respawn tickets per side. Total number of respawns that a side can have during a mission.
            Set to -1 for unlimited team respawns, so respawns will only be limited by the individual respawnTickets
            in clientSettings. Setting both to a finite number will act as a dual ticket system, so individuals will
            use their individual respawnTickets as well as their team tickets until one of them reaches 0.
        */
        respawnTickets = -1;
        // How many players have to respawn before wave is released
        waveSize = 0;
        /*
            Players should be put in enclosed space, when their number reaches treshold, the defined "gate" will disappear for 30 seconds
            it has to be defined for wave respawn to work
        */
        respawnPenGate[] = {};
        disconnectBodyCleanUp = true;
    };
    class east {
        name = "VDV";
        type = "ai";
        respawnTickets = -1;
        waveSize = 0;
        respawnPenGate[] = {};
        disconnectBodyCleanUp = true;
    };
    class independent {
        name = "Local Militia";
        type = "ai";
        respawnTickets = -1;
        waveSize = 0;
        respawnPenGate[] = {};
        disconnectBodyCleanUp = true;
    };
    class civilian {
        name = "Local Civilians";
        type = "ai";
        respawnTickets = -1;
        waveSize = 0;
        respawnPenGate[] = {};
        disconnectBodyCleanUp = true;
    };
};
