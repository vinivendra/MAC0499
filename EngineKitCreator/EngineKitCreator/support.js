
function loadStandardLights() {
    var myLight = Light.create();
    myLight.color = [1.0, 1.0];
    myLight.position = [3, 3, 3];
    myLight.isDefault = true;

    myLight = Light.create();
    myLight.color = [0.4, 1.0];
    myLight.type = "ambient";
    myLight.isDefault = true;
    myLight.position = [-3, -3, -3];
}

var x = [1, 0, 0];
var y = [0, 1, 0];
var z = [0, 0, 1];

var cameraX = Camera.rotation.rotate(x);
var cameraY = Camera.rotation.rotate(y);
var cameraZ = Camera.rotation.rotate(z);

function updateCameraAxes() {
    cameraX = Camera.rotation.rotate(x);
    cameraY = Camera.rotation.rotate(y);
    cameraZ = Camera.rotation.rotate(z);
}

function trackballAction(items, translation) {
    var resized = translation.times(0.02);

    updateCameraAxes();
    var axis = cameraX.times(resized.y)
    .plus(cameraY.times(-resized.x));

    var rot = Rotation.create([axis, resized.normSquared()]);
    Camera.rotateAround(rot, [0, 0, 0]);
}

function sceneTranslationAction(items, translation) {
    var resized = translation.times(0.01);

    updateCameraAxes();
    var translation = cameraX.times(-resized.x)
    .plus(cameraY.times(-resized.y));

    Camera.position = Camera.position.plus(translation);
}

function itemTranslationAction(items, translation) {
    if (typeof items[0] != 'undefined') {
        var resized = translation.times(0.01);

        updateCameraAxes();
        var translation = cameraX.times(resized.x)
        .plus(cameraY.times(resized.y));

        var distance = items[0].position.minus(Camera.position);
        var ratio = distance.norm() / 7.5;

        var resizedTranslation = translation.times(ratio);

        items[0].position = items[0].position.plus(resizedTranslation);
    }
}

function itemTranslationActionSnappedToAxes(items, translation) {
    if (typeof items[0] != 'undefined') {

        updateCameraAxes();

        var resized = translation.times(0.01);
        var translation = cameraX.times(resized.x)
        .plus(cameraY.times(resized.y));

        var xDot = Math.abs(cameraZ.dot(x));
        var yDot = Math.abs(cameraZ.dot(y));
        var zDot = Math.abs(cameraZ.dot(z));

        var projection;

        if (xDot >  yDot && xDot > zDot) {
            projection = translation.setNewX(0);
        }
        else if (yDot > zDot) {
            projection = translation.setNewY(0);
        }
        else {
            projection = translation.setNewZ(0);
        }

        var distance = items[0].position.minus(Camera.position);
        var ratio = distance.norm() / 7.5;

        var resizedProjection = projection.times(ratio);

        items[0].position = items[0].position.plus(resizedProjection);
    }
}

function itemScaleAction(items, scale) {
    if (typeof items[0] != 'undefined') {
        items[0].scale = items[0].scale.times(scale);
    }
}

function zoomCameraAction(items, scale) {
    updateCameraAxes();
    var translation = cameraZ.times((1 - (scale)) * 5);
    Camera.position = Camera.position.plus(translation);
}

function itemRotationAction(items, angle) {
    if (typeof items[0] != 'undefined') {
        updateCameraAxes();
        items[0].rotate({"axis":cameraZ, "a":angle});
    }
}

function sceneRotationAction(items, angle) {
    updateCameraAxes();
    var rotZ = Rotation.create([cameraZ, -angle]);
    Camera.rotateAround(rotZ, origin);
}

////////////////////////////////////////////////////////////////////////////////

//function setPositionX(value) {
//    return function(items){
//        alert("Hello2");
//    };
//}
//
//
//- (void)setPositionX:(NSNumber *)newValue;
//- (void)setPositionY:(NSNumber *)newValue;
//- (void)setPositionZ:(NSNumber *)newValue;
//- (void)setScaleX:(NSNumber *)newValue;
//- (void)setScaleY:(NSNumber *)newValue;
//- (void)setScaleZ:(NSNumber *)newValue;
//- (void)setRotationX:(NSNumber *)newValue;
//- (void)setRotationY:(NSNumber *)newValue;
//- (void)setRotationZ:(NSNumber *)newValue;
//- (void)setRotationA:(NSNumber *)newValue;
//- (NSNumber *)positionX;
//- (NSNumber *)positionY;
//- (NSNumber *)positionZ;
//- (NSNumber *)scaleX;
//- (NSNumber *)scaleY;
//- (NSNumber *)scaleZ;
//- (NSNumber *)rotationX;
//- (NSNumber *)rotationY;
//- (NSNumber *)rotationZ;
//- (NSNumber *)rotationA;
//- (void)addPositionX:(NSNumber *)newValue;
//- (void)addPositionY:(NSNumber *)newValue;
//- (void)addPositionZ:(NSNumber *)newValue;
//- (void)addScaleX:(NSNumber *)newValue;
//- (void)addScaleY:(NSNumber *)newValue;
//- (void)addScaleZ:(NSNumber *)newValue;
//- (void)addRotationX:(NSNumber *)newValue;
//- (void)addRotationY:(NSNumber *)newValue;
//- (void)addRotationZ:(NSNumber *)newValue;
//- (void)addRotationA:(NSNumber *)newValue;




