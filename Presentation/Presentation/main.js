var duration = 0.3;
var step = 1;

var title;

var graph;
var pinball;
var pinballBall;

var notebook;
var window1;
var window2;
var window3;
var window4;
var window5;
var window6;
var window7;
var window8;
var window9;

function tap() {
    next();
}


function load() {

    TriggerManager.addActionForTrigger(tap, {"gesture": "tap"});

    Physics.gravity = [0, -4, -10];

    title = TitleSquare.create();
    title.scale = 3;
    title.opacity = 0;

    graph = Graph3D.create();
    graph.hidden = true;
    graph.scale = 0.7
    graph.position = [-2.5, -0.5, 1];
    graph.rotation = [0, 1, 0, 0];
    graph.anchor = [1, 1, 1];

    window1 = WideWindowMedium.create();
    window1.hidden = true;
    window1.position = [-4.8, 3.3, 0];
    window1.scale = 3;
    window2 = WideWindowLight.create();
    window2.position = [0, 3.3, 0];
    window2.hidden = true;
    window2.scale = 3;
    window3 = WideWindowDark.create();
    window3.position = [4.8, 3.3, 0];
    window3.hidden = true;
    window3.scale = 3;
    window4 = WideWindowLight.create();
    window4.position = [-4.8, 0, 0];
    window4.hidden = true;
    window4.scale = 3;
    window5 = WideWindowYellow.create();
    window5.position = [0, 0, 0];
    window5.hidden = true;
    window5.scale = 3;
    window6 = WideWindowMedium.create();
    window6.position = [4.8, 0, 0];
    window6.hidden = true;
    window6.scale = 3;
    window7 = WideWindowDark.create();
    window7.position = [-4.8, -3.3, 0];
    window7.hidden = true;
    window7.scale = 3;
    window8 = WideWindowMedium.create();
    window8.position = [0, -3.3, 0];
    window8.hidden = true;
    window8.scale = 3;
    window9 = WideWindowLight.create();
    window9.position = [4.8, -3.3, 0];
    window9.hidden = true;
    window9.scale = 3;
}

function next() {
    if (step == 1) {
        appear(title);
    }
    else if (step == 2) {
        disappear(title);

        bounceScale(graph);
        rotate(graph, 0.03);

        pinball = Pinball.create();
        pinball.position = [6, -0.5, -10];
        pinball.hidden = true;

        pinballBall = PinballBall.create();
        pinballBall.position = [7.2, 6, -8.5];

        appear(pinball);
    }
    else if (step == 3) {
        disappear(graph);
        disappear(pinball);
        disappear(pinballBall);

        bounceScale(window1);
        setTimeout(bounceWindow2, duration * 700);
        setTimeout(bounceWindow3, duration * 2 * 700);
        setTimeout(bounceWindow4, duration * 3 * 700);
        setTimeout(bounceWindow5, duration * 4 * 700);
        setTimeout(bounceWindow6, duration * 5 * 700);
        setTimeout(bounceWindow7, duration * 6 * 700);
        setTimeout(bounceWindow8, duration * 7 * 700);
        setTimeout(bounceWindow9, duration * 8 * 700);
    }
    else if (step == 4) {
        graph.hidden = true;
        pinball.delete();
        pinballBall.delete();

        halfFade(window1);
        halfFade(window2);
        halfFade(window3);
        halfFade(window4);
        halfFade(window6);
        halfFade(window7);
        halfFade(window8);
        halfFade(window9);

        var newPosition = Camera.position.z - 6;
        Camera.addAnimation({"keyPath": "position.z",
                            "toValue": 4,
                            "function": "easeInOut",
                            "duration": duration});
        setTimeout(moveCamera1, duration * 0.9 * 1000);
    }

    step++;
}

function appear(item) {
    item.addAnimation({"keyPath": "opacity",
                      "fromValue": 0,
                      "toValue": 1,
                      "duration": duration});
    item.hidden = false;
    item.opacity = 1;
}

function disappear(item) {
    item.addAnimation({"keyPath": "opacity",
                      "fromValue": 1,
                      "toValue": 0,
                      "duration": duration});
    item.opacity = 0;
}

function bounceScale(item) {
    appear(item);

    var scalex = item.scale.x;
    var scaley = item.scale.y;
    var scalez = item.scale.z;


    item.addAnimation({"keyPath": "scale.x",
                      "fromValue": scalex/2,
                      "toValue": scalex,
                      "function": "bounce",
                      "duration": duration});
    item.addAnimation({"keyPath": "scale.y",
                      "fromValue": scaley/2,
                      "toValue": scaley,
                      "function": "bounce",
                      "duration": duration});
    item.addAnimation({"keyPath": "scale.z",
                      "fromValue": scalez/2,
                      "toValue": scalez,
                      "function": "bounce",
                      "duration": duration});
}

function rotate(item, speed) {
    item.addAnimation({"keyPath": "rotation.w",
                      "fromValue": 0,
                      "toValue": 2 * pi,
                      "function": "linear",
                      "duration": duration / speed});
}

function halfFade(item) {
    var alpha = 0.3;

    item.addAnimation({"keyPath": "opacity",
                      "toValue": alpha,
                      "duration": duration});
    item.opacity = alpha;
}


////////////////////////////////////////////////////////////////////////////////
function bounceWindow2() {
    bounceScale(window2);
}

function bounceWindow3() {
    bounceScale(window3);
}

function bounceWindow4() {
    bounceScale(window4);
}

function bounceWindow5() {
    bounceScale(window5);
}

function bounceWindow6() {
    bounceScale(window6);
}

function bounceWindow7() {
    bounceScale(window7);
}

function bounceWindow8() {
    bounceScale(window8);
}

function bounceWindow9() {
    bounceScale(window9);
}

function moveCamera1() {
    Camera.position = [0, 0, 4];
}