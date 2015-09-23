

#import "JavaScript.h"

#import "Physics.h"

#import "Position.h"
#import "Rotation.h"

#import "Camera.h"
#import "Light.h"

#import "Parser.h"

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
#import "JSValue+Extension.h"

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

- (TriggerActionManager *)triggerActionManager {
    if (!_triggerActionManager) {
        _triggerActionManager = [TriggerActionManager new];
    }

    return _triggerActionManager;
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

    self.context[@"parser"] = [Parser shared];

    self.context[@"vector"] = [Vector class];
    self.context[@"position"] = [Position class];
    self.context[@"axis"] = [Axis class];
    self.context[@"rotation"] = [Rotation class];
    self.context[@"angle"] = [Angle class];

    self.context[@"light"] = [Light class];
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
    self.triggerActionManager.actions[triggerButtonPressed] = self.context[@"button"];
    self.triggerActionManager.actions[triggerSliderPressed] = self.context[@"slider"];

    self.triggerActionManager.actions[triggerTap] = self.context[@"tap"];
    self.triggerActionManager.actions[triggerSwipe] = self.context[@"swipe"];
    self.triggerActionManager.actions[triggerPanBegan] = self.context[@"panBegan"];
    self.triggerActionManager.actions[triggerPan] = self.context[@"pan"];
    self.triggerActionManager.actions[triggerPanEnded] = self.context[@"panEnded"];
    self.triggerActionManager.actions[triggerPinchBegan] = self.context[@"pinchBegan"];
    self.triggerActionManager.actions[triggerPinch] = self.context[@"pinch"];
    self.triggerActionManager.actions[triggerPinchEnded] = self.context[@"pinchEnded"];
    self.triggerActionManager.actions[triggerRorateBegan] = self.context[@"rorateBegan"];
    self.triggerActionManager.actions[triggerRotate] = self.context[@"rotate"];
    self.triggerActionManager.actions[triggerRotateEnded] = self.context[@"rotateEnded"];
    self.triggerActionManager.actions[triggerLongPressBegan] = self.context[@"longPressBegan"];
    self.triggerActionManager.actions[triggerLongPress] = self.context[@"longPress"];
    self.triggerActionManager.actions[triggerLongPressEnded] = self.context[@"longPressEnded"];
}

@end
