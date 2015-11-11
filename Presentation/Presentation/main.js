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

var file2;
var fileText;
var fileText2;

var iosSquare;
var iosText;

var squares;
var squareItems;

var jsSquare;
var jsText;

function tap() {
    next();
}


function load() {

    TriggerManager.addActionForTrigger(tap, {"gesture": "tap"});

    Physics.gravity = [0, -4, -10];

    title = TitleSquare.create();
    title.hidden = true;
    title.scale = 3;

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
        objectSymbols[i].scale = 3;
    }

    objectSymbolX = [1, -1, -1];
    objectSymbolY = [0, -1.3, 1.3];

    file2 = FileBody.create();
    file2.hidden = true;

    fileText = FileText.create();
    fileText.scale = 0.5;
    fileText.position = [-0.3, -0.1, 0.15];
    fileText.string = "<>";
    fileText.weight = "Bold";
    fileText.depth = 0.1;
    fileText.hidden = true;

    fileText2 = FileText.create();
    fileText2.scale = 0.5;
    fileText2.position = [-0.3, -0.1, 0.15];
    fileText2.string = "{ }";
    fileText2.weight = "Bold";
    fileText2.depth = 0.1;
    fileText2.hidden = true;

    var squareScale = 5.5;
    iosSquare = SquareBackground.create();
    iosSquare.hidden = true;
    iosSquare.scale = squareScale;

    var textScale = 0.6;
    iosText = SquareTitle.create();
    iosText.scale = iosText.scale.times(squareScale * textScale);
    iosText.position = [-0.3 * squareScale * textScale,
                        -0.15 * squareScale * textScale,
                        0.1 * squareScale];
    iosText.string = "iOS";
    iosText.color = [0.08, 0.24, 0.27];
    iosText.hidden = true;

    squares = [SquareBackgroundSmall.create(),
               SquareBackgroundSmall.create(),
               SquareBackgroundSmall.create(),
               SquareBackgroundSmall.create(),
               SquareBackgroundSmall.create(),
               SquareBackgroundSmall.create()];
    var squarePositions = [[-3.5,  1.35],
                           [   0,  1.65],
                           [ 3.5,  1.35],
                           [-3.5, -1.35],
                           [   0, -1.65],
                           [ 3.5, -1.35]];

    var smallSquareScale = 1.1;
    for (var i = 0; i < squares.length; i++) {
        var square = squares[i];
        square.position = [squarePositions[i][0],
                           squarePositions[i][1],
                           iosSquare.position.z + 0.1 * squareScale];
        square.hidden = true;
        square.scale = smallSquareScale;
    }

    squareItems = [ObjectSymbol.create(),
                   PhysicsSymbol.create(),
                   GesturesSymbol.create(),
                   InterfaceSymbol.create(),
                   AnimationSymbol.create(),
                   JavaScriptSymbol.create()];
    for (var i = 0; i < squareItems.length; i++) {
        var item = squareItems[i];
        item.position = [squarePositions[i][0],
                         squarePositions[i][1],
                         squares[i].position.z + 0.1 * smallSquareScale];
        item.hidden = true;
        item.scale = smallSquareScale;
    }
    squareItems[0].scale = smallSquareScale * 1.2;
    squareItems[0].position = [squarePositions[0][0] + 0.1,
                               squarePositions[0][1] - 0.13,
                               squares[0].position.z + 0.2 * smallSquareScale];

    var satellite = squareItems[4].childItemWithNameRecursively("satellite", true);
    satellite.anchor = [0.35, 0, 0];
    satellite.position = [0, 0, 0.2];


    jsSquare = SquareBackgroundDark.create();
    jsSquare.hidden = true;
    jsSquare.scale = squareScale;

    textScale = 0.4;
    jsText = SquareTitle.create();
    jsText.scale = jsText.scale.times(squareScale * textScale);
    jsText.anchor = [0.95 * squareScale * textScale,
                     0.1 * squareScale * textScale,
                     0.0];
    jsText.position = [0, 0, 0.3];
    jsText.string = "JavaScript";
    jsText.color = [0.08, 0.24, 0.27];
    jsText.hidden = true;
}

////////////////////////////////////////////////////////////////////////////////

