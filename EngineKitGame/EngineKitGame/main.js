

function load() {
    Parser.parseFile("scene.fmt");

    loadStandardLights();

    TriggerManager.addActionForTrigger(handlePan, {"gesture": "pan"});
    TriggerManager.addActionForTrigger(sceneTranslationAction, {"gesture": "pan",
                                                                "touches": 2});
    TriggerManager.addActionForTrigger(itemScaleAction, {"gesture": "pinch"});
    TriggerManager.addActionForTrigger(itemRotationAction, {"gesture": "rotate"});


    Physics.gravity = [0, 0, -3];
}

function handlePan(items, translation) {
    if (items.length > 1) {
        itemTranslationAction(items, translation);;
    }
    else {
        trackballAction(items, translation)
    }
}


