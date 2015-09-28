
var selectedItem;

function load() {
    loadStandardLights();
    
    parser.parseFile("scene.fmt");
}

function loadStandardLights() {
    var light = light.create();
    light.color = [1.0, 1.0];
    light.position = [3, 3, 3];

    light = light.create();
    light.color = [0.7, 1.0];
    light.position = [-3, -3, -3];

    light = light.create();
    light.color = [0.4, 1.0];
    light.type = "ambient";
    light.position = [-3, -3, -3];
}

function tap(items, numberOfTouches, hits) {
    if (typeof items[0] != 'undefined' && selectedItem != items[0]) {
        if (typeof selectedItem != 'undefined') {
            selectedItem.selected = false;
        }
        selectedItem = items[0];
        selectedItem.selected = true;
    }
    else {
        selectedItem.selected = false;
        selectedItem = undefined;
    }
}

function swipe(items, direction, numberOfTouches, hits) {
    var item = items[0];

    if (typeof item != 'undefined') {
        var dict = {"0": 0, "Y": 1, "z": 0};

        if (direction == up) {
            item.position = item.position.plus(new vector(dict));
        }
        else if (direction == down) {
            item.position = item.position.plus(new vector([0, -1, 0]));
        }
        else if (direction == left) {
            item.position = item.position.plus(new vector([-1, 0, 0]));
        }
        else if (direction == right) {
            item.position = item.position.plus(new vector([1, 0, 0]));
        }
    }
}

var x = [1, 0, 0];
var y = [0, 1, 0];
var z = [0, 0, 1];

var cameraX = camera.rotation.rotate(x);
var cameraY = camera.rotation.rotate(y);
var cameraZ = camera.rotation.rotate(z);

function pan(items, translation, numberOfTouches) {

    if (numberOfTouches == 1) {
        if (typeof selectedItem != 'undefined') {
            var resized = translation.times(0.01);

            var translation = cameraX.times(resized.x)
            .plus(cameraY.times(resized.y));

            selectedItem.position = selectedItem.position.plus(translation);
        }
        else {
            cameraX = camera.rotation.rotate(x);
            cameraY = camera.rotation.rotate(y);

            var resized = translation.times(0.02);

            var axis = cameraX.times(resized.y)
            .plus(cameraY.times(-resized.x));

            var rot = rotation.create([axis, resized.normSquared()]);
            camera.rotateAround(rot, [0, 0, 0]);
        }
    }
    else {
        var resized = translation.times(0.01);

        var translation = cameraX.times(-resized.x)
        .plus(cameraY.times(-resized.y));

        camera.position = camera.position.plus(translation);
    }
}

function pinch(items, scale, numberOfTouches) {
    var instance = items[0];

    if (typeof instance != 'undefined') {
        instance.scale = instance.scale.times(scale);
    }
    else {
        
    }
}

function rotate(items, angle, numberOfTouches) {

    if (typeof selectedItem != 'undefined') {
        selectedItem.rotate({"0":0, "1":0, "2":1, "a":angle});
    }
    else {
        cameraZ = camera.rotation.rotate(z);
        var rotZ = rotation.create([cameraZ, -angle]);
        camera.rotateAround(rotZ, [0, 0, 0]);
    }
}

function longPress(items, translation, numberOfTouches) {
    
    var instance = items[0];
    
    if (typeof instance != 'undefined') {
        instance.position = instance.position.plus(translation.times(0.02));
    }
}

function contact(left, right, contact) {
    
}

