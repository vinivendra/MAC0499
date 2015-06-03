
var selectedItem;
var previousMaterials;

function load() {

    var earth = sphere.template();
    earth.color = "blue";
    earth.position = [0, 0, -2];
    earth.radius = 1;

    var moon = earth.create();
    moon.color = "dark gray";
    moon.radius = 0.4;
    moon.position = [0, 2, 0];

    var satelite = new box();
    satelite.color = "light gray";
    satelite.scale = 0.2;
    satelite.position = [0.7, 0, 0];

    var spaaace = new box();
    spaaace.color = [0.6, 0.6, 1];
    spaaace.scale = 0.3;
    spaaace.position = [0, 1, 0];

    earth.addItem(moon);
    moon.addItem(satelite);
    satelite.addItem(spaaace);

    var instance1 = earth.create();
    instance1.position = [-1, 0, 0];
    instance1.name = "left";

    var instance2 = earth.create();
    instance2.position = [ 1, 0, 0];
    instance2.name = "right";
}

function update() {

}

function tap(items, hits, numberOfTouches) {
    if (typeof items[0] != 'undefined' && selectedItem != items[0]) {
        if (typeof selectedItem != 'undefined') {
            selectedItem.materials = previousMaterials;
        }
        selectedItem = items[0];
        previousMaterials = selectedItem.materials;
        selectedItem.color = "red";
    }
    else {
        selectedItem.materials = previousMaterials;
        selectedItem = undefined;
    }
}

function swipe(direction, items, swipes, numberOfTouches) {
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

function pan(translation, items, numberOfTouches) {

    if (numberOfTouches == 1) {
        if (typeof selectedItem != 'undefined') {
            var resized = translation.times(0.01);
            var rot = camera.rotation;

            var xAxis = rot.rotate([1, 0, 0]);
            var yAxis = rot.rotate([0, 1, 0]);
            var translation = xAxis.times(resized.x).plus(yAxis.times(resized.y));

            selectedItem.position = selectedItem.position.plus(translation);
        }
        else {
            var resized = translation.times(0.02);
            var rot = camera.rotation;

            var xAxis = rot.rotate([1, 0, 0]);
            var yAxis = rot.rotate([0, 1, 0]);
            var axis = xAxis.times(resized.y).plus(yAxis.times(-resized.x));

            rot = new rotation([axis, resized.normSquared()]);
            camera.rotateAround(rot, [0, 0, 0]);
        }
    }
    else {
        var resized = translation.times(0.01);
        var rot = camera.rotation;

        var xAxis = rot.rotate([1, 0, 0]);
        var yAxis = rot.rotate([0, 1, 0]);
        var translation = xAxis.times(-resized.x).plus(yAxis.times(-resized.y));

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
        var rot = camera.rotation;
        var zAxis = rot.rotate([0, 0, 1]);
        var rotZ = new rotation([zAxis, -angle]);
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

