
function load() {
    
}

function update(dt) {
    
}

var bola = sphere.create();
    bola.color = "red";
    bola.physics = "dynamic";

var piramide = pyramid.create();
    piramide.position = [-1, -6, 0];
    piramide.scale = 4;
    piramide.color = "blue";
    piramide.physics = "static";

physics.gravity = [0, 1, 0];