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

var areas;
var objectSymbol;

var text1;
var text2;
var text3;
var text4;
var text5;
var text6;
var text7;
var text8;
var text9;
var text10;
var text11;

var objectSquares;

var iPad;
var file;
var objectSymbol1;
var objectSymbol2;
var objectSymbol3;


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
    window5 = WideWindowMedium.create();
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

    areas = Areas.create();
    areas.scale = 3;
    areas.position = [0, 0, 0.5];

    text1 = areas.childItemWithNameRecursively("text1", true);
    text2 = areas.childItemWithNameRecursively("text2", true);
    text3 = areas.childItemWithNameRecursively("text3", true);
    text4 = areas.childItemWithNameRecursively("text4", true);
    text5 = areas.childItemWithNameRecursively("text5", true);
    text6 = areas.childItemWithNameRecursively("text6", true);
    text7 = areas.childItemWithNameRecursively("text7", true);
    text8 = areas.childItemWithNameRecursively("text8", true);
    text9 = areas.childItemWithNameRecursively("text9", true);
    text10 = areas.childItemWithNameRecursively("text10", true);
    text11 = areas.childItemWithNameRecursively("text11", true);

    text1.hidden = true;
    text2.hidden = true;
    text3.hidden = true;
    text4.hidden = true;
    text5.hidden = true;
    text6.hidden = true;
    text7.hidden = true;
    text8.hidden = true;
    text9.hidden = true;
    text10.hidden = true;
    text11.hidden = true;


    objectSymbol = ObjectSymbol.create();
    objectSymbol.hidden = true;
    objectSymbol.scale = 2;
    objectSymbol.position = [0, -0.05, 0.7];

    objectSquares = [ObjectSquareDark.create(),
                     ObjectSquareDark.create(),
                     ObjectSquareDark.create(),
                     ObjectSquareLight.create(),
                     ObjectSquareLight.create(),
                     ObjectSquareLight.create(),
                     ObjectSquareDark.create(),
                     ObjectSquareDark.create(),
                     ObjectSquareDark.create()];

    for (var i = 0; i < 9; i++) {
        objectSquares[i].position = [(i%3 - 1) * 4.8,
                                     - (Math.floor(i/3)%3 - 1) * 3.3,
                                     0];
        objectSquares[i].hidden = true;
        objectSquares[i].scale = 2;
    }


    file = FileBody.create();
    file.hidden = true;
    file.position = [-6, -0.1, 0];

    iPad = iDevice.create();
    iPad.hidden = true;
    iPad.scale = 2;
    iPad.position = [3.5, 0, 0];
    iPad.rotation = [1, 0, 0, pi / 2];

    objectSymbols = [ObjectSymbol.create(),
                     ObjectSymbol.create(),
                     ObjectSymbol.create()];
    for (var i = 0; i < 3; i++) {
        objectSymbols[i].hidden = true;
        objectSymbols[i].scale = 2;
    }

    objectSymbolX = [1, -1, -1];
    objectSymbolY = [0, -1.3, 1.3];
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

        var delay = 700;

        bounceScale(window1);
        setTimeout(bounceScale, duration * delay, window2);
        setTimeout(bounceScale, duration * 2 * delay, window3);
        setTimeout(bounceScale, duration * 3 * delay, window4);
        setTimeout(bounceScale, duration * 4 * delay, window5);
        setTimeout(bounceScale, duration * 5 * delay, window6);
        setTimeout(bounceScale, duration * 6 * delay, window7);
        setTimeout(bounceScale, duration * 7 * delay, window8);
        setTimeout(bounceScale, duration * 8 * delay, window9);
    }
    else if (step == 4) {
        graph.hidden = true;
        pinball.delete();
        pinballBall.delete();

        disappear(window1);
        disappear(window2);
        disappear(window3);
        disappear(window4);
        disappear(window6);
        disappear(window7);
        disappear(window8);
        disappear(window9);

        var newPosition = Camera.position.z - 6;
        Camera.addAnimation({"keyPath": "position.z",
                            "toValue": 4,
                            "function": "easeInOut",
                            "duration": duration});
        setTimeout(moveCamera, duration * 0.9 * 1000, 4);

        bounceScale(objectSymbol);
    }
    else if (step == 5) {
        var delay = 5000;

        window1.hidden = true;
        window2.hidden = true;
        window3.hidden = true;
        window4.hidden = true;
        window5.hidden = true;
        window6.hidden = true;
        window7.hidden = true;
        window8.hidden = true;
        window9.hidden = true;

        bounceScale(text1);
        setTimeout(bounceScale, duration * delay, text2);
        setTimeout(bounceScale, duration * 2 * delay, text3);
        setTimeout(bounceScale, duration * 3 * delay, text4);
        setTimeout(bounceScale, duration * 4 * delay, text5);
        setTimeout(bounceScale, duration * 5 * delay, text6);
        setTimeout(bounceScale, duration * 6 * delay, text7);
        setTimeout(bounceScale, duration * 7 * delay, text8);
        setTimeout(bounceScale, duration * 8 * delay, text9);
        setTimeout(bounceScale, duration * 9 * delay, text10);
        setTimeout(bounceScale, duration * 10 * delay, text11);
    }
    else if (step == 6) {
        disappear(areas);
        disappear(objectSymbol);
        disappear(window5);

        for (var i = 0; i < 9; i++) {
            appear(objectSquares[i]);
        }

        Camera.addAnimation({"keyPath": "position.z",
                            "toValue": 10,
                            "function": "easeInOut",
                            "duration": duration});
        setTimeout(moveCamera, duration * 0.9 * 1000, 10);
    }
    else if (step == 7) {
        disappear(objectSquares[0]);
        disappear(objectSquares[1]);
        disappear(objectSquares[2]);

        disappear(objectSquares[6]);
        disappear(objectSquares[7]);
        disappear(objectSquares[8]);
    }
    else if (step == 8) {
        var delay = 4000;

        disappear(objectSquares[3]);
        setTimeout(disappear, duration * delay, objectSquares[5]);
        setTimeout(disappear, duration * 2 * delay, objectSquares[4]);
    }
    else if (step == 9) {
        title.scale = 2;
        bounceScale(title);

        objectSquares[3].hidden = true;
        objectSquares[4].hidden = true;
        objectSquares[5].hidden = true;
    }
    else if (step == 10) {
        var newScale = 1.7;

        title.addAnimation({"keyPath": "scale.x",
                            "toValue": newScale,
                            "function": "easeInOut",
                            "duration": duration});
        title.addAnimation({"keyPath": "scale.y",
                           "toValue": newScale,
                           "function": "easeInOut",
                           "duration": duration});
        title.addAnimation({"keyPath": "scale.z",
                           "toValue": newScale,
                           "function": "easeInOut",
                           "duration": duration});

        var newPosition = title.position.x - 2.5;

        title.addAnimation({"keyPath": "position.x",
                           "toValue": newPosition,
                           "function": "easeInOut",
                           "duration": duration});
        setTimeout(scaleItem, 0.9 * duration * 1000, [title, newScale]);
        setTimeout(setPositionX, 0.9 * duration * 1000, [title, newPosition]);
    }
    else if (step == 11) {
        appear(file);
        appear(iPad);
    }
    else if (step == 12) {
        var newPosition = -0.2;
        file.addAnimation({"keyPath": "position.z",
                          "toValue": newPosition,
                          "function": "bounce",
                          "duration": duration});
        setTimeout(setPositionZ, 0.9 * duration * 1000, [file, newPosition]);

        setTimeout(moveFile, 0.9 * duration * 1000, []);
    }

    step++;
}

