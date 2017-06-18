//
//  ViewAttributes+Convenience.swift
//  Pods
//
//  Created by Gao on 27/04/2017.
//
//

import Foundation

extension ViewClass {

    @nonobjc
    public convenience init(factory: @escaping @convention(c) () -> UIView,
                            didEnterReusePool: CSViewReuseBlock? = nil,
                            willLeaveReusePool: CSViewReuseBlock? = nil) {
        self.init(__factory: factory, didEnterReusePool: didEnterReusePool, willLeaveReusePool: willLeaveReusePool)
    }
}


extension ViewAttribute {
    @nonobjc
    public convenience init(identifier: String,
                            applicator: @escaping (_ view: Any, _ value: Any) -> Void,
                            unapplicator:((_ view: Any, _ value: Any) -> Void)?                     = nil,
                            updater:     ((_ view: Any, _ oldValue: Any, _ newValue: Any) -> Void)? = nil) {

        self.init(__identifierString:identifier, applicator:applicator, unapplicator:unapplicator, updater:updater)
    }

}

extension ViewAttributeMap {

    public convenience init(_ attributes: Attribute...) {
        self.init(attributes:attributes);
    }
    public convenience init(attributes: [Attribute] ) {
        self.init(Attribute.convert(attributes: attributes))
    }
}



extension ViewConfiguration {

    public convenience init(_ cls: AnyClass?, attributeMap: ViewAttributeMap? = nil) {
        self.init(viewClass: cls.map(ViewClass.init), viewAttributeMap: attributeMap)
    }

    public convenience init(_ cls: AnyClass = UIView.self, attributes: Attribute... ) {
        self.init(cls, attributes: attributes)
    }

    public convenience init(_ cls: AnyClass = UIView.self, attributes: [Attribute] ) {
        self.init(viewClass: ViewClass(cls), viewAttributeMap: ViewAttributeMap(attributes:attributes))
    }

    public convenience init(_ cls: ViewClass, attributes: [Attribute] ) {
        self.init(viewClass: cls, viewAttributeMap: ViewAttributeMap(attributes:attributes))
    }

}


extension LayoutDimension: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {

    public convenience init(_ value: CGFloat) {
        self.init(point: value)
    }
    public static func p(_ value: CGFloat) -> LayoutDimension {
        return LayoutDimension(point: value)
    }
    public static func percent(_ value: CGFloat) -> LayoutDimension {
        return LayoutDimension(percent: value)
    }
}


extension LayoutSize: Builder {}
extension LayoutSize {

    public convenience init(size: CGSize) {
        self.init(cgSize: size)
    }
    public convenience init(width: LayoutDimension? = nil,
                     height:LayoutDimension? = nil,
                     minWidth: LayoutDimension? = nil,
                     maxWidth: LayoutDimension? = nil,
                     minHeight: LayoutDimension? = nil,
                     maxHeight: LayoutDimension? = nil) {
        self.init()
        self.width = width
        self.height = height
        self.minWidth = minWidth 
        self.maxWidth = maxWidth 
        self.minHeight = minHeight 
        self.maxHeight = maxHeight 
    }


    public static func size(_ size: CGSize) -> LayoutSize {
        return LayoutSize(cgSize: size)
    }
    public static func size(_ width: CGFloat, _ height: CGFloat) -> LayoutSize {
        return LayoutSize(cgSize: CGSize(width: width, height: height))
    }
    public static func height(_ h: CGFloat) -> LayoutSize {
        let s = self.init()
        s.height = .p(h)
        return s
    }
    public static func width(_ w: CGFloat) -> LayoutSize {
        let s = self.init()
        s.width = .p(w)
        return s
    }
}

