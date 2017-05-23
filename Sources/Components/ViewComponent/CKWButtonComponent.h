//
//  CKWButtonComponent.h
//  Pods
//
//  Created by Gao on 05/05/2017.
//
//

#import "CKWComponent.h"

NS_SWIFT_NAME(ButtonAttributes)
@interface CKWButtonAttributes : NSObject
@property (nonatomic) UIControlState state;
@property (nonatomic, nullable) NSString *title;
@property (nonatomic, nullable) UIColor *titleColor;
@property (nonatomic, nullable) UIImage *image;
@property (nonatomic, nullable) UIImage *backgroundImage;
@end

/**
 A component that creates a UIButton.

 This component chooses the smallest size within its SizeRange that will fit its content. If its max size is smaller
 than the size required to fit its content, it will be truncated.
 */
NS_SWIFT_NAME(ButtonComponnet)
@interface CKWButtonComponent : CKWComponent

- (nonnull instancetype)initWithButtonAttribute:(nonnull NSArray<CKWButtonAttributes *> *)buttonAttributes
                                      titleFont:(nonnull UIFont *)titleFont
                                       selected:(BOOL)selected
                                        enabled:(BOOL)enabled
                                         action:(nullable SEL)action
                                           size:(nullable CKWSize *)size
                                     attributes:(nullable CKWViewAttributeMap *)attributes
                             accessibilityLabel:(nullable NSString *)accessibilityLabel NS_REFINED_FOR_SWIFT;

@end


