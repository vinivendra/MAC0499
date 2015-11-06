
#ifndef CABasicAnimation_Extension_h
#define CABasicAnimation_Extension_h

#import <SceneKit/SceneKit.h>


@protocol CABasicAnimationExport <JSExport>
@property CFTimeInterval beginTime;
@property CFTimeInterval duration;
@property float speed;
@property CFTimeInterval timeOffset;
@property float repeatCount;
@property CFTimeInterval repeatDuration;
@property BOOL autoreverses;
@property (copy) NSString *_Null_unspecified fillMode;

+ (_Null_unspecified instancetype)animation;
+ (nullable id)defaultValueForKey:(NSString *_Null_unspecified)key;
- (BOOL)shouldArchiveValueForKey:(NSString *_Null_unspecified)key;
@property (nullable, strong) CAMediaTimingFunction *timingFunction;
@property (nullable, strong) id delegate;
@property (getter=isRemovedOnCompletion) BOOL removedOnCompletion;

+ (_Null_unspecified instancetype)animationWithKeyPath:
    (nullable NSString *)path;
@property (nullable, copy) NSString *keyPath;
@property (getter=isAdditive) BOOL additive;
@property (getter=isCumulative) BOOL cumulative;
@property (nullable, strong) CAValueFunction *valueFunction;

@property (nullable, strong) id fromValue;
@property (nullable, strong) id toValue;
@property (nullable, strong) id byValue;
@end


@interface CABasicAnimation (Exports) <CABasicAnimationExport>
- (_Nonnull instancetype)initWithDictionary:
    ( NSDictionary * _Nullable )dictionary;
@end

#endif