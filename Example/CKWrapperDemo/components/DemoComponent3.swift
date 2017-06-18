//
//  DemoComponent3.swift
//  ComponentSwiftDemo
//
//  Created by Gao on 18/06/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import Foundation
import ComponentSwift

class DemoComponent3: CompositeComponent {

    init?() {
        super.init(component:
            VerticalStackComponnet(
                RatioLayoutComponent(
                    ratio: 0.8,
                    size: LayoutSize().build({
                        $0.maxWidth = .p(200)
                    }),
                    component:
                    ImageComponnet(image: UIImage(named: "gorilla.jpg"))
                ).stackLayoutChild.alignSelf(.end)
            )
        )
    }
}
