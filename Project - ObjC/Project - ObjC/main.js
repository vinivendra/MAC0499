
function load() {
    
    var earth = sphere.template();
    earth.color = "blue";
    earth.position = [0, 0, 0];
    earth.scale = 1.5;

    var instance = earth.create();
    instance.physics = "static";

    var moon = earth.create();
    moon.color = "black";
    moon.scale = 0.7;
    moon.position = [0, 2, 0];
    moon.physics = "dynamic";

    physics.addContact = {"between": moon,
                          "and": instance}

    btn = Button.create();
}


function contact(left, right, contact) {
    print(left);
}

function button() {
    console.log("botaum");
}