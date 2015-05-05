

#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>

#import "Item.h"


/*!
 The Contact class represents an object meant to manage contact events between
 two Items. Whenever a contact is detected, the Physics singleton is responsible
 for checking if the corresponding Contact object exists; the Contact object
 itself is then responsible for firing a callback function in JavaScript.
 */
@interface Contact : NSObject <NSCopying>
/*!
 Registers a contact so that its action may be activated on demand.
 @param contact The Contact object to register, or an object that may be used
 with the Contact class's @p -initWithObject.
 */
+ (void)registerContact:(id)contact;
/*!
 Triggers an action for some specific type of contact, if it has been
 registered.
 @param physicsContact The contact whose corresponding action must be triggered.
 */
+ (void)triggerActionForContact:(SCNPhysicsContact *)physicsContact;
/*!
 Creates a Contact object ready to handle a contacts between the first and
 second
 Items using the JSValue action.
 @param firstItem  One of the Items involved in the contacts.
 @param secondItem The other Item involved in the contacts.
 @param action     A JSValue representing a function in JavaScript code that
 will be called when contact is detected.
 @return An initialized instance of Contact.
 */
- (instancetype)initWithFirstItem:(Item *)firstItem
                       secondItem:(Item *)secondItem
                           action:(JSValue *)action;
/*!
 Creates a Contact based on the given array. The array should have the firstItem
 in its first position, the secondItem in its second position and the action in
 its third position - everything else is ignored.
 @param array The array with the Contact's info.
 @return An initialized instance of Contact.
 */
- (instancetype)initWithArray:(NSArray *)array;
/*!
 Creates a Contact based on the given dictionary. The dictionary should have the
 firstItem in its "between" key, the secondItem in its "and" key and the action
 in its "contact" key - everything else is ignored. Ideally, it would be used by
 JavaScript in this way:

 @code
 physics.newContact = { "contact": aFunction,
                        "between": anObject,
                            "and": anotherbject };
 @endcode

 @param dictionary The dictionary with the Contact's info.
 @return An initialized instance of Contact.
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
/*!
 Attempts to create a Contact with the given object. This method accepts
 NSArrays (which are initialized using @p -initWithArray) and NSDictionaries
 (which are initialized using @p -initWithDictionary).
 @see -initWithArray, -initWithDictioinary
 @param object An object with the Contact's info.
 @return An initialized instance of Contact.
 */
- (instancetype)initWithObject:(id)object;

/*!
 Creates a Contact object ready to handle a contacts between the first and
 second
 Items using the JSValue action.
 @param firstItem  One of the Items involved in the contacts.
 @param secondItem The other Item involved in the contacts.
 @param action     A JSValue representing a function in JavaScript code that
 will be called when contact is detected.
 @return An initialized instance of Contact.
 */
- (instancetype)contactWithFirstItem:(Item *)firstItem
                          secondItem:(Item *)secondItem
                              action:(JSValue *)action;
/*!
 Creates a Contact based on the given array. The array should have the firstItem
 in its first position, the secondItem in its second position and the action in
 its third position - everything else is ignored.
 @param array The array with the Contact's info.
 @return An initialized instance of Contact.
 */
- (instancetype)contactWithArray:(NSArray *)array;
/*!
 Creates a Contact based on the given dictionary. The dictionary should have the
 firstItem in its "between" key, the secondItem in its "and" key and the action
 in its "contact" key - everything else is ignored. Ideally, it would be used by
 JavaScript in this way:

 @code
 physics.newContact = { "contact": aFunction,
 "between": anObject,
 "and": anotherbject };
 @endcode

 @param dictionary The dictionary with the Contact's info.
 @return An initialized instance of Contact.
 */
- (instancetype)contactWithDictionary:(NSDictionary *)dictionary;
/*!
 Attempts to create a Contact with the given object. This method accepts
 NSArrays (which are initialized using @p -initWithArray) and NSDictionaries
 (which are initialized using @p -initWithDictionary).
 @see -initWithArray, -initWithDictioinary
 @param object An object with the Contact's info.
 @return An initialized instance of Contact.
 */
- (instancetype)contactWithObject:(id)object;

/*!
 Returns a key meant to be used as an NSDictionary key. This key ignores the
 order of the Contact's Items (which is the firstItem and which is the
 secondItem), so that contacts between the same two Items always get mapped to
 the same object.
 */
@property (nonatomic, strong) id<NSCopying> key;
/*!
 The action to be triggered when a contact occurs between the @p firstObject and
 the @p secondObject.
 */
@property (nonatomic, strong) JSValue *action;
@end
