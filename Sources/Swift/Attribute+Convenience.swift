//
//  Utilitys.swift
//  Pods
//
//  Created by Gao on 04/05/2017.
//
//

import Foundation

/// Code completion doesn't work very well for static method, so we may explict
/// write the type. We will use this type frequently, so give it a short name.
public typealias A = Attribute

public enum Attribute {
    case key(ViewAttribute, value: Any?)
    case keyAndValue(ViewAttributeValue)
    case set(Selector, to:Any?)
    case setLayer(Selector, to:Any?)
    case composite([Attribute])
    //   keyPath(: value:)
}

extension Attribute {
    
    /// Convenient method to declear setting a value
    public static func keyPath<U,T>(_ kp: ReferenceWritableKeyPath<U,T>, value:T) -> Attribute {
        assert(kp._kvcKeyPathString != nil)
        let key = ViewAttribute(identifier: "keyPath:" + kp._kvcKeyPathString!, applicator: { (view, value) in
            if let view = view as? U, let v = value as? T {
                view[keyPath:kp] = v
            }
        }, unapplicator: nil, updater: nil)
        return Attribute.keyAndValue(
            ViewAttributeValue().build({
                $0.key = key;
                $0.value = value
            })
        )
    }
}



extension Attribute {
    
    // convert
    static func convert(attributes: [Attribute]) -> [ViewAttributeValue] {
        return attributes.reduce([], { sum, element in
            switch element {
            case .key(let key, value: let value):
                return sum + [ViewAttributeValue().build({ $0.key = key; $0.value = value })]
            case .keyAndValue(let kv):
                return sum + [kv]
            case .composite(let kvList):
                return sum + convert(attributes: kvList)
            case set(let selector, to: let value):
                return sum + [ViewAttributeValue().build({ $0.key = ViewAttribute(selector); $0.value = value })]
            case .setLayer(let selector, to: let value):
                return sum + [ViewAttributeValue().build({ $0.key = ViewAttribute(layerSetter:selector); $0.value = value })]
            }
        })
    }
}

// MARK:- Selector doesn't work well with code completion in swift, so we preset
// many methods.

// convenient
extension Attribute {

    public static func tapGesture(_ selector:Selector) -> Attribute {
        return .keyAndValue(GestureAttributeValue(tapAction: selector))
    }

    public static func controlAction(event:UIControl.Event, action: Selector) -> Attribute {
        return .keyAndValue(ControlActionAttribute(event: event, action: action))
    }

    // combination of cornerRadius: and clipsToBounds:
    public static func roundCorner(raidus: CGFloat) -> Attribute {
        let list = [self.Layer.cornerRadius(raidus), self.clipsToBounds(true)]
        return .composite(list)
    }

    // only can be applied to UIButton or its subclass
    public static func setButtonTitle(_ title: String?) -> Attribute {
        let key = ViewAttribute(
            identifier: "setTitleForState",
            applicator:
            { (view, value) in
                assert(view is UIButton, "the view must be UIButton or its subclass")
                (view as? UIButton)?.setTitle(value as? String, for: .normal)
        }, updater: { (view, _, newValue) in
            (view as? UIButton)?.setTitle(newValue as? String, for: .normal)
        })
        return .key(key, value: title)
    }
}

// UIView
extension Attribute {
    
    public static func backgroundColor(_ color: UIColor?) -> Attribute {
        return .keyPath(\UIView.backgroundColor, value: color)
    }
    public static func tag(_ v: Int) -> Attribute {
        return .keyPath(\UIView.tag, value: v)
    }
    public static func clipsToBounds(_ v: Bool) -> Attribute {
        return .keyPath(\UIView.clipsToBounds, value: v)
    }
    public static func alpha(_ v: CGFloat) -> Attribute {
        return .keyPath(\UIView.alpha, value: v)
    }
    public static func isOpaque(_ v: Bool) -> Attribute {
        return .keyPath(\UIView.isOpaque, value: v)
    }
    public static func isHidden(_ v: Bool) -> Attribute {
        return .keyPath(\UIView.isHidden, value: v)
    }
    public static func contentMode(_ v: UIView.ContentMode) -> Attribute {
        return .keyPath(\UIView.contentMode, value: v)
    }
    public static func tintColor(_ v: UIColor?) -> Attribute {
        return .keyPath(\UIView.tintColor, value: v)
    }
    public static func tintAdjustmentMode(_ v: UIView.TintAdjustmentMode) -> Attribute {
        return .keyPath(\UIView.tintAdjustmentMode, value: v)
    }
    public static func isUserInteractionEnabled(_ v: Bool) -> Attribute {
        return .keyPath(\UIView.isUserInteractionEnabled, value: v)
    }
    public static func isExclusiveTouch(_ v: Bool) -> Attribute {
        return .keyPath(\UIView.isExclusiveTouch, value: v)
    }
    public static func autoresizingMask(_ v: UIView.AutoresizingMask) -> Attribute {
        return .keyPath(\UIView.autoresizingMask, value: v)
    }
    public static func transform(_ v: CGAffineTransform) -> Attribute {
        return .keyPath(\UIView.transform, value: v)
    }
    
}


// CALayer
extension Attribute {
    
    public struct Layer {
        
        public static func cornerRadius(_ v: CGFloat) -> Attribute {
            return .keyPath(\UIView.layer.cornerRadius, value: v)
        }
        public static func masksToBounds(_ v: Bool) -> Attribute {
            return .keyPath(\UIView.layer.masksToBounds, value: v)
        }
        public static func transform(_ v: CATransform3D) -> Attribute {
            return .keyPath(\UIView.layer.transform, value: v)
        }
        public static func setAffineTransform(_ v: CGAffineTransform) -> Attribute {
            return .setLayer(#selector(CALayer.setAffineTransform(_:)), to: v)
        }
        public static func mask(_ v: CALayer) -> Attribute {
            return .keyPath(\UIView.layer.mask, value: v)
        }
        public static func isOpaque(_ v: Bool) -> Attribute {
            return .keyPath(\UIView.layer.isOpaque, value: v)
        }
        public static func allowsEdgeAntialiasing(_ v: Bool) -> Attribute {
            return .keyPath(\UIView.layer.allowsEdgeAntialiasing, value: v)
        }
        public static func borderWidth(_ v: CGFloat) -> Attribute {
            return .keyPath(\UIView.layer.borderWidth, value: v)
        }
        public static func borderColor(_ v: CGColor?) -> Attribute {
            return .keyPath(\UIView.layer.borderColor, value: v)
        }
        public static func opacity(_ v: Float) -> Attribute {
            return .keyPath(\UIView.layer.opacity, value: v)
        }
        public static func shadowColor(_ v: CGColor?) -> Attribute {
            return .keyPath(\UIView.layer.shadowColor, value: v)
        }
        public static func shadowOpacity(_ v: Float) -> Attribute {
            return .keyPath(\UIView.layer.shadowOpacity, value: v)
        }
        public static func shadowOffset(_ v: CGSize) -> Attribute {
            return .keyPath(\UIView.layer.shadowOffset, value: v)
        }
        public static func shadowRadius(_ v: CGFloat) -> Attribute {
            return .keyPath(\UIView.layer.shadowRadius, value: v)
        }
        public static func shadowPath(_ v: CGPath?) -> Attribute {
            return .keyPath(\UIView.layer.shadowPath, value: v)
        }
        public static func name(_ v: String?) -> Attribute {
            return .keyPath(\UIView.layer.name, value: v)
        }
    }
    
}
