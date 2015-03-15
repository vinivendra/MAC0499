

#import "JavaScript.h"


@protocol consoleExport <JSExport>
+ (void)log:(id)object;
@end

@interface console : NSObject <consoleExport>
+ (void)log:(id)object;
@end

@implementation console
+ (void)log:(id)object {
    NSLog( @"#### %@", object );
}
@end


static NSString *_defaultFilename = @"main.js";


@interface JavaScript ()
@property ( nonatomic, strong ) JSContext *context;
@property ( nonatomic, strong ) NSString *filename;
@property ( nonatomic, strong ) JSValue *loadFunction;
@property ( nonatomic, strong ) JSValue *updateFunction;
@end


@implementation JavaScript

+ (JavaScript *)shared {
    static JavaScript *singleton;

    static dispatch_once_t onceToken;
    dispatch_once( &onceToken,
                   ^{
                       singleton = [JavaScript new];
                   } );

    return singleton;
}

- (instancetype)init {
    self = [self initWithFile:_defaultFilename];
    return self;
}

- (instancetype)initWithFile:(NSString *)filename {
    if ( self = [super init] ) {
        assert( [filename valid] );
        self.filename = filename;
        self.context = [JSContext shared];
        [self setup];
    }
    return self;
}

- (void)setup {
    NSString *script = [FileHelper openTextFile:self.filename];

    __block NSString *filename = self.filename;

    self.context.exceptionHandler = ^( JSContext *context, JSValue *value ) {
        NSLog( @"JavaScript Error in file %@: %@.", filename, [value toString] );
    };

    self.context[ @"console" ] = [console class];
    self.context[ @"print" ] = ^( JSValue *value ) {
        [console log:value];
    };

    [self.context evaluateScript:script];
}

- (void)load {
    self.loadFunction = self.context[@"load"];
    
    [self.loadFunction callWithArguments:@[]];
}

@end
