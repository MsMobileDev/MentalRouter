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

MSRouter provides router builded on UIKit navigation stack. It means that using MSRouter you can use SwiftUI views and all well-known features of UINavigationController together. For successful navigation in project with MSRouter you should:
* Initialise global application router -> :link:[Initial setup](#initial-setup)
* Create a routing destination for screen -> :link:[Routing destination](#routing-destination)
* Create a local router for screen -> :link:[Local router](#local-router)
* Call local router's method from UI with routing destination as a parameters -> :link:[Call from UI](#call-from-ui)
* [optional] :ghost: Celebrate your first transition with MSRouter


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

Create a routing destination for each screen and subscribe on `MSRoutingDestinationProtocol` protocol to pass it in `MSRouter` later. Create enum for each screen where each case will be a route to next screen. To pass the data use parameters of enum's case. For example, routing to `DetailView` in [Example project](https://github.com/MsMobileDev/MSRouter/tree/master/Example) and passing UIColor will look like this:
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
Create a local router for a screen.
```Swift
final class DetailRouter {
    private let router: MSRouter

    init(router: MSRouter) {
        self.router = router
    }
}
```

Implement `MSRouterProtocol` protocol in local router to be ready for any transition. Pass  ***.push***, ***.present***, ***.replaceRoot*** or ***.custom*** presentation style to parameter `MSPresentationStyle` to modify appearence of transaction.
```Swift
// MARK: RouterProtocol
extension DetailRouter: MSRouterProtocol {
    typealias MSRoutingDestination = MSRoutingDestinationProtocol & MSRoutingViewProviderProtocol

    func route(destination: MSRoutingDestination, presentationStyle: MSPresentationStyle) {
        let view = destination.destinationView
        let viewController = router.buildViewController(presentingView: .viewController(view))

        // Configure navigationItem here if it's needed

        router.navigate(viewController: viewController, presentationStyle: presentationStyle)
    }
}
```

### Call from UI
Call local router with appropriate destination on user action.
```Swift
Button(action: {
    let destination = DetailDestination.detailView(color: .red)
    DetailRouter(router: .default).route(destination: destination, presentationStyle: .push)
}, label: {
    Text("Show detail view")
})
```
Or incapsulate this logic in view's view model to follow MVVM paradigm. The example of such implementation you can find in [Example project](https://github.com/MsMobileDev/MSRouter/tree/master/Example).

### Custom transition
Create class for animated transaction.
```Swift
final class ScaleTransition: NSObject {
    var scale: CGFloat
    var center: CGPoint
    var duration: TimeInterval
    var delay: TimeInterval

    private lazy var fadeDuration: TimeInterval = duration / 3

    // Create initialiser
}
```

Implement `UIViewControllerAnimatedTransitioning` protocol to implement custom animation.
```Swift
extension ScaleTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        self.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewController = transitionContext.viewController(forKey: .from) else {
            return transitionContext.completeTransition(false)
        }

        // Set the view frame for UIHostingViewController
        toViewController.view.frame = fromViewController.view.bounds

        // Find the first and second view controller in a transaction
        let screenView: UIView! = self.scale >= 1 ? toViewController.view : fromViewController.view

        // Set initial animation state here

        UIView.animateKeyframes(withDuration: duration, delay: delay, options: .calculationModeCubic) {
            // Animate transition
        } completion: { completed in
            transitionContext.completeTransition(completed)
        }
    }
}
```
In [Example project](https://github.com/MsMobileDev/MSRouter/tree/master/Example) there is an example of scale transition from current point. It is implemented in [ScaleTransition file](https://github.com/MsMobileDev/MSRouter/blob/master/Example/MSRouterExample/Sources/Helpers/ScaleTrasition.swift).

Pass instance of `ScaleTrasition` to ***.custom*** MSPresentationStyle as a parameter of local router method.
```Swift
let destination = DetailDestination.detailView(color: .red)
let transition = MSNavigationTransition(
        presented: ScaleTransition(duration: 0.6, scale: 1.0, center: viewCenter),
        dismissed: ScaleTransition(duration: 0.6, scale: 0.0, center: viewCenter)
    )

DetailRouter(router: .default)
    .route(destination: destination, presentationStyle: .custom(transition: transition))
```
:warning:
`ScaleTrasition` get parameter 'center' which is a center of a tapped view. To get layout information of current view in SwiftUI Apple provides us: `GeometryReader` or `PreferenceKey`. The example of using the last one is shown in [RectModifier file](). Search for explanation of both approaches in articles in IT community, now there are a lot of them.

### License
MSRouter is released under the MIT license. See [LICENSE](https://github.com/MsMobileDev/MSRouter/blob/master/LICENSE) for details.
