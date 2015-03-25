

#import "Contact.h"


@implementation Contact

- (instancetype)copyWithZone:(NSZone *)zone {
    Contact *newContact = [Contact allocWithZone:zone];

    newContact.action = self.action;
    newContact.firstItem = self.firstItem;
    newContact.secondItem = self.secondItem;

    return newContact;
}

- (instancetype)initWithFirstItem:(Item *)firstItem
                       secondItem:(Item *)secondItem
                           action:(JSValue *)action {
    if (self = [super init]) {
        self.firstItem = firstItem;
        self.secondItem = secondItem;
        self.action = action;
    }
    return self;
}

- (instancetype)initWithArray:(NSArray *)array {
    self =
        [self initWithFirstItem:array[1] secondItem:array[2] action:array[0]];
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [self initWithFirstItem:dictionary[@"between"]
                        secondItem:dictionary[@"and"]
                            action:dictionary[@"contact"]];
    return self;
}

- (instancetype)initWithObject:(id)object {
    if ([object isKindOfClass:[NSArray class]]) {
        self = [self initWithArray:object];
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        self = [self initWithDictionary:object];
    } else {
        assert(false); // Trying to initialize a contact with an invalid object!
    }

    return self;
}

@end