function next() {
    if (step == 1) { // Fade in title
        appear(title);
    }
    else if (step == 2) { // Fade out title, fade in graph and pinball
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
    else if (step == 3) { // Fade out graph and pinball, fade in windows
        disappear(graph);
        disappear(pinball);
        disappear(pinballBall);

        var delay = 700;

        //        bounceScale(window1);
        //        setTimeout(bounceScale, duration * delay, window2);
        //        setTimeout(bounceScale, duration * 2 * delay, window3);
        //        setTimeout(bounceScale, duration * 3 * delay, window4);
        //        setTimeout(bounceScale, duration * 4 * delay, window5);
        //        setTimeout(bounceScale, duration * 5 * delay, window6);
        //        setTimeout(bounceScale, duration * 6 * delay, window7);
        //        setTimeout(bounceScale, duration * 7 * delay, window8);
        //        setTimeout(bounceScale, duration * 8 * delay, window9);

        bounceScale(window1);
        bounceScale(window2);
        bounceScale(window3);
        bounceScale(window4);
        bounceScale(window5);
        bounceScale(window6);
        bounceScale(window7);
        bounceScale(window8);
        bounceScale(window9);
    }
    else if (step == 4) { // Fade out windows, zoom on center windows
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
    else if (step == 5) { // Fade in features one by one
        var delay = 5000;

        window1.delete();
        window2.delete();
        window3.delete();
        window4.delete();
        window6.delete();
        window7.delete();
        window8.delete();
        window9.delete();

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
    else if (step == 6) { //  Zoom out, fade in engines
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
    else if (step == 7) { // Fade out corner engines
        areas.delete();
        window5.delete();

        disappear(objectSquares[0]);
        disappear(objectSquares[1]);
        disappear(objectSquares[2]);

        disappear(objectSquares[6]);
        disappear(objectSquares[7]);
        disappear(objectSquares[8]);
    }
    else if (step == 8) { // Fade out center engines one by one
        var delay = 4000;

        disappear(objectSquares[3]);
        setTimeout(disappear, duration * delay, objectSquares[5]);
        setTimeout(disappear, duration * 2 * delay, objectSquares[4]);
    }
    else if (step == 9) { // Fade in title
        title.scale = 2;
        bounceScale(title);

        for (var i = 0; i < objectSquares.length; i++) {
            objectSquares[i].delete();
        }
    }
    else if (step == 10) { // Zoom out title
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
    else if (step == 11) { // Appear file and iPad
        appear(file);
        appear(iPad);
    }
    else if (step == 12) { // File turns into objects
        var newPosition = -0.2;
        file.addAnimation({"keyPath": "position.z",
                          "toValue": newPosition,
                          "function": "bounce",
                          "duration": duration});
        setTimeout(setPositionZ, 0.9 * duration * 1000, [file, newPosition]);

        setTimeout(moveFile, 0.9 * duration * 1000, []);
    }
    else if (step == 13) { // File, EK and iPad disappear
        file.hidden = true;
        disappear(title);
        disappear(iPad);
        disappear(objectSymbols[0]);
        disappear(objectSymbols[1]);
        disappear(objectSymbols[2]);
    }
    else if (step == 14) { // File appears
        file.position = [0, 0, 0];
        file.scale = 4;
        file.hidden = true;
        appear(file);
    }
    else if (step == 15) { // File divides into 2
        file2.position = file.position;
        file2.scale = file.scale;
        file2.hidden = false;

        movePositionX(file, -3);
        movePositionX(file2, 3);

        movePositionY(file, -0.3);
        movePositionY(file2, -0.3);
    }
    else if (step == 16) { // Writing appears
        fileText.scale = file.scale.x / 2;
        var x = file.position.x - file.scale.x * 0.3 + 0.1;
        var y = file.position.y - file.scale.y * 0.1;
        var z = file.position.z + file.scale.z * 0.15;
        fileText.position = [x, y, z];
        appear(fileText);
    }
    else if (step == 17) { // Second writing appears
        fileText2.scale = file2.scale.x / 2;
        var x = file2.position.x - file2.scale.x * 0.3 + 0.1;
        var y = file2.position.y - file2.scale.y * 0.1;
        var z = file2.position.z + file2.scale.z * 0.15;
        fileText2.position = [x, y, z];
        appear(fileText2);
    }
    else if (step == 18) { // Focus on {}
        disappear(file);
        disappear(fileText);

        movePositionX(Camera, file2.position.x);
        movePositionZ(Camera, Camera.position.z - 3);
    }
    else if (step == 19) { // Change to JS
        disappear(fileText2);

        setTimeout(changeTextAndAppear, 0.9 * duration * 1000, [fileText2, "JS"]);
    }
    else if (step == 20) { // Zoom back out
        appear(file);
        appear(fileText);

        movePositionX(Camera, 0);
        movePositionZ(Camera, Camera.position.z + 3);
    }
    else if (step == 21) { // Focus on <>
        disappear(file2);
        disappear(fileText2);

        movePositionX(Camera, file.position.x);
        movePositionZ(Camera, Camera.position.z - 3);
    }
    else if (step == 22) { // Fade out on <>
        disappear(fileText);
    }
    else if (step == 23) { // Fade in on object symbol
        var x = fileText.position.x + 1.2;
        var y = fileText.position.y + 0.5;
        var z = fileText.position.z;
        objectSymbol.position = [x, y, z];
        objectSymbol.scale = file.scale;

        appear(objectSymbol);
    }
    else if (step == 24) { // Zoom back out
        appear(file2);
        appear(fileText2);

        movePositionX(Camera, 0);
        movePositionZ(Camera, Camera.position.z + 3);
    }
    else if (step == 25) { // Fade out
        disappear(file);
        disappear(file2);
        disappear(fileText2);
        disappear(objectSymbol);
    }
    else if (step == 26) { // Fade in iOS Square
        appear(iosSquare);
        appear(iosText);
    }
    else if (step == 27) { // Fade in feature squares
        for (var i = 0; i < squares.length; i++) {
            var square = squares[i];
            appear(square);
        }
    }
    else if (step == 28) { // Fade in feature - graphics
        bounceScale(squareItems[0]);
    }
    else if (step == 29) { // Fade in feature - physics
        var item = squareItems[1];
        appear(item);
        var sphere = item.childItemWithNameRecursively("sphere", true);
        setTimeout(animatePhysics, duration * 1000, sphere);
    }
    else if (step == 30) { // Fade in feature - gestures
        var item = squareItems[2];
        appear(item);
        setTimeout(animateGestures, duration * 1000, item);
    }
    else if (step == 31) { // Fade in feature - interface
        var item = squareItems[3];
        appear(item);
        var knob = item.childItemWithNameRecursively("knob", true);
        setTimeout(animateInterface, duration * 1000, knob);
    }
    else if (step == 32) { // Fade in feature - animation
        var item = squareItems[4];
        appear(item);
        var satellite = item.childItemWithNameRecursively("satellite", true);
        setTimeout(animateAnimation, duration * 1000, satellite);
    }
    else if (step == 33) { // Fade in feature - JavaScript
        bounceScale(squareItems[5]);
    }
    else if (step == 34) { // Cross fade: iOS -> JavaScript
        disappear(iosText);
        disappear(iosSquare);

        setTimeout(appear, duration * 2 * 1000, jsSquare);
        setTimeout(bounceScale, duration * 2 * 1000, jsText);
    }
    else if (step == 35) { // Fade out
        disappear(jsText);
        disappear(jsSquare);
        for (var i = 0; i < squares.length; i++) {
            disappear(squares[i]);
            disappear(squareItems[i]);
        }
    }

    else if (step == 36) { // Fade in file, title, iPad
        for (var i = 0; i < squares.length; i++) {
            squares[i].delete();
            squareItems[i].delete();
        }

        jsText.hidden = true;
        jsSquare.hidden = true;

        title.scale = title.scale.times(1.2);

        var y = title.position.y;

        file = FileBody.create();
        file.scale = 1.2;
        file.hidden = true;
        file.position = [-6, y + 1.5, 0];

        file2 = FileBody.create();
        file2.scale = 1.2;
        file2.hidden = true;
        file2.position = [-6, y - 1.5, 0];

        fileText2.scale = file2.scale.times(0.6);
        var x = file2.position.x - file2.scale.x * 0.3;
        var y = file2.position.y - file2.scale.y * 0.1;
        var z = file2.position.z + file2.scale.z * 0.15;
        fileText2.position = [x, y, z];

        var x = file.position.x - file.scale.x * 0.3 + 0.4;
        var y = file.position.y - file.scale.y * 0.1 + 0.1;
        var z = file.position.z + file.scale.z * 0.15;
        objectSymbol.position = [x, y, z];
        objectSymbol.scale = file.scale.times(1.2);

        bounceScale(file);
        bounceScale(file2);
        bounceScale(title);
        bounceScale(iPad);

        bounceScale(fileText2);
        bounceScale(objectSymbol);
    }
    else if (step == 37) { // Files go into iPad
        var depthVariation = 0.2;

        var newPosition = file.position.z - depthVariation;

        movePositionZ(file, newPosition);
        movePositionZ(file2, newPosition);
        movePositionZ(objectSymbol, objectSymbol.position.z - depthVariation);
        movePositionZ(fileText2, fileText2.position.z - depthVariation);

        var x = title.position.x;
        var y = title.position.y;

        setTimeout(autoMovePositionX, duration * 1000, [file, x]);
        setTimeout(autoMovePositionX, duration * 1000, [file2, x]);
        setTimeout(autoMovePositionX, duration * 1000, [fileText2, x]);
        setTimeout(autoMovePositionX, duration * 1000, [objectSymbol, x]);
        setTimeout(autoMovePositionY, duration * 1000, [file, y]);
        setTimeout(autoMovePositionY, duration * 1000, [file2, y]);
        setTimeout(autoMovePositionY, duration * 1000, [fileText2, y]);
        setTimeout(autoMovePositionY, duration * 1000, [objectSymbol, y]);

        setTimeout(bounce, 2 * duration * 1000, title);

        setTimeout(instaScale, 3.5 * duration * 1000, [objectSymbol, objectSymbol.scale.times(2)]);
        setTimeout(instaZ, 3.5 * duration * 1000, [objectSymbol, objectSymbol.position.z - 0.5]);
        setTimeout(autoMovePositionX, 3.5 * duration * 1000, [objectSymbol, iPad.position.x - 0.4 * iPad.scale.x]);
        setTimeout(autoMovePositionY, 3.5 * duration * 1000, [objectSymbol, iPad.position.y]);

        setTimeout(autoMovePositionZ, 4.5 * duration * 1000, [objectSymbol, iPad.position.z + 0.4]);
    }
    else if (step == 38) { // Files move on iPad
        var depthVariation = 0.07;

        movePositionZ(objectSymbol, objectSymbol.position.z - depthVariation);

        setTimeout(autoMovePositionX, duration * 1000, [objectSymbol, objectSymbol.position.x + 0.8 * iPad.scale.x])
        setTimeout(autoMovePositionZ, 2 * duration * 1000, [objectSymbol, objectSymbol.position.z + depthVariation * 0.7])
    }
    else if (step == 39) { // Files leave iPad
        var depthVariation = 0.2;

        movePositionZ(objectSymbol, fileText2.position.z - depthVariation);

        setTimeout(autoMovePositionX, duration * 1000, [objectSymbol, title.position.x]);
        setTimeout(autoMovePositionY, duration * 1000, [objectSymbol, title.position.y]);

        setTimeout(instaScale, 2 * duration * 1000, [objectSymbol, objectSymbol.scale.times(0.5)]);
        setTimeout(instaZ, 2 * duration * 1000, [objectSymbol, file.position.z + file.scale.z * 0.15]);
        setTimeout(bounce, 2 * duration * 1000, title);

        var y = title.position.y;

        var x1 = -6 - file.scale.x * 0.3 + 0.4;
        var y1 = y + 1.5 - file.scale.y * 0.1 + 0.1;

        var x2 = -6 - file2.scale.x * 0.3;
        var y2 = y - 1.5 - file2.scale.y * 0.1;

        setTimeout(autoMovePositionX, 3 * duration * 1000, [file, -6]);
        setTimeout(autoMovePositionX, 3 * duration * 1000, [file2, -6]);
        setTimeout(autoMovePositionX, 3 * duration * 1000, [fileText2, x2]);
        setTimeout(autoMovePositionX, 3 * duration * 1000, [objectSymbol, x1]);
        setTimeout(autoMovePositionY, 3 * duration * 1000, [file, y + 1.5]);
        setTimeout(autoMovePositionY, 3 * duration * 1000, [file2, y - 1.5]);
        setTimeout(autoMovePositionY, 3 * duration * 1000, [fileText2, y2]);
        setTimeout(autoMovePositionY, 3 * duration * 1000, [objectSymbol, y1]);

        setTimeout(autoMovePositionZ, 4 * duration * 1000, [file, file.position.z + depthVariation]);
        setTimeout(autoMovePositionZ, 4 * duration * 1000, [file2, file2.position.z + depthVariation]);
        setTimeout(autoMovePositionZ, 4 * duration * 1000, [objectSymbol, file.position.z + depthVariation + file.scale.z * 0.15]);
        setTimeout(autoMovePositionZ, 4 * duration * 1000, [fileText2, fileText2.position.z + depthVariation]);
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

function bounce(item) {
    var scalex = item.scale.x;
    var scaley = item.scale.y;
    var scalez = item.scale.z;

    item.addAnimation({"keyPath": "scale.x",
                      "fromValue": scalex,
                      "toValue": scalex * 1.1,
                      "function": "easeIn",
                      "autoreverses": true,
                      "duration": duration/2});
//    item.addAnimation({"keyPath": "scale.y",
//                      "fromValue": scaley * 1.1,
//                      "toValue": scaley,
//                      "function": "easeIn",
//                      "autoreverses": true,
//                      "duration": duration/2});
//    item.addAnimation({"keyPath": "scale.z",
//                      "fromValue": scalez * 1.1,
//                      "toValue": scalez,
//                      "function": "easeIn",
//                      "autoreverses": true,
//                      "duration": duration/2});
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

function instaScale(array) {
    var item = array[0];
    var scale = array[1];
    item.scale = scale;
}

function instaZ(array) {
    var item = array[0];
    var z = array[1];
    item.position = [item.position.x, item.position.y, z];
}

function moveCamera(newZ) {
    Camera.position = [0, 0, newZ];
}

function scaleItem(array) {
    array[0].scale = array[1];
}

function autoMovePositionX(array) {
    var item = array[0];
    var position = array[1];
    item.addAnimation({"keyPath": "position.x",
                      "toValue": position,
                      "function": "easeInOut",
                      "duration": duration});
    setTimeout(setPositionX, 0.9 * duration * 1000, [item, position]);
}

function autoMovePositionY(array) {
    var item = array[0];
    var position = array[1];
    item.addAnimation({"keyPath": "position.y",
                      "toValue": position,
                      "function": "easeInOut",
                      "duration": duration});
    setTimeout(setPositionY, 0.9 * duration * 1000, [item, position]);
}

function autoMovePositionZ(array) {
    var item = array[0];
    var position = array[1];
    item.addAnimation({"keyPath": "position.z",
                      "toValue": position,
                      "function": "easeInOut",
                      "duration": duration});
    setTimeout(setPositionZ, 0.9 * duration * 1000, [item, position]);
}

function movePositionX(item, position) {
    item.addAnimation({"keyPath": "position.x",
                      "toValue": position,
                      "function": "easeInOut",
                      "duration": duration});
    setTimeout(setPositionX, 0.9 * duration * 1000, [item, position]);
}

function movePositionY(item, position) {
    item.addAnimation({"keyPath": "position.y",
                      "toValue": position,
                      "function": "easeInOut",
                      "duration": duration});
    setTimeout(setPositionY, 0.9 * duration * 1000, [item, position]);
}

function movePositionZ(item, position) {
    item.addAnimation({"keyPath": "position.z",
                      "toValue": position,
                      "function": "easeInOut",
                      "duration": duration});
    setTimeout(setPositionZ, 0.9 * duration * 1000, [item, position]);
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

function changeTextAndAppear(array) {
    array[0].string = array[1];
    array[0].position = [array[0].position.x - 0.2,
                         array[0].position.y,
                         array[0].position.z];
    array[0].color = [0.99, 0.83, 0.18];
    appear(array[0]);
}

function animatePhysics(item) {
    var positionY = item.position.y - 0.6;

    item.addAnimation({"keyPath": "position.y",
                      "toValue": positionY,
                      "function": "easeIn",
                      "autoreverses": true,
                      "repeatCount": 2,
                      "duration": duration});
}

function animateGestures(item) {
    var positionZ = item.position.z;
    var positionX = item.position.x;
    movePositionZ(item, positionZ - 0.1);
    setTimeout(autoMovePositionX, duration * 0.9 * 1000, [item, positionX + 0.6]);
    setTimeout(autoMovePositionZ, duration * 1.9 * 1000, [item, positionZ]);
}

function animateInterface(item) {
    item.addAnimation({"keyPath": "position.x",
                      "toValue": item.position.x + 0.8,
                      "function": "easeInOut",
                      "autoreverses": true,
                      "duration": duration*2});
    setTimeout(autoMovePositionX, duration * 4 * 1000, [item, 0]);
}

function animateAnimation(item) {
    item.rotation = [0, 0, 1, 0];
    item.addAnimation({"keyPath": "rotation.w",
                      "toValue": 2 * pi,
                      "function": "easeInOut",
                      "autoreverses": true,
                      "duration": duration*2});
}
