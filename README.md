
<p align="center"><img src="/etc/logo.png" width="512"></p>

[![Platform](https://img.shields.io/cocoapods/p/ComponentSwift.svg?style=flat)](http://cocoapods.org/pods/ComponentSwift)
[![Swift](https://img.shields.io/badge/swift-4.2-orange.svg?style=flat)](#)
[![Build Status](https://travis-ci.org/leavez/ComponentSwift.svg?branch=master)](https://travis-ci.org/leavez/ComponentSwift)


ComponentSwift brings ComponentKit to swift.

[ComponentKit](http://componentkit.org) is a react-inspired native view framework for iOS developed by Facebook. It intruduces a new abstract layer (component) to automatically handle view reuse, meanwhile provide the ability to build smooth list view easily. 

ComponentSwift is an objc wrapper of ComponentKit and refined for swift. ComponentSwift is designed to be a subset of ComponentKit, implementing the most commonly used features.

### Example

```Swift
class CellComponent: CompositeComponent {

    init?(text: String) {
        super.init(
            view:
            ViewConfiguration(
                attributes:
                .backgroundColor(.gray),
                .tapGesture(#selector(didTapSelf))
            ),
            component:
            getAnotherComponent(text) //
    }
// ...

```
or try real demo with `pod try ComponentSwift`

## Supported Features
#### Support:
- [x] Component:
  -  almost all build-in components. 
  -  ability to wrap an an existed CKComponent on your own
- [x] Datasource: 
  - CollectionViewTransactionalDatasource
  - TableViewTransactionalDatasource (unofficial) 
  - HostingView
- [x] Response Chain and Actions
- [x] Scope and State
- [x] Animation


#### Not support:
- [ ] component controller and StatefulViewComponent 
- [ ] things about viewContext, mount
- [ ] `computeLayoutThatFits:` overriding
- [ ] ...


### Work with legacy code

Legacy CKComponent classes could continue to work in swift when using ComponentSwift. Classes and methods are provided to wrap your legacy components conveniently. Every attributes in ComponentKit have an equivalent in ComponentSwift. 

Subclass `CSCompositeComponent` and use `initWithCKComponent` in its implementation. Import `ComponentSubclass.h` to use this stuff. Reference more from `WrapExisted` in the demo project.

[more document here](/etc/doc.md)

## TLDR
ComponentKit is implemented and used with objc++, which is pretty cool. It's incompatible with swift, since swift doesn't support objc++. So comes the ComponentSwift.

A objc wrapper is implemented to bridge componentKit to swift. It create an objc version equivalent for every type in componentKit's APIs, objc class for c++ struct/class, hiding the c++ header in the implementation. It doesn't touch deep in componentKit. The runtime code is almost the same to the one using componentKit directly in the simplest situation except for construction of objc layer, so it's safe to use.

It refined the bridged interface for swift, including notating nullability, adding default parameter and swift-only api. C++'s aggregate initialization is very expressive in componentKit. ComponentSwift try hard to simulate the api with default parameters and ExpressibleByXXXLiteral. At least we got code completion here.


## Installation

```ruby
pod "ComponentSwift"
```

Swift version:

- swift 4.2: v0.5
- swift 4.1: v0.4.1 
- swift 3: v0.3

## License

ComponentSwift is available under the MIT license. 




