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

## Passing data between controllers

### FlowControllerDelegate

Let's take a look at the `FlowControllerDelegate` protocol:

```
protocol FlowControllerDelegate: class {
    
    func flowControllerShouldFinishShowing(_ viewController: UIViewController, with items: [FlowItem])
    func flowControllerShouldSkip(_ viewController: UIViewController)
}
```
From now on I will address the ViewControllers in the flow as `FlowViewController` just for easier understanding. So `RootViewController` has on his view controller stack multiple `FlowViewController`s.

This protocol is how `FlowViewController`s will report changes to their `delegate`. It is the "contract" between the delegate and the `FlowViewController` how the communication will be conducted.

If user wishes to skip the current ViewController in the flow, it will call its delegate method `flowControllerShouldSkip(_:)`, notice how this is independant on the implementation of skip feature in the presented `FlowViewController` it can be button, it could be some gesture which means "skip this view controller", it can be whatever, but when it happens, `delegate` gets informed about it and will undertake actions to handle this event.

`FlowViewController` can also have some kind of data entry (e.g. text fields, drop down menus...), so user chooses some options, enters his info or whatever - now when user is done with that, we want to save the data temporarily until the whole process is finished. This is where `flowControllerShouldFinishShowing(_:with:)` has its purpose - the `FlowViewController` collects the data user entered and wraps each part of data in `FlowItem`. Since data can consist of more parts sometimes more `FlowItem`s are needed to wrap all the data. There is no problem with that since `flowControllerShouldFinishShowing(_:with:)` gets an array of `FlowItem`s as parameter (`[FlowItem]`). Delegate will then do the rest of the work to hand such event as saving data locally until the while process finishes.

### FlowItem and FlowItemType

```
struct FlowItem {
    let type: FlowItemType
}
```
```
enum FlowItemType {
    case firstName(String)
    case lastName(String)
    case company(String)
    case mood(String)
    case hasBeacon(Bool)
}
```

`FlowItem` consist only of its type `FlowItemType` which is an enum with associated values. Value of the item is transfered as an associated value of the enum `FlowItemType`. There is nothing complex here :)
Keep in mind all these types are just an example for the problem I had and can be replaced with your own types which are suitable for your case.


