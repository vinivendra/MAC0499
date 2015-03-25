
function load() {
    
}

function update(dt) {
    
}

var bola = sphere.create();
    bola.color = "red";
    bola.physics = "dynamic";

var piramide = pyramid.create();
    piramide.position = [-.5, -3, 0];
    piramide.scale = 2;
    piramide.color = "orange";
    piramide.physics = "static";

function bolaQuicando(bola, piramide) {
    bola.velocity = [0, 1, 0];
}





physics.contact = [bolaQuicando, bola, piramide];



physics.newContact = { "contact": bolaQuicando,
                       "between": bola,
                           "and": piramide };

