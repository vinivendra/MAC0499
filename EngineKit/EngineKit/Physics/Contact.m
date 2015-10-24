

#import "Contact.h"
#import "JavaScript.h"

#import "SceneManager.h"

#import "SCNNode+Extension.h"

#import "NSArray+Extension.h"


@implementation Contact

- (instancetype)init {
    assert(false); // Contact should always be initialized with items and
                   // action, since it is immutable.

    if (self = [self initWithFirstItem:nil secondItem:nil action:nil]) {
    }
    return self;
}

+ (NSMutableDictionary *)contacts {
    static NSMutableDictionary *contacts;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      contacts = [NSMutableDictionary new];
                  });

    return contacts;
}

+ (void)registerContact:(id)object {
    Contact *contact;

    if ([object isKindOfClass:[Contact class]]) {
        contact = object;
    } else {
        contact = [[Contact alloc] initWithObject:object];
    }

    NSMutableArray *array = self.contacts[contact.key];
    if (array) {
        [array addObject:contact];
    } else {
        self.contacts[contact.key] = [NSMutableArray arrayWithObject:contact];
    }
}

+ (void)triggerActionForContact:(SCNPhysicsContact *)physicsContact {
    id<NSCopying> key = [Contact keyFoPhysicsContact:physicsContact];
    NSMutableArray *array = Contact.contacts[key];

    for (Contact *contact in array) {
        NSArray *arguments = @[
            physicsContact.nodeA.item,
            physicsContact.nodeB.item,
            physicsContact
        ];
        [contact.action callWithArguments:arguments];
    }
}


- (instancetype)copyWithZone:(NSZone *)zone {
    Contact *newContact = [Contact allocWithZone:zone];

    newContact.action = self.action;
    newContact.key = self.key;

    return newContact;
}

- (instancetype)initWithFirstItem:(Item *)firstItem
                       secondItem:(Item *)secondItem
                           action:(JSValue *)action {
    if (self = [super init]) {
        self.key = [Contact keyWithItem:firstItem andItem:secondItem];
        self.action = action;
    }
    return self;
}

- (instancetype)initWithArray:(NSArray *)array {
    JSValue *action = [SceneManager currentSceneManager].javaScript.contactCallback;
    self = [self initWithFirstItem:[array at:0]
                        secondItem:[array at:1]
                            action:action];
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    JSValue *action = [SceneManager currentSceneManager].javaScript.contactCallback;
    self = [self initWithFirstItem:dictionary[@"between"]
                        secondItem:dictionary[@"and"]
                            action:action];
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

- (instancetype)contactWithFirstItem:(Item *)firstItem
                          secondItem:(Item *)secondItem
                              action:(JSValue *)action {
    return [[Contact alloc] initWithFirstItem:firstItem
                                   secondItem:secondItem
                                       action:action];
}

- (instancetype)contactWithArray:(NSArray *)array {
    return [[Contact alloc] initWithArray:array];
}

- (instancetype)contactWithDictionary:(NSDictionary *)dictionary {
    return [[Contact alloc] initWithDictionary:dictionary];
}

- (instancetype)contactWithObject:(id)object {
    return [[Contact alloc] initWithObject:object];
}

+ (id<NSCopying>)keyFoPhysicsContact:(SCNPhysicsContact *)contact {
    return [self keyWithItem:contact.nodeA.item andItem:contact.nodeB.item];
}

+ (id<NSCopying>)keyWithItem:(Item *)anItem andItem:(Item *)anotherItem {
    unsigned long min = MIN(anItem.ID, anotherItem.ID);
    unsigned long max = MAX(anItem.ID, anotherItem.ID);
    return [NSString stringWithFormat:@"%lu-%lu", min, max];
}

@end
