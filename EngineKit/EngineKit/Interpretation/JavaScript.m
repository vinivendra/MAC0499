

#import "JavaScript.h"

#import "Physics.h"

#import "Position.h"
#import "Rotation.h"

#import "Camera.h"

#import "Box.h"
#import "Capsule.h"
#import "Cone.h"
#import "Cylinder.h"
#import "Floor.h"
#import "Plane.h"
#import "Pyramid.h"
#import "Sphere.h"
#import "Text.h"
#import "Torus.h"
#import "Tube.h"

#import "UI.h"

#import "NSString+Extension.h"
#import "JSContext+Extension.h"

#import "FileHelper.h"


@protocol consoleExport <JSExport>
+ (void)log:(id)object;
@end

@interface console : NSObject <consoleExport>
+ (void)log:(id)object;
@end

@implementation console
+ (void)log:(id)object {
    NSLog(@"#### %@", object);
}
@end


static NSString *_defaultFilename = @"main.js";


@interface JavaScript ()
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) NSString *filename;

@property (nonatomic, strong) JSValue *loadFunction;
@property (nonatomic, strong) JSValue *updateFunction;

@property (nonatomic, strong) JSValue *contactCallback;
@property (nonatomic, strong) JSValue *buttonCallback;
@property (nonatomic, strong) JSValue *sliderCallback;

@property (nonatomic, strong) NSArray *gestureCallbacks;

@property (nonatomic, strong) Camera *camera;
@end


@implementation JavaScript

- (instancetype)initWithCamera:(Camera *)camera UI:(UI *)ui {
    self = [self initWithFile:_defaultFilename camera:camera UI:ui];
    return self;
}

- (instancetype)initWithFile:(NSString *)filename camera:(Camera *)camera UI:(UI *)ui {
    if (self = [super init]) {
        self.camera = camera;
        self.ui = ui;
        if (!filename.valid) {
            filename = _defaultFilename;
        }
        self.filename = filename;
        self.context = [JSContext shared];
        [self setup];
    }
    return self;
}

//
- (void)setup {
    NSString *script = [FileHelper openTextFile:self.filename];

    [self setObjects];
    [self.context evaluateScript:script];
    [self getObjects];
}

- (void)load {
    [self.loadFunction callWithArguments:@[]];
}

- (void)update {
    static NSDate *previousTime;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      previousTime = [NSDate date];
                  });

    NSDate *currentTime = [NSDate date];

    NSTimeInterval delta = [currentTime timeIntervalSinceDate:previousTime];

    previousTime = currentTime;

    [self.updateFunction callWithArguments:@[ @(delta) ]];
}

//
- (void)setObjects {
    __block NSString *filename = self.filename;

    self.context.exceptionHandler = ^(JSContext *context, JSValue *value) {
        NSLog(@"JavaScript Error in file %@: %@.", filename, [value toString]);
    };

    self.context[@"console"] = [console class];
    self.context[@"print"] = ^(JSValue *value) {
        [console log:value];
    };

    self.context[@"pi"] = @(M_PI);
    self.context[@"origin"] = [Vector origin];

    [self.context evaluateScript:@"var callback;"];

    self.context[@"vector"] = [Vector class];
    self.context[@"position"] = [Position class];
    self.context[@"axis"] = [Axis class];
    self.context[@"rotation"] = [Rotation class];
    self.context[@"angle"] = [Angle class];

    self.context[@"camera"] = self.camera;

    self.context[@"sphere"] = [Sphere class];
    self.context[@"box"] = [Box class];
    self.context[@"cone"] = [Cone class];
    self.context[@"cylinder"] = [Cylinder class];
    self.context[@"tube"] = [Tube class];
    self.context[@"capsule"] = [Capsule class];
    self.context[@"torus"] = [Torus class];
    self.context[@"pyramid"] = [Pyramid class];
    self.context[@"plane"] = [Plane class];
    self.context[@"text"] = [Text class];
    self.context[@"floor"] = [Floor class];

    self.context[@"physics"] = [Physics new];

    self.context[@"color"] = [UIColor class];

    self.context[@"UIButton"] = [UIButton class];
    self.context[@"UISlider"] = [UISlider class];
    self.context[@"UILabel"] = [UILabel class];
    self.context[@"UI"] = self.ui;

    self.context[@"alignmentRight"] = @(NSTextAlignmentRight);
    self.context[@"alignmentLeft"] = @(NSTextAlignmentLeft);
    self.context[@"alignmentCenter"] = @(NSTextAlignmentCenter);

    self.context[@"up"] = @(UISwipeGestureRecognizerDirectionUp);
    self.context[@"right"] = @(UISwipeGestureRecognizerDirectionRight);
    self.context[@"left"] = @(UISwipeGestureRecognizerDirectionLeft);
    self.context[@"down"] = @(UISwipeGestureRecognizerDirectionDown);

    self.context[@"template"] = ^Item *(void) {
        return [Item template];
    };
}

- (void)getObjects {
    self.loadFunction = self.context[@"load"];
    self.updateFunction = self.context[@"update"];

    self.contactCallback = self.context[@"contact"];
    self.buttonCallback = self.context[@"button"];
    self.sliderCallback = self.context[@"slider"];

    NSMutableArray *gestureCallbacks =
        [NSMutableArray arrayWithCapacity:GestureRecognizersCount];

    NSMutableArray *tapArray = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *swipeArray = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *panArray = [NSMutableArray arrayWithCapacity:6];
    NSMutableArray *pinchArray = [NSMutableArray arrayWithCapacity:6];
    NSMutableArray *rotateArray = [NSMutableArray arrayWithCapacity:6];
    NSMutableArray *longPressArray = [NSMutableArray arrayWithCapacity:6];

    long int max = MAX(MAX(MAX(UIGestureRecognizerStateRecognized,
                          UIGestureRecognizerStateEnded),
                      UIGestureRecognizerStateBegan),
                  UIGestureRecognizerStateBegan);
    for (long int i = 0; i < max + 1; i++) {
        tapArray[i] = [NSNull null];
        swipeArray[i] = [NSNull null];
        panArray[i] = [NSNull null];
        pinchArray[i] = [NSNull null];
        rotateArray[i] = [NSNull null];
        longPressArray[i] = [NSNull null];
    }
    for (int i = 0; i < UIGesturesCount; i++) {
        gestureCallbacks[i] = [NSNull null];
    }

    tapArray[UIGestureRecognizerStateRecognized] = self.context[@"tap"];
    swipeArray[UIGestureRecognizerStateRecognized] = self.context[@"swipe"];
    panArray[UIGestureRecognizerStateBegan] = self.context[@"panBegan"];
    panArray[UIGestureRecognizerStateChanged] = self.context[@"pan"];
    panArray[UIGestureRecognizerStateEnded] = self.context[@"panEnded"];
    pinchArray[UIGestureRecognizerStateBegan] = self.context[@"pinchBegan"];
    pinchArray[UIGestureRecognizerStateChanged] = self.context[@"pinch"];
    pinchArray[UIGestureRecognizerStateEnded] = self.context[@"pinchEnded"];
    rotateArray[UIGestureRecognizerStateBegan] = self.context[@"rorateBegan"];
    rotateArray[UIGestureRecognizerStateChanged]
        = self.context[@"rotate"];
    rotateArray[UIGestureRecognizerStateEnded] = self.context[@"rotateEnded"];
    longPressArray[UIGestureRecognizerStateBegan]
        = self.context[@"longPressBegan"];
    longPressArray[UIGestureRecognizerStateChanged]
        = self.context[@"longPress"];
    longPressArray[UIGestureRecognizerStateEnded]
        = self.context[@"longPressEnded"];

    gestureCallbacks[TapGesture] = tapArray;
    gestureCallbacks[SwipeGesture] = swipeArray;
    gestureCallbacks[PanGesture] = panArray;
    gestureCallbacks[PinchGesture] = pinchArray;
    gestureCallbacks[RotateGesture] = rotateArray;
    gestureCallbacks[LongPressGesture] = longPressArray;

    self.gestureCallbacks = gestureCallbacks;
}

- (void)callGestureCallbackForGesture:(UIGestures)gesture
                                state:(UIGestureRecognizerState)state
                        withArguments:(NSArray *)arguments {

    [self.gestureCallbacks[gesture][state] callWithArguments:arguments];
}

@end
