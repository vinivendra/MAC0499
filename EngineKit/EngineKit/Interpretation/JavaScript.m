

#import "JavaScript.h"

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
static NSString *_supportFilename = @"support.js";


@interface JavaScript ()
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) NSString *filename;

@property (nonatomic, strong) JSValue *loadFunction;
@property (nonatomic, strong) JSValue *updateFunction;

@property (nonatomic, strong) JSValue *contactCallback;

@property (nonatomic, strong) Camera *camera;
@property (nonatomic, strong) Physics *physics;
@end


@implementation JavaScript

- (instancetype)initWithCamera:(Camera *)camera UI:(UI *)ui physics:(Physics *)physics {
    self = [self initWithFile:_defaultFilename camera:camera UI:ui physics:physics];
    return self;
}

- (instancetype)initWithFile:(NSString *)filename camera:(Camera *)camera UI:(UI *)ui physics:(Physics *)physics {
    if (self = [super init]) {
        self.camera = camera;
        self.ui = ui;
        self.physics = physics;
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
    NSString *mainScript = [FileHelper openTextFile:self.filename];
    NSString *supportScript = [FileHelper openTextFile:_supportFilename];

    [self setObjects];
    [self.context evaluateScript:supportScript];
    [self.context evaluateScript:mainScript];
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
    self.context[@"alert"] = ^(JSValue *value) {
        [console log:value];
    };

    self.context[@"pi"] = @(M_PI);
    self.context[@"origin"] = [Vector origin];

    [self.context evaluateScript:@"var callback;"];

    self.context[@"Parser"] = [Parser shared];

    self.context[@"Vector"] = [Vector class];
    self.context[@"Position"] = [Position class];
    self.context[@"Axis"] = [Axis class];
    self.context[@"Rotation"] = [Rotation class];
    self.context[@"Angle"] = [Angle class];

    self.context[@"Light"] = [Light class];
    self.context[@"Camera"] = self.camera;

    self.context[@"Sphere"] = [Sphere class];
    self.context[@"Box"] = [Box class];
    self.context[@"Cone"] = [Cone class];
    self.context[@"Cylinder"] = [Cylinder class];
    self.context[@"Tube"] = [Tube class];
    self.context[@"Capsule"] = [Capsule class];
    self.context[@"Torus"] = [Torus class];
    self.context[@"Pyramid"] = [Pyramid class];
    self.context[@"Plane"] = [Plane class];
    self.context[@"Text"] = [Text class];
    self.context[@"Floor"] = [Floor class];

    self.context[@"Physics"] = self.physics;

    self.context[@"Color"] = [UIColor class];

    self.context[@"UIButton"] = [UIButton class];
    self.context[@"UISlider"] = [UISlider class];
    self.context[@"UILabel"] = [UILabel class];
    self.context[@"UI"] = self.ui;

    self.context[@"alignmentRight"] = @(NSTextAlignmentRight);
    self.context[@"alignmentLeft"] = @(NSTextAlignmentLeft);
    self.context[@"alignmentCenter"] = @(NSTextAlignmentCenter);

    self.context[@"Up"] = @(UISwipeGestureRecognizerDirectionUp);
    self.context[@"Right"] = @(UISwipeGestureRecognizerDirectionRight);
    self.context[@"Left"] = @(UISwipeGestureRecognizerDirectionLeft);
    self.context[@"Down"] = @(UISwipeGestureRecognizerDirectionDown);

    self.context[@"TriggerManager"] = self.triggerActionManager;

    self.context[@"Template"] = ^Item *(void) {
        return [Item template];
    };
}

- (void)getObjects {
    self.loadFunction = self.context[@"load"];
    self.updateFunction = self.context[@"update"];

    self.contactCallback = self.context[@"contact"];


    if (!self.triggerActionManager) {
        self.triggerActionManager = [TriggerActionManager new];
    }
}

- (TriggerActionManager *)triggerActionManager {
    if (!_triggerActionManager) {
        _triggerActionManager = [TriggerActionManager new];
    }
    return _triggerActionManager;
}

@end
