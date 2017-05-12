//
//  Component.swift
//  CKWrapperDemo
//
//  Created by Gao on 23/04/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import Foundation
import CKWrapper
import WrapExisted


class SwiftComponent: CompositeComponent, CKWComponentInitialStateProtocol {

    typealias StateType = Bool

    convenience init?(model:Any) {

        let scope = StateScope(with: type(of: self))

        self.init(scope: scope) { (state) -> Component? in

            InsetComponent(insets: UIEdgeInsetsMake(20, 20, 20, 20),
                           component:

                StackLayoutComponent(
                    style: CKWStackLayoutStyle().build({
                        $0.spacing = 20
                        $0.direction = .horizontal
                    }), children:[

                        StackLayoutChild(
                            Component(
                                view:
                                CKWViewConfiguration(
                                    UIView.self,
                                    attributeEnums:
                                    .set(#selector(setter:UIView.backgroundColor), to: UIColor.brown),
                                    .roundCorner(raidus: 30),
                                    .masksToBounds(),
                                    .tapGesture(#selector(didTap))
                                ),
                                size:.size(60, 60)
                            )
                        ),

                        StackLayoutChild(
                            TextComponent(
                                CKWTextAttributes().build({
                                    $0.attributedString = getText()
                                    $0.maximumNumberOfLines = state ? 0 : 4
                                    $0.truncationAttributedString = NSAttributedString(string:"...")
                                }),
                                viewAttributes:
                                CKWViewAttributeMap(
                                    enums:
                                    .tapGesture(#selector(didTap))
                                )

                            ),
                            flexGrow: true,
                            flexShrink: true
                        )
                    ])
            )

        }

    }

    static func initialState() -> Bool {
        return false
    }

    @objc func didTap(sender: Any) {
        print("tapped")

        self.updateState({ (state) -> Bool in
            !state
        }, asynchronously: true)

    }


}




func getText() -> NSAttributedString {
    let text = "I/O Extended events include a variety of options for developers—from live streaming sessions to local demos, hackathons, codelabs, and more. These events are hosted in your neighborhood by local developer communities."
    let paragraphStyle = NSMutableParagraphStyle()
    let attributeString = NSAttributedString(string: text, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSParagraphStyleAttributeName: paragraphStyle])
    return attributeString
}



