
var btn;
var moon;

function load() {
    
    var earth = sphere.template();
    earth.color = "blue";
    earth.position = [0, 0, 0];
    earth.scale = 1.5;

    var instance = earth.create();
    instance.physics = "static";

    moon = earth.create();
    moon.color = "darkGray";
    moon.scale = 0.7;
    moon.position = [0, 2, 0];
    moon.physics = "dynamic";

    physics.addContact = {"between": moon,
                          "and": instance}

    btn = Button.create();
    btn.position = [300, 200];
    btn.size = [100, 100];
    btn.string = "JUMP!";
}


function contact(left, right, contact) {

}

function button(pressedButton) {
    if (pressedButton == btn) {
        moon.velocity = [0, 5, 0];
    }
    else {
        console.log("outro botaum.");
    }
}