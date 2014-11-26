##Creating Great Model Objects for iOS
[Download the examples from github](https://github.com/quellish/ModelObjectDemo)

###Model Objects Encapsulate Data

The primary role of a model object is to encapsulate data. A model object aggregates closely related values into a single component and may provide functionality for working with those values. 

A key concept in object oriented programming is encapsulation: a clean separation between the external, public interface of an object and it's internal implementation. An object should provide only the information essential for using the object in it's public interface, and not allow access to the internal implementation details.

###Deciding what is important

The public interface of a model object should describe only the characteristics of the object instance that distinguish it from other objects. 

For example, a `Person` model object may only have a first, last, and middle name because those are the only characteristic that matter to the application. An address is different conceptually and should be described by a different model object - though a Person may have a relationship to an `Address`.

When defining the public interface of a model object, start with nothing and add only what is *absolutely* necessary to express the role of the object. Never include information directly related to the display or presentation of an object. 

As an example, instead of exposing a "date" as an `NSString`, expose the same information as an `NSDate` that the display layer will localize and present to the user in the appropriate format. 

###The importance of immutable objects
An immutable object cannot be changed once it is created. This creates a very clean contract for the state and life cycle of the object: users of the object do not have to be concerned with the object's encapsulated values changing while it is being used.

In contrast, a mutable object can change at any time. This makes it much more difficult for users of the object to reason about it's state or life cycle because those can be changed by the actions of other objects. Because of this, [mutable objects cannot be assumed to be thread safe](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/Multithreading/ThreadSafetySummary/ThreadSafetySummary.html#//apple_ref/doc/uid/20000736-126010) - the data and state of the object can be changed by different threads, which without [some form of locking](http://quellish.tumblr.com/post/101831085987/implementing-thread-safety-in-cocoa-ios) will lead to significant problems.

In Cocoa, objects and properties are mutable by default.

###Declaring properties

In Objective-C properties are used to [encapsulate the values](https://developer.apple.com/library/ios/documentation/cocoa/conceptual/programmingwithobjectivec/EncapsulatingData/EncapsulatingData.html) of an object. A property provides an interface for accessing that value, wether the value is directly backed by storage such as an instance variable or not.

>**Instance variables should never be public.** Instance variables are implementation detail, and making them part of the public interface loses all the benefits of encapsulation.

When a property is `@synthesize`'d, the compiler creates accessor methods that follow the contract described by the `@property` declaration. The declaration of a property can describe memory ownership policy, accessor method names, and wether the value is read-only or writable. Not only does this tell the compiler how to construct the accessor methods, but a property declaration in a public interface (header file) describes to other object how they can interact with it.

If you were to declare a property using the default behavior:

`@property NSString *identifier;`

That property would be [atomic](https://developer.apple.com/library/ios/documentation/cocoa/conceptual/programmingwithobjectivec/EncapsulatingData/EncapsulatingData.html#//apple_ref/doc/uid/TP40011210-CH5-SW37), with strong memory ownership. It is identical to:

`@property (atomic, strong) NSString *identifier;`

If this property were part of the object's external interface other objects could change it at will, which is not desirable for the reasons outlined above. 

>To see a demonstration, look at the `MDPhotoNaive` object in the example and run the tests.

Instead, to create an immutable property declare it as read only in the public interface and add an appropriate parameter to the [designated initializer](https://developer.apple.com/library/ios/DOCUMENTATION/General/Conceptual/DevPedia-CocoaCore/MultipleInitializers.html) for the object:

Interface

@interface MDPhoto : NSObject
@property (readonly) NSString	*identifier;
- (instancetype) initWithIdentifier:(NSString *)anIdentifier;
@end

Implementation

@implementation MDPhoto
@synthesize identifier;
- (instancetype) initWithIdentifier:(NSString *)anIdentifier {
if ((self = [super init])){
identifier = anIdentifier;
}
return self;
}
@end


There is still a problem with the above implementation. `NSString` is immutable, but it has a mutable subclass within it's [class cluster](https://developer.apple.com/library/ios/documentation/general/conceptual/CocoaEncyclopedia/ClassClusters/ClassClusters.html), `NSMutableString`. Even after `identifier` is set in the intializer it's contents can be changed by another object. To correct this, the incoming value should be copied to capture it's value as an immutable object.

>To see a demonstration, look at the `MDPhotoWithBadCopy` object in the example and run the tests.

The property itself should be declared with `copy` ownership:
`@property (readonly) NSString	*identifier;`

And this line:

`identifier = anIdentifier;`

Becomes:

`identifier = [anIdentifier copy];`

>To see a demonstration, look at the `MDPhotoWithGoodCopy` object in the example and run the tests.

In the designated initializer we are accessing the instance variable directly, which circumvents the memory ownership policy declared with the property. To have the correct memory ownership we need to add the `-copy` when setting the instance variable directly. You should *only* access instance variables directly in an initializer or `-dealloc`, and even then there are good reasons to use property accessors.

>To see a demonstration of an immutable object with mutable subclass, look at the `MDPhotoPrivateMutability` and `MDPhotoPublicMutability` objects in the example and run the tests. In this example the immutable object does not have a public interface that allows writing to the property, but it is privately mutable. An external class that looks for the `setIdentifier:` method using `-respondsToSelector:` will still be able to access it. `MDPhotoNSCopying` and `MDMutablePhotoNSCopying` have correct implementations without this drawback.

###NSCopying and NSMutableCopying

`NSCopying` only requires one method to be implemented, `-copyWithZone:`. This method should return an immutable object with the same values as the receiver. When implementing this method, you have several options

- For an immutable object that has no relationships to other objects (i.e. no properties that are collections), an optimization is to return `self`. This would be a use of the interning technique.
- For any object, mutable or immutable, a new immutable object can be instantiated and populated with the values from the receiver. For a mutable object this would return an immutable counterpart that has identical values. Calling `-copy` on an `NSMutableString` would return an instance of `NSString` populated with the contents of the mutable string.

The second option is where things begin to get more complicated. Implementing `-copyWithZone:` is still straightforward, however it requires one class to have knowledge of another class, which is undesirable. 

`NSMutableCopying` is the sibling protocol to `NSCopying`. It too has one required method, `-mutableCopyWithZone:`, which returns an immutable object with the same values as the receiver. Mutable objects cannot safely take advantage of the interning technique described above, so `-mutableCopyWithZone:` must create a new mutable object populated with values from the receiver. Typically the immutable object is the superclass of the mutable object.

An immutable superclass implements `-copyWithZone:` using one of the options listed above. The mutable subclass must override that implementation if the immutable class uses interning in it's implementation - remember, interning is not safe for mutable objects.

The mutable subclass includes a category which provides an implementation of `-mutableCopyWithZone:` for the immutable object. Because the immutable object is the superclass for the mutable object it will use that implementation as well. Use of the category ensures that encapsulation and responsibility boundaries are intact, and the superclass does not need direct knowledge of it's mutable subclass.

>To see a demonstration, look at the `MDPhotoNSCopying` and `MDMutablePhotoNSMutableCopying` objects in the example and run the tests.

###NSSecureCoding

Cocoa provides the `NSCoding` protocol for serializing and deserializing objects. Several years ago this was extended with the `NSSecureCoding` protocol, which adds additional security protection over `NSCoding`. Implementing `NSSecureCoding` allows a model object to be persisted through mechanisms such as keyed archiving or property lists.

`NSSecureCoding` requires only three methods to be implemented, `-initWithCoder:`, `-encodeWithCoder`, and `+supportsSecureCoding`. `-encodeWithCoder:` takes property values and encodes them. `-initWithCoder:` decodes property values and constructs a new instance using those values. If `+supportsSecureCoding` returns `YES`, `-initWithCoder:` is required to use the `NSSecureCoding` methods to decode values (such as `-decodeObjectOfClass:forKey:`).

When objects are unarchived the expectation is that an immutable object is returned. To ensure that expectation is met, override the `NSObject` methods `-classForCoder` and `-classForUnarchiver` to return the `Class` that represents the immutable superclass. This ensures that any mutable subclasses will return the correct object when unarchived.

Archiving an object creates a persistent representation of that object's implementation. At some point the implementation of that object may change, so it is a good idea to add versioning information to the archive. If at some point in the future the interface of the object changes an archive created from a previous version may not be compatible. Persisting version information in the archive makes it simple to detect archive compatiblity issues and handle them.

>To see a demonstration, look at the `MDPhotoNSSecureCoding` and `MDMutablePhotoNSSecureCoding` objects in the example and run the tests.

###Equality and Comparison

Collections such as `NSSet` need a way to tell if two objects are equivalent to determine uniqueness. The default behavior is to compare objects by their memory address, which in most cases is sufficient. 

Mike Ash goes into much more detail regarding implementing equality for Objective-C objects: [Friday Q&A 2010-06-18: Implementing Equality and Hashing](https://www.mikeash.com/pyblog/friday-qa-2010-06-18-implementing-equality-and-hashing.html)

###-description and -debugDescription

The default implementation of the `-description` method of an `NSObject` subclass returns the class name and address. To aid in debugging this can be overriden to provide more useful information. When the debugger command `print-object` (more often expressed as `po`) is invoked, the instance method `-debugDescription` is called. This method in turn calls `-description`. For the purposes of debugging you can override either, though `-debugDescription` [is preferred](https://developer.apple.com/library/mac/technotes/tn2124/_index.html#//apple_ref/doc/uid/DTS10003391-CH1-SECCOCOA).

###Other Considerations
Since iOS 7 any object that implements [UIStateRestoring](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIStateRestoring_protocol/) can participate in user interface state restoration. Model objects that are user interface dependancies can easily implement the necessary methods in a category to allow them to be archived during state restoration. 

[WWDC 2013: What's New in State Restoration](https://developer.apple.com/videos/wwdc/2013/#222)

Key-Value Coding is a fundamental part of the Foundation API. A model class that correctly implements accessor methods will already be key-value coding compliant. KVC includes an informal protocol for validating values before they are set. If an object value is only valid when it meets some criteria - for example, the length of a string cannot be 0 - it can implement rules to reject bad values and return an error describing the failure.

[Key-Value Coding Programming Guide: Key-Value Validation](https://developer.apple.com/library/mac/documentation/cocoa/conceptual/KeyValueCoding/Articles/Validation.html)

For an example: 
[KVCValidationExample](https://github.com/quellish/KVCValidationExample)

###Core Data

The Core Data framework for object graph management has it's own object modeling capabilities. `NSManagedObject` subclasses descend from `NSObject` but have very different needs. Managed objects are owned and observed by a managed object context, and are essentially a structured collection of references to data that exists elsewhere. Because of this, implementing `NSSecureCoding` or `NSCopying` rarely makes sense. The behavior and life cycle of a managed object is controlled by the managed object context, making it difficult to build truly unique and independant instances of a model object that have the same values.

Core Data model objects will be the subject of a future post.

Link to original post:
[http://quellish.tumblr.com/post/103620381042/creating-great-model-objects-for-ios](http://quellish.tumblr.com/post/103620381042/creating-great-model-objects-for-ios)