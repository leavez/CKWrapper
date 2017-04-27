//
//  CKWInsetComponent.h
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

#import "CKWComponent.h"
#import "CKWViewAttributes.h"

/**
 for CKInsetComponent.
 */
NS_SWIFT_NAME(InsetComponent)
@interface CKWInsetComponent : CKWComponent

- (nullable instancetype)initWithInsets:(UIEdgeInsets)insets component:(nullable CKWComponent *)child;

/**
 @param view Passed to CKComponent +newWithView:size:. The view, if any, will extend outside the insets.
 @param insets The amount of space to inset on each side.
 @param component The wrapped child component to inset. If nil, this method returns nil.
 */
- (nullable instancetype)initWithView:(nullable CKWViewConfiguration *)view
                               insets:(UIEdgeInsets)insets
                            component:(nullable CKWComponent *)component;

@end
