
function load() {

    var item = Box.create();
    item.color = "blue";
    item.scale = 2;
    item.rotation = [1, 1, 0, 0];

    var animation = Animation.animationWithKeyPath("rotation.w");
    print(animation);

    animation.toValue = 2 * pi;
    animation.duration = 3;
    animation.repeatCount = 1000;

    item.addAnimation(animation);


    animation = Animation.animationWithKeyPath("position.x");
    print(animation);

    animation.toValue = 1;
    animation.duration = 1;
    animation.repeatCount = 1000;
    animation.autoreverses = true;

    item.addAnimation(animation);
}

