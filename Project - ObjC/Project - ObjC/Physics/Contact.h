// TODO: Create <object>WithSomething: methods for every initWithSomething:
// method in the objc code.


/*!
 The Contact class represents an object meant to manage contact events between
 two Items. Whenever Contact is detected, the Physics singleton is responsible
 for checking if the corresponding Contact object exists; the Contact object
 itself is then responsible for firing a callback function in JavaScript.
 */
@interface Contact : NSObject <NSCopying>
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
 One of the Items involved in the contact.
 @see secondItem
 */
@property (nonatomic, strong) Item *firstItem;
/*!
 One of the Items involved in the contact.
 @see firstItem
 */
@property (nonatomic, strong) Item *secondItem;
/*!
 The action to be triggered when a contact occurs between the @p firstObject and
 the @p secondObject.
 */
@property (nonatomic, strong) JSValue *action;
@end