////////////////////////////////////////////////////////////////////////////////

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



function moveCamera(newZ) {
    Camera.position = [0, 0, newZ];
}

function scaleItem(array) {
    array[0].scale = array[1];
}

function setPositionX(array) {
    var x = array[1];
    var y = array[0].position.y;
    var z = array[0].position.z;
    array[0].position = [x, y, z];
}


function setPositionY(array) {
    var x = array[0].position.x;
    var y = array[1];
    var z = array[0].position.z;
    array[0].position = [x, y, z];
}

function setPositionZ(array) {
    var x = array[0].position.x;
    var y = array[0].position.y;
    var z = array[1];
    array[0].position = [x, y, z];
}

var objectSymbolCounter = 0;

function appearFile() {

    if (objectSymbolCounter != 3) {
        file.position = [-6, -0.1, 0];
        file.hidden = true;
        appear(file);

        setTimeout(moveFile, 0.9 * duration * 1000, []);
    }
}

function moveFile() {
    var newPosition = -0.2;
    file.addAnimation({"keyPath": "position.z",
                      "toValue": newPosition,
                      "function": "bounce",
                      "duration": duration});
    setTimeout(setPositionZ, 0.9 * duration * 1000, [file, newPosition]);

    setTimeout(moveFileAgain, 0.9 * duration * 1000, []);
}

function moveFileAgain() {
    var newPosition = -2.5;
    file.addAnimation({"keyPath": "position.x",
                      "toValue": newPosition,
                      "function": "bounce",
                      "duration": duration});
    setTimeout(setPositionX, 0.9 * duration * 1000, [file, newPosition]);

    setTimeout(moveObjectSymbol, 0.5 * duration * 1000, []);
}

function moveObjectSymbol() {

    var objectSymbol = objectSymbols[objectSymbolCounter];

    objectSymbol.hidden = false;
    objectSymbol.position = [-3, 0, -0.5];

    var newPosition = iPad.position.x + objectSymbolX[objectSymbolCounter];
    objectSymbol.addAnimation({"keyPath": "position.x",
                               "toValue": newPosition,
                               "function": "easeOut",
                               "duration": duration});
    setTimeout(setPositionX, 0.9 * duration * 1000, [objectSymbol, newPosition]);

    newPosition = iPad.position.y + objectSymbolY[objectSymbolCounter];
    objectSymbol.addAnimation({"keyPath": "position.y",
                              "toValue": newPosition,
                              "function": "easeOut",
                              "duration": duration});
    setTimeout(setPositionY, 0.9 * duration * 1000, [objectSymbol, newPosition]);

    setTimeout(moveObjectSymbolAgain, 0.9 * duration * 1000, []);
}

function moveObjectSymbolAgain() {

    var objectSymbol = objectSymbols[objectSymbolCounter];

    newPosition = 0.3;
    objectSymbol.addAnimation({"keyPath": "position.z",
                               "toValue": newPosition,
                               "function": "easeOut",
                               "duration": duration});
    setTimeout(setPositionZ, 0.9 * duration * 1000, [objectSymbol, newPosition]);

    setTimeout(appearFile, 0.9 * duration * 1000, []);

    objectSymbolCounter++;
}



