
function loadStandardLights() {
    var myLight = light.create();
    myLight.color = [1.0, 1.0];
    myLight.position = [3, 3, 3];

    myLight = light.create();
    myLight.color = [0.7, 1.0];
    myLight.position = [-3, -3, -3];

    myLight = light.create();
    myLight.color = [0.4, 1.0];
    myLight.type = "ambient";
    myLight.position = [-3, -3, -3];
}

var x = [1, 0, 0];
var y = [0, 1, 0];
var z = [0, 0, 1];

var cameraX = camera.rotation.rotate(x);
var cameraY = camera.rotation.rotate(y);
var cameraZ = camera.rotation.rotate(z);

function trackballPan(items, translation) {
    cameraX = camera.rotation.rotate(x);
    cameraY = camera.rotation.rotate(y);

    var resized = translation.times(0.02);

    var axis = cameraX.times(resized.y)
    .plus(cameraY.times(-resized.x));

    var rot = rotation.create([axis, resized.normSquared()]);
    camera.rotateAround(rot, [0, 0, 0]);
}

