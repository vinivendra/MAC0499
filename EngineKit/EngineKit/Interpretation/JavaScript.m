

#import "JavaScript.h"

#import "Position.h"
#import "Rotation.h"

#import "Camera.h"
#import "Light.h"

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

static NSString *animationID = @"0";


@interface JavaScript ()
@property (nonatomic, strong) NSString *scriptFilename;
@property (nonatomic, strong) NSString *sceneFilename;

@property (nonatomic, strong) JSValue *loadFunction;
@property (nonatomic, strong) JSValue *updateFunction;

@property (nonatomic, strong) JSValue *contactCallback;

@property (nonatomic, strong) Camera *camera;
@property (nonatomic, strong) Physics *physics;
@end


@implementation JavaScript

- (instancetype)initWithCamera:(Camera *)camera
                            UI:(UI *)ui
                       physics:(Physics *)physics
                        parser:(Parser *)parser {
    self = [self initWithFile:_defaultFilename
                       camera:camera
                           UI:ui
                      physics:physics
                       parser:parser];
    return self;
}

- (instancetype)initWithFile:(NSString *)scriptFilename
                      camera:(Camera *)camera
                          UI:(UI *)ui
                     physics:(Physics *)physics
                      parser:(Parser *)parser {

    if (self = [self initWithScriptFile:scriptFilename
                              sceneFile:nil
                                 camera:camera
                                     UI:ui
                                physics:physics
                                 parser:parser]) {
    }
    return self;
}

- (instancetype)initWithScriptFile:(NSString *)scriptFilename
                         sceneFile:(NSString *)sceneFilename
                            camera:(Camera *)camera
                                UI:(UI *)ui
                           physics:(Physics *)physics
                            parser:(Parser *)parser {
    if (self = [super init]) {
        self.camera = camera;
        self.ui = ui;
        self.physics = physics;
        self.sceneFilename = sceneFilename;

        if (!scriptFilename.valid) {
            scriptFilename = _defaultFilename;
        }
        self.scriptFilename = scriptFilename;

        self.context = [JSContext new];
        self.parser = parser;

        self.triggerActionManager = [TriggerActionManager new];
        self.triggerActionManager.scene = self.physics.scene;
        self.triggerActionManager.context = self.context;

        [self setup];
    }
    return self;
}

//
- (void)setup {
    NSString *mainScript = [FileHelper openTextFile:self.scriptFilename];
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
    self.context.exceptionHandler = ^(JSContext *context, JSValue *value) {
        NSLog(@"JavaScript Error: %@.", [value toString]);
    };

    self.context[@"console"] = [console class];
    self.context[@"print"] = ^(JSValue *value) {
        [console log:value];
    };
    self.context[@"alert"] = ^(JSValue *value) {
        [console log:value];
    };

    self.context[@"sceneFilename"] = self.sceneFilename;

    self.context[@"pi"] = @(M_PI);
    self.context[@"origin"] = [Vector origin];

    [self.context evaluateScript:@"var callback;"];

    self.context[@"Scene"] = self.physics.scene;

    self.context[@"Parser"] = self.parser;

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

    self.context[@"Animation"] = [CABasicAnimation class];
}

- (void)getObjects {
    self.loadFunction = self.context[@"load"];
    self.updateFunction = self.context[@"update"];

    self.contactCallback = self.context[@"contact"];
}

@end
