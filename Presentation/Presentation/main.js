
function load() {

    var item = Box.create();
    item.color = "blue";
    item.scale = 2;
    item.rotation = [1, 1, 0, 0];

    var dictionary = {"keyPath": "rotation.w",
                      "toValue": 2 * pi,
                      "duration": 3,
                      "repeatCount": 1000};
    item.addAnimation(dictionary);

    dictionary = {"keyPath": "position.x",
                  "toValue": 1,
                  "duration": 1,
                  "repeatCount": 1000,
                  "autoreverses": true};
    item.addAnimation(dictionary);
}

