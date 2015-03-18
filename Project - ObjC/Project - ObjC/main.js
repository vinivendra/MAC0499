console.log("console.log!");
print("print!");

function load() {
    print("load!!");
}

function update(dt) {
    print("update: " + dt);
}

var item = cylinder.create();
item.color = [0.5, 0.2, 0.3];
item.position = [0.2, 0.3, -0.3];
item.rotation = [0.2, 0.3, 0.4, pi/2];
