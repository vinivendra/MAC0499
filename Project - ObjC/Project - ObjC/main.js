
function load() {

    var bola = sphere.create();
    bola.color = "red";
    bola.physics = "dynamic";
    
    var piramide = pyramid.create();
    piramide.position = [-.5, -3, 0];
    piramide.scale = 2;
    piramide.color = "orange";
    piramide.physics = "static";
    
    physics.addContact = [bola, piramide];
    
    physics.addContact = { "between": bola,
        "and": piramide };
}

function update(dt) {
    
}

function contact(obj, outro) {
    obj.destroy();
    outro.destroy();
}


