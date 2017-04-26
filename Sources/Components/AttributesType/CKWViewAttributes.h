//
//  CKWViewAttributes.h
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import <Foundation/Foundation.h>
#import "CKWCreatorBase.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - --------------- ViewClass ----------------------
@interface CKWViewClass : CKWCreatorBase

typedef void (^CKWViewReuseBlock)(UIView *);
typedef UIView * _Nonnull(* _Nonnull CKWViewFactoryType)(void);

- (instancetype)init;
- (instancetype)initWithCls:(Class)viewClass;
- (instancetype)initWithCls:(Class)viewClass didEnterReusePoolMessage:(nullable SEL)didEnterReusePoolMessage willLeaveReusePoolMessage:(nullable SEL)willLeaveReusePoolMessage;
- (instancetype)initWithFactory:(CKWViewFactoryType)factory didEnterReusePool:(nullable CKWViewReuseBlock)didEnterReusePool willLeaveReusePool:(nullable CKWViewReuseBlock)willLeaveReusePool;
@end


#pragma mark - --------------- ViewAttribute ----------------------
@interface CKWViewAttribute : CKWCreatorBase
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithSetter:(SEL)setter;
- (instancetype)initWithLayerSetter:(SEL)setter;
- (instancetype)initWithIdentifier:(NSString *)string
                        applicator:(void (^ _Nonnull)(id view, id value))applicator
                      unapplicator:(void (^ _Nullable)(id view, id value))unapplicator
                           updater:(void (^ _Nullable)(id view, id oldValue, id newValue))updater;
@end


#pragma mark - --------------- AccessibilityTextAttribute ---------------
@interface CKWAccessibilityTextAttribute : CKWCreatorBase
- (instancetype)initWithText:(NSString *)text;
- (instancetype)initWithLazyTextBlock:(NSString *(^)())textBlock;
- (BOOL)hasText;
- (nullable NSString *)value;
@end

#pragma mark - --------------- AccessibilityContext ---------------
@interface CKWAccessibilityContext : CKWCreatorBase
@property (nonatomic, nullable) NSNumber *isAccessibilityElement;
@property (nonatomic, nullable) CKWAccessibilityTextAttribute *accessibilityLabel;
@property (nonatomic, nullable) SEL accessibilityComponentAction;
@end


#pragma mark - --------------- ViewConfiguration ---------------
@interface CKWViewConfiguration : CKWCreatorBase
@property (nonatomic, nullable) CKWViewClass *cls;
@property (nonatomic, nullable) NSDictionary<CKWViewAttribute *, id> *viewAttributeMap;
@property (nonatomic, nullable) CKWAccessibilityContext *context;

- (instancetype)init;
- (instancetype)initWithViewClass:(CKWViewClass *)cls
                viewAttributeMap:(nullable NSDictionary<CKWViewAttribute *, id> *)viewAttributeMap;
- (instancetype)initWithViewClass:(CKWViewClass *)cls
                viewAttributeMap:(nullable NSDictionary<CKWViewAttribute *, id> *)viewAttributeMap
            accessibilityContext:(nullable CKWAccessibilityContext *)context;

@end

NS_ASSUME_NONNULL_END
