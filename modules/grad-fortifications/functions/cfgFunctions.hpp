class COMPONENT {
    class collision {
        file = "modules\grad-fortifications\functions\collision";

        class checkCollisionPFH {};
        class getBoundingLines {};
        class getGroundLines {};
        class getVisualLines {};
        class isColliding {};
        class isOnGround {};
        class linesToWorld {};
        class shrinkLines {};
    };

    class common {
        file = "modules\grad-fortifications\functions\common";

        class addFort {};
        class addVehicleInteractions {};
        class allowDemolition {};
        class allowPackUp {};
        class canTake {};
        class doAnimation {};
        class getDisplayName {};
        class getObjectSize {};
        class getVehicleInventorySize {};
        class initSettings {};
        class isOwner {};
        class isVehicle {};
        class removeFort {};
        class setBuildTimeFactor {};
        class setCollisionDebugMode {};
        class setDemolishTimeFactor {};
        class setPackUpTimeFactor {};
        class stopAnimation {};
        class storageAction {};
        class getConfigValue {};
    };

    class drop {
        file = "modules\grad-fortifications\functions\drop";

        class dropFort {};
        class initDropCrate {};
        class requestInteractionServer {};
        class respondInteractionClient {};
    };


    class place {
        file = "modules\grad-fortifications\functions\place";

        class addKeyEHs {};
        class addMouseEHs {};
        class addUpdatePFH {};
        class cancelPlacement {};
        class demolish {};
        class initFort {};
        class packUp {};
        class placeFortification {};
        class removeAllEHs {};
        class setDirection {};
        class setPosition {};
        class setUp {};
        class spawnFortification {};
        class startPlacement {};
    };

    class ui {
        file = "modules\grad-fortifications\functions\ui";

        class doBuild {};
        class doDrop {};
        class doTake {};
        class loadFortDialog {};
        class loadVehicleDialog {};
        class onSelChanged {};
        class openHint {};
        class rotateModel {};
        class updateButtons {};
        class updateHint {};
        class updateItemList {};
        class updateListTitles {};
        class updateModel {};
    };

    class vehicle {
        file = "modules\grad-fortifications\functions\vehicle";

        class requestStoreTake {};
        class respondStoreTake {};
    };
};
