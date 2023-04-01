// Global Map Marker Array
class AOs {
    class area1 {
        isCentered = true;
        zoomLevel = 0.4;
        name = "Strelka";
        backgroundColour = "BH_checkLOS_colorNotVisible";
        condition = "true";
    };
    class area2: area1 {
        zoomLevel = 0.4;
        name = "Airfield";
        condition = "missionNamespace getVariable ['OBJ1_CLEARED', false]";
    };
};

// team AO settings
class west {
    defaultArea = "area1";
    areas[] = {"area1", "area2"};
};
class east {
    defaultArea = "area1";
    areas[] = {"area1"};
};
class independent {
    defaultArea = "area1";
    areas[] = {"area1"};
};
class civilian {
    defaultArea = "area1";
    areas[] = {"area1"};
};
