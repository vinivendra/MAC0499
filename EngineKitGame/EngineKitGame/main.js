

function load() {
    Parser.parseFile("scene.fmt");

    loadStandardLights();

    TriggerManager.addActionForTrigger(itemTranslationAction, {"gesture": "longpress"});
    TriggerManager.addActionForTrigger(trackballAction, {"gesture": "pan"});
    TriggerManager.addActionForTrigger(sceneTranslationAction, {"gesture": "pan",
                                                                "touches": 2});
    TriggerManager.addActionForTrigger(itemScaleAction, {"gesture": "pinch"});
    TriggerManager.addActionForTrigger(handleRotation, {"gesture": "rotate"});


    Physics.gravity = [0, 0, -3];
}

function handleRotation(items, angle) {
    if (items.length > 1) {
        itemRotationAction(items, angle);
    }
    else {
        sceneRotationAction(items, angle);
    }
}



