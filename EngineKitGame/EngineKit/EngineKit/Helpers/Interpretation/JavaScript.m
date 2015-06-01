

#import "JavaScript.h"

#import "Physics.h"

#import "Position.h"
#import "Rotation.h"

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

@property (nonatomic, strong) JSValue *tapCallback;
@property (nonatomic, strong) JSValue *swipeCallback;
@property (nonatomic, strong) JSValue *panCallback;
@property (nonatomic, strong) JSValue *pinchCallback;
@property (nonatomic, strong) JSValue *rotationCallback;
@property (nonatomic, strong) JSValue *longPressCallback;
@end


@implementation JavaScript

+ (JavaScript *)shared {
    static JavaScript *singleton;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      singleton = [JavaScript new];
                  });

    return singleton;
}

- (instancetype)init {
    self = [self initWithFile:_defaultFilename];
    return self;
}

- (instancetype)initWithFile:(NSString *)filename {
    if (self = [super init]) {
        assert([filename valid]);
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

    [self.context evaluateScript:@"var callback;"];

    self.context[@"vector"] = [Vector class];
    self.context[@"position"] = [Position class];
    self.context[@"axis"] = [Axis class];
    self.context[@"rotation"] = [Rotation class];
    self.context[@"angle"] = [Angle class];

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
    self.context[@"UI"] = [UI shared];

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

    self.tapCallback = self.context[@"tap"];
    self.swipeCallback = self.context[@"swipe"];
    self.panCallback = self.context[@"pan"];
    self.pinchCallback = self.context[@"pinch"];
    self.rotationCallback = self.context[@"rotate"];
    self.longPressCallback = self.context[@"longPress"];
}

@end
