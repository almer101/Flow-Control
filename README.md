# Onboarding Prototype
Prototype app which implements the flow of controllers - like onboarding tutorial or even onboarding setup.

This can be used as a template or idea for project where it is needed to have some kind of flow setup and where data from 
ViewControllers in the flow needs to be saved for later to be used in some way (e.g. API call, saving the data locally).

## Flow navigation

In this project the flow of controllers is implemented such that it is independant of the ViewController from which it is
called since the class FlowCoordinator, as its name says, coordinates the flow. More specifically, FlowCoordinator 
determines the order of ViewControllers in the flow. 

### RootViewController

```RootViewController: UINavigationController```

This is where the logic happens.
It is the one which knows how to instantiate ViewController based on their type. Types of flow ViewControllers are specified by enum `FlowControllerType`.

### FlowControllable

```
protocol FlowControllable: class {
    
    var type: FlowControllerType { get set }
    var profile: UserProfile? { get set }
    var delegate: FlowControllerDelegate? { get set }
    
    func setup(with profile: UserProfile?, type: FlowControllerType, delegate: FlowControllerDelegate?)
}
```
Each ViewController in the flow must conform to the ceratain protocol - this way the communication between the 
RootViewController and its "children" is abstracted. Usage of protocols in situations like this is very practical 
since it provides the possibility to change the implementation of the class which conforms to some protocol and the 
way communication will not be disrupted.

Every class which conforms to it is obligated to have the 3 properties which are the type which they represent in the flow, the item which they hold and can edit (in case this is some kind of setup or edit flow) and the delegate to whom they report the changes.

Each of those ViewControllers which show up in the flow will have the same implementation of the `setup(with:type:delegate)` method so we could extend the `FlowControllable` protocol to implement it for every class which conforms to it:

```
extension FlowControllable {
    
    func setup(with profile: UserProfile?, type: FlowControllerType, delegate: FlowControllerDelegate?) {
        self.profile = profile
        self.type = type
        self.delegate = delegate
    }
}
```

### FlowControllerDelegate

Let's take a look at the `FlowControllerDelegate` protocol:

```
protocol FlowControllerDelegate: class {
    
    func flowControllerShouldFinishShowing(_ viewController: UIViewController, with items: [FlowItem])
    func flowControllerShouldSkip(_ viewController: UIViewController)
}
```

## To be continued...
