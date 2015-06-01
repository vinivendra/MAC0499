
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

    loadSliders();
    loadLabels();
}

function update() {

}

var btn;
function loadButtons() {
    btn = UIButton.create();
    btn.position = [300, 200];
    btn.size = [100, 100];
    btn.string = "JUMP!";
}

var sliderPosition;
var sliderScale;
function loadSliders() {
    sliderPosition = UISlider.create();
    sliderPosition.position = [50, 300];
    sliderPosition.size = [200, 50];
    sliderPosition.maximumValue = 1;
    sliderPosition.minimumValue = -1;

    sliderScale = UISlider.create();
    sliderScale.position = [50, 400];
    sliderScale.size = [200, 50];
    sliderScale.maximumValue = 2;
    sliderScale.minimumValue = 0;
}

var labelPositionMax;
var labelPositionMin;
var labelScaleMax;
var labelScaleMin;

function loadLabels() {
    labelPositionMax = UILabel.create();
    labelPositionMin = UILabel.create();
    labelScaleMax = UILabel.create();
    labelScaleMin = UILabel.create();

    loadSliderLabels(sliderPosition, labelPositionMax, labelPositionMin);
    loadSliderLabels(sliderScale, labelScaleMax, labelScaleMin);
}

function loadSliderLabels(slider, labelMax, labelMin) {
    labelMin.position = [slider.position.x, slider.position.y + 20];
    labelMin.size = [slider.size.x / 2, 50];
    labelMin.text = slider.maximumValue.toFixed(2);

    labelMax.position = [slider.position.x + slider.size.x / 2,
                         slider.position.y + 20];
    labelMax.size = [slider.size.x / 2, 50];
    labelMax.text = slider.minimumValue.toFixed(2);
    labelMax.alignment = alignmentRight;
}

function updateSlider(slider, minValue, maxValue, value, labelMax, labelMin) {
    print(minValue);
    print(maxValue);

    slider.minimumValue = minValue;
    slider.maximumValue = maxValue;
    slider.value = value;
    labelMax.text = slider.maximumValue.toFixed(2);
    labelMin.text = slider.minimumValue.toFixed(2);
}

function selectItem(item) {

    if (typeof selectedItem != 'undefined') {
        var positionX = selectedItem.position.x;
        var scale = selectedItem.scale.x;
        var minScale;
        if (scale <= 1) minScale = 0;

        updateSlider(sliderPosition,
                     positionX - 1, positionX + 1, positionX,
                     labelPositionMax, labelPositionMin);
        updateSlider(sliderScale,
                     minScale, scale + 1, scale,
                     labelScaleMax, labelScaleMin);
    }
}


function slider(slider) {
    if (typeof selectedItem != 'undefined') {
        if (slider == sliderPosition) {
            var position = selectedItem.position;
            var newPosition = position.setNewX(slider.value);
            selectedItem.position = newPosition;
        }
        else if (slider == sliderScale) {
            var newScale = new vector(sliderScale.value);
            selectedItem.scale = newScale;
        }
    }
}

function tap(items, hits) {
    if (typeof selectedItem != 'undefined') {
        selectedItem.materials = previousMaterials;
    }

    if (typeof items[0] != 'undefined') {
        selectedItem = items[0];
        previousMaterials = selectedItem.materials;
        selectedItem.color = "red";
        selectItem(selectItem);
    }
}

function swipe(direction, items, swipes) {
    var item = items[0];

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

function pan(translation, items) {
    var instance = items[0];

    var resized = translation.times(0.01);
    var newPosition = resized.translate(instance.position);
    instance.position = newPosition;
}

function pinch(scale, items) {
    var instance = items[0];
    print(instance.scale);
    instance.scale = instance.scale.times(scale);
    print(instance.scale);
}

function rotate(angle, items) {
    var instance = items[0];
    instance.rotate({"0":0, "1":0, "2":1, "a":angle});
}

function longPress(translation, items) {
    var instance = items[0];
    instance.position = instance.position.plus(translation.times(0.02));
}

function contact(left, right, contact) {

}

function button(pressedButton) {
    if (pressedButton == btn) {
        console.log("esse botaum.");
//        moon.velocity = [0, 5, 0];
    }
    else {
        console.log("outro botaum.");
    }
}

