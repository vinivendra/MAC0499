
function load() {
    Parser.parseFile("scene.fmt");

    TriggerManager.addActionForTrigger(itemTranslationAction, {"gesture": "longpress"});
    TriggerManager.addActionForTrigger(trackballAction, {"gesture": "pan"});
    TriggerManager.addActionForTrigger(sceneTranslationAction, {"gesture": "pan",
                                       "touches": 2});
    TriggerManager.addActionForTrigger(itemScaleAction, {"gesture": "pinch"});
    TriggerManager.addActionForTrigger(handleRotation, {"gesture": "rotate"});
}

function handleRotation(items, angle) {
    if (items.length > 1) {
        itemRotationAction(items, angle);
    }
    else {
        sceneRotationAction(items, angle);
    }
}

