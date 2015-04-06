

@interface SCNGeometry (Extension)
/*!
 Creates a deep copy of the receiver, including in it any relevant information.
 @return A new instance of SCNGeometry, representing a copy of the receiver.
 */
- (SCNGeometry *)deepCopy;
/*!
 Copies relevant information from the receiver to the given geometry. Used by
 deepCopy to copy the actual information over.
 @param geometry The new geometry object, into which all copied information will
 be written.
 */
- (void)deepCopyTo:(SCNGeometry *)geometry;
@end

@interface SCNSphere (Extension)
/*!
 Creates a deep copy of the receiver, including in it any relevant information.
 @return A new instance of SCNSphere, representing a copy of the receiver.
 */
- (SCNSphere *)deepCopy;
@end
