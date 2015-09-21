
var selectedItem;

function load() {

    //    var earth = sphere.template();
    //    earth.color = "blue";
    //    earth.position = [0, 0, -2];
    //    earth.radius = 1;
    //
    //    var moon = sphere.template();
    //    moon.color = "dark gray";
    //    moon.radius = 0.4;
    //    moon.position = [0, 2, 0];
    //
    //    var satelite = box.template();
    //    satelite.color = "light gray";
    //    satelite.scale = 0.2;
    //    satelite.position = [0.7, 0, 0];
    //
    //    var spaaace = box.template();
    //    spaaace.color = [0.6, 0.6, 1];
    //    spaaace.scale = 0.3;
    //    spaaace.position = [0, 1, 0];
    //
    //    var sateliteInstance = satelite.create();
    //    var spaceInstance = spaaace.create();
    //    var moonInstance = moon.create();
    //
    //    sateliteInstance.addItem(spaceInstance);
    //    moonInstance.addItem(sateliteInstance);
    //    earth.addItem(moonInstance);
    //
    //    var instance1 = earth.create();
    //    instance1.position = [-1, 0, 0];
    //    instance1.name = "left";
    //
    //    var instance2 = earth.create();
    //    instance2.position = [ 1, 0, 0];
    //    instance2.name = "right";

    var light1 = light.create();
    light1.color = [1.0, 1.0];
    light1.position = [3, 3, 3];

    light1 = light.create();
    light1.color = [0.7, 1.0];
    light1.position = [-3, -3, -3];

    light1 = light.create();
    light1.color = [0.4, 1.0];
    light1.type = "ambient";
    light1.position = [-3, -3, -3];
    
    parser.parseFile("scene.fmt");
}

function update() {

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

function swipe(direction, items, numberOfTouches, hits) {
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

function pan(translation, items, numberOfTouches) {

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

function pinch(scale, items, numberOfTouches) {
    var instance = items[0];

    if (typeof instance != 'undefined') {
        instance.scale = instance.scale.times(scale);
    }
    else {
        
    }
}

function rotate(angle, items, numberOfTouches) {

    if (typeof selectedItem != 'undefined') {
        selectedItem.rotate({"0":0, "1":0, "2":1, "a":angle});
    }
    else {
        cameraZ = camera.rotation.rotate(z);
        var rotZ = rotation.create([cameraZ, -angle]);
        camera.rotateAround(rotZ, [0, 0, 0]);
    }
}

function longPress(translation, items, numberOfTouches) {
    
    var instance = items[0];
    
    if (typeof instance != 'undefined') {
        instance.position = instance.position.plus(translation.times(0.02));
    }
}

function contact(left, right, contact) {
    
}

