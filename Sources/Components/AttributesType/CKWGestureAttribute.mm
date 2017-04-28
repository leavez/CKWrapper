//
//  CKWGestureAttribute.m
//  Pods
//
//  Created by Gao on 23/04/2017.
//
//

#import "CKWGestureAttribute.h"
#import "CKWViewAttribute+Inner.h"
#import "macro.h"

@implementation CKWViewAttributeValueType
- (CKComponentViewAttributeValue)convert {
    NSAssert(NO, @"subclass must override this method");
    return {@selector(setTag:), @0};
}
@end


@interface CKWGestureAttribute ()
@property (nonatomic, readwrite) Class gestureClass;
@property (nonatomic, readwrite) SEL action;
@end

@implementation CKWGestureAttribute

- (instancetype)initWithTapAction:(SEL)tapAction {
    self = [super init];
    if (self) {
        _action = tapAction;
        _gestureClass = [UITapGestureRecognizer class];
    }
    return self;
}
- (instancetype)initWithPanAction:(SEL)tapAction {
    self = [super init];
    if (self) {
        _action = tapAction;
        _gestureClass = [UIPanGestureRecognizer class];
    }
    return self;
}
- (instancetype)initWithLongPressAction:(SEL)tapAction {
    self = [super init];
    if (self) {
        _action = tapAction;
        _gestureClass = [UILongPressGestureRecognizer class];
    }
    return self;
}

- (CKComponentViewAttributeValue)convert {
    return CKComponentGestureAttribute(self.gestureClass, nullptr, self.action);
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if ([other isKindOfClass:CKWGestureAttribute.class]){
        CKWGestureAttribute *g = (CKWGestureAttribute *)other;
        return self.class == g.class && self.action == g.action;
    }
    return NO;
}

- (NSUInteger)hash {
    return std::hash<CKViewComponentAttributeValueMap>()({self.convert});
}

@end

