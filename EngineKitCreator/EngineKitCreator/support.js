
function loadStandardLights() {
    var myLight = Light.create();
    myLight.color = [1.0, 1.0];
    myLight.position = [3, 3, 3];

    myLight = Light.create();
    myLight.color = [0.7, 1.0];
    myLight.position = [-3, -3, -3];

    myLight = Light.create();
    myLight.color = [0.4, 1.0];
    myLight.type = "ambient";
    myLight.position = [-3, -3, -3];
}

var x = [1, 0, 0];
var y = [0, 1, 0];
var z = [0, 0, 1];

var cameraX = Camera.rotation.rotate(x);
var cameraY = Camera.rotation.rotate(y);
var cameraZ = Camera.rotation.rotate(z);

function updateCameraAxes() {
    cameraX = Camera.rotation.rotate(x);
    cameraY = Camera.rotation.rotate(y);
    cameraZ = Camera.rotation.rotate(z);
}

function trackballAction(items, translation) {
    var resized = translation.times(0.02);

    updateCameraAxes();
    var axis = cameraX.times(resized.y)
    .plus(cameraY.times(-resized.x));

    var rot = Rotation.create([axis, resized.normSquared()]);
    Camera.rotateAround(rot, [0, 0, 0]);
}

function sceneTranslationAction(items, translation) {
    var resized = translation.times(0.01);

    updateCameraAxes();
    var translation = cameraX.times(-resized.x)
    .plus(cameraY.times(-resized.y));

    Camera.position = Camera.position.plus(translation);
}

function itemTranslationAction(items, translation) {
    if (typeof items[0] != 'undefined') {
        var resized = translation.times(0.01);

        updateCameraAxes();
        var translation = cameraX.times(resized.x)
        .plus(cameraY.times(resized.y));

        items[0].position = items[0].position.plus(translation);
    }
}

function itemScaleAction(items, scale) {
    if (typeof items[0] != 'undefined') {
        items[0].scale = items[0].scale.times(scale);
    }
}

function zoomCameraAction(items, scale) {
    updateCameraAxes();
    var translation = cameraZ.times((1 - (scale)) * 5);
    Camera.position = Camera.position.plus(translation);
}

function itemRotationAction(items, angle) {
    if (typeof items[0] != 'undefined') {
        updateCameraAxes();
        items[0].rotate({"axis":cameraZ, "a":angle});
    }
}

function sceneRotationAction(items, angle) {
    updateCameraAxes();
    var rotZ = Rotation.create([cameraZ, -angle]);
    Camera.rotateAround(rotZ, origin);
}





