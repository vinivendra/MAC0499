

#import "JavaScript.h"

#import "Physics.h"

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

    self.context[@"UIButton"] = [UIButton class];
    self.context[@"UISlider"] = [UISlider class];
    self.context[@"UI"] = [UI shared];

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
}

@end
