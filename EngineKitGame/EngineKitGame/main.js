
var btn;
var moon;
var instance;

function load() {
    
    var earth = sphere.template();
    earth.color = "blue";
    earth.position = [0, 0, -2];
    earth.radius = 1.5;

    instance = earth.create();

    moon = earth.create();
    moon.color = "darkGray";
    moon.scale = 0.7;
    moon.position = [0, 3, 0];

    instance.addItem(moon);

//    btn = UIButton.create();
//    btn.position = [300, 200];
//    btn.size = [100, 100];
//    btn.string = "JUMP!";
//
//    sli = UISlider.create();
//    print(sli);
//    print(UISlider);
//    sli.position = [50, 300];
//    sli.size = [200, 50];
//    sli.maximumValue = 50;
//    sli.minimumValue = -10;
}

function tap(items, hits) {
    print(items);
    print(hits);

    items[0].scale = items[0].scale.times(1.1);
}

function swipe(direction, items, swipes) {
    print(direction);
    print(items);
    print(swipes);
}

function pan(translation) {
    print(translation);
    var resized = translation.times(0.02);
    var newPosition = resized.translate(instance.position);
    instance.position = newPosition;
}

function pinch(scale) {
    print(scale);
    instance.radius = instance.radius * scale;
}

function rotate(angle) {
    print(angle);
    instance.rotate([0, 0, 1, angle]);
}

function longPress(translation) {
    print(translation);
    instance.position = instance.position.plus(translation.times(0.02));
}

function contact(left, right, contact) {

}

//function button(pressedButton) {
//    if (pressedButton == btn) {
//        moon.velocity = [0, 5, 0];
//    }
//    else {
//        console.log("outro botaum.");
//    }
//}
//
//function slider(slider) {
//    print(slider.value);
//}