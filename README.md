# MSRouter
Simple router for UIKit and SwiftUI iOS applications.

This framework provides router for UIKit, SwiftUI and UIKit+SwiftUI iOS applications.
All transitions in application are implemented via standard UIKit navigation stack.

## Features
- [x] Push, present and replace SwiftUI views
- [x] Present SwiftUI view with a custom transition

## Requirements
- iOS 13.0+
- Xcode 12+
- Swift 5.0+

## Installation

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate MSRouter into your Xcode project using CocoaPods, specify it in your `Podfile`:
```ruby
pod 'MSRouter'
```

Import framework to the file to start using it
``` swift
import MSRouter
```

## Usage

### Navigation concept

MSRouter provides router builded on UIKit navigation stack. It means that using MSRouter in your application, you can show SwiftUI view and continue use all well known features of UINavigationController. For successful navigation in project with MSRouter you should:
* Initialise global application router -> [Initial setup](#initial-setup)
* Create a routing destination for screen -> [Routing destination](#routing-destination)
* Create a local router for screen -> [Local router](#local-router)
* Call local router's method from UI with routing destination as a parameters -> [Call from UI](#call-from-ui)
* [optional] Celebrate your first transition with MSRouter


### Initial setup

Instantiate MSRouter before setting `keyWindow` of application and pass window to it.
```Swift
if let windowScene = scene as? UIWindowScene {
    let window = UIWindow(windowScene: windowScene)
    MSRouter.default.initialSetup(window: window)
    self.window = window
}
```

Set `rootViewController` before making window key and visible with MSRouter's public methods.
```Swift
let contentView = ContentView(viewModel: ContentViewModel()).castToAnyView()
let presentingView: MSPresentingView = .navigationController(.viewController(contentView))
let viewController = MSRouter.default.buildViewController(presentingView: presentingView)

MSRouter.default.navigate(viewController: viewController, presentationStyle: .replaceRoot)

window.makeKeyAndVisible()
```

### Routing destination

Create a routing destination for each screen and subscribe on `MSRoutingDestinationProtocol` protocol to pass it in `MSRouter` later. Create enum for each screen where each case will be a route to next screen. To pass the data use parameters of enum's case. For example, routing to `DetailView` in 'Example' project and passing UIColor will look like this:
```Swift
enum DetailDestination: MSRoutingDestinationProtocol {
    case detailView(color: UIColor)
}
```

With MSRouter is very easy to navigate to SwiftUI view and UIKit controller.
- To show SwiftUI view as a next screen for route implement `MSRoutingViewProviderProtocol` protocol:
    ```Swift
    extension DetailDestination: MSRoutingViewProviderProtocol {
        var destinationView: AnyView {
            switch self {
            case let .detailView(color):
                let viewModel = DetailViewModel(color: color)
                return DetailView(viewModel: viewModel).castToAnyView()
            }
        }
    }
    ```

- To show UIViewController as a next screen for route implement `MSRoutingControllerProviderProtocol` protocol:
    ```Swift
    extension ControllerDestination: MSRoutingControllerProviderProtocol {
        var viewController: UIViewController {
            let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.main)
            let viewController: SimpleViewController

            viewController = storyboard.instantiateViewController(identifier: "SimpleViewController")

            return viewController
        }
    }
    ```

### Local router
// TODO: Push, present, custom transition

### Call from UI
// TODO: implement

### License
MSRouter is released under the MIT license. See [LICENSE](https://github.com/MsMobileDev/MSRouter/blob/development/LICENSE) for details.
