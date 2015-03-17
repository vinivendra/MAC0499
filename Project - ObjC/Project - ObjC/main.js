console.log("console.log!");
print("print!");

function load() {
    print("load!!");
}

function update(dt) {
    print("update: " + dt);
}

var ball = sphere.create();
ball.color = [0.5, 0.2, 0.3];
ball.position = [0.2, 0.3, -0.3];
