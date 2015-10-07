

function load() {
    Physics.gravity = [0, 0, -3];
    Physics.speed = 0;

    if (typeof sceneFilename != 'undefined') {
        Parser.parseFile(sceneFilename);
    }
    else {
        loadStandardLights();
    }


// To call a method with a fixed value as an argument
//    TriggerManager.addActionForTrigger("rotate",      // Method name
//                                       {"item": terra,// Item that triggers the call
//                                        "argument": [0, 0, 1, 0.1], // Fixed value as an argument
//                                        "gesture": "rotate"});
//
//        TriggerManager.addActionForTrigger(movementForRotation, {"item": "Terra", "action": "rotate", "gesture": "rotate"});

    TriggerManager.addActionForTrigger(trackballAction, {"gesture": "pan"});
    TriggerManager.addActionForTrigger(handleScale, {"gesture": "pinch"});
    TriggerManager.addActionForTrigger(sceneTranslationAction, {"gesture": "pan", "touches": "2"});
    TriggerManager.addActionForTrigger(handleTap, {"gesture": "tap"});
    TriggerManager.addActionForTrigger(itemTranslationActionSnappedToAxes, {"gesture": "longpress"});
    TriggerManager.addActionForTrigger(handleRotation, {"gesture": "rotate"});
}

function movementForRotation(items, angle) {
    return Rotation.create([0, 0, 1, angle]);
}

function handleScale(items, scale) {
    if (items.length > 1) {
        itemScaleAction(items, scale);
    }
    else {
        zoomCameraAction(items, scale);
    }
}

function handleRotation(items, angle) {
    if (items.length > 1) {
        itemRotationAction(items, angle);
    }
    else {
        sceneRotationAction(items, angle);
    }
}

var selectedItem;
var previousCameraPosition;
var previousCameraRotation;

function handleTap(items, hits) {
    if (typeof items[0] != 'undefined' && selectedItem != items[0]) {
        if (typeof selectedItem != 'undefined') {
            deselectItem();
        }
        selectItem(items[0]);
        zoomCameraToItem(items[0]);
    }
    else {
        deselectItem();
        replaceCamera();
    }
}

function deselectItem() {
    selectedItem.selected = false;
    selectedItem = undefined;
}

function selectItem(item) {
    selectedItem = item;
    selectedItem.selected = true;
}

function zoomCameraToItem(item) {
    previousCameraPosition = Camera.position;
    previousCameraRotation = Camera.rotation;

    updateCameraAxes();
    var distance = cameraZ.normalize().times(5);
    var newPosition = item.position.plus(distance);
    Camera.position = newPosition;
}

function replaceCamera() {
    Camera.position = previousCameraPosition;
    Camera.rotation = previousCameraRotation;
}
