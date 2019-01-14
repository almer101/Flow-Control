# Onboarding Prototype
Prototype app which implements the flow of controllers - like onboarding tutorial or even onboarding setup.

This can be used as a template or idea for the project where it is needed to have some kind of flow setup and where data from 
ViewControllers in the flow needs to be saved for later to be used in some way (e.g. API call, saving the data locally).


## Flow navigation

In this project the flow of controllers is implemented such that it is independent of the ViewController from which it is
called since the class FlowCoordinator, as its name says, coordinates the flow. More specifically, FlowCoordinator determines the order of ViewControllers in the flow. 


### RootViewController

```RootViewController: UINavigationController```

This is where the logic happens.
It is the one which knows how to instantiate ViewController based on their type. Types of flow ViewControllers are specified by enum `FlowControllerType`.

`RootViewController` has a setup method which is called to set up the types (`FlowControllerType`) of `FlowControllable` objects and the `completion` block which will be executed once the flow comes to an end. 
Passed `FlowControllerType`s are types of objects which will be presented to the user in some form (can be ViewControllers, Alerts etc.).


### FlowControllable

```
protocol FlowControllable: class {

    var type: FlowControllerType { get set }
    var profile: UserProfile? { get set }
    var delegate: FlowControllerDelegate? { get set }

    func setup(with profile: UserProfile?, type: FlowControllerType, delegate: FlowControllerDelegate?)
}
```
Each ViewController in the flow must conform to the certain protocol - this way the communication between RootViewController and its "children" is abstracted. Usage of protocols in situations like this is very practical 
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

`FlowItem` consists only of its type `FlowItemType` which is an enum with associated values. Value of the item is transferred as an associated value of that enum. There is nothing complex here :)
Keep in mind all these types are here just for example and can be replaced with your own types which are suitable for your case.



### FlowControllerDelegate

Let's take a look at the `FlowControllerDelegate` protocol:

```
protocol FlowControllerDelegate: class {

    func flowControllerShouldFinishShowing(_ flowControllable: FlowControllable, with items: [FlowItem])
    func flowControllerShouldSkip(_ flowControllable: FlowControllable)
}
```

This protocol is how `FlowControllable`s will report changes to their `delegate`. It is the "contract" between the delegate and the `FlowControllable` how the communication will be conducted.

If the user wishes to skip the current `FlowControllable` object in the flow, it will call its delegate method `flowControllerShouldSkip(_:)`, notice how this is independent on the implementation of skip feature in the presented `FlowControllable` it can be button, it could be some gesture which means "skip this view controller", it can be whatever, but when it happens, `delegate` gets informed about it and will undertake actions to handle this event.

`FlowControllable` objects can also have some kind of data entry (e.g. text fields, drop-down menus...), so user chooses some options, enters his info or whatever - now when the user is done with that, we want to save the data temporarily until the whole process is finished. This is where `flowControllerShouldFinishShowing(_:with:)` has its purpose - the `FlowControllable` has a duty to collect the data user entered and wrap each part of data in `FlowItem`. 

Since data can consist of more parts sometimes more `FlowItem`s may be needed to wrap all data. There is no problem with that since `flowControllerShouldFinishShowing(_:with:)` gets an array of `FlowItem`s as a parameter (`[FlowItem]`). The delegate will then do the rest of the work to handle the event. 

It will most likely hang on to the data until the whole flow finishes and then pass all gathered data to `completion` block provided in the `setup(with:completion:)` method. 

## End of the flow

Once the `RootViewController` determines that the end of the flow is reached it has to do final operations if needed and call, already mentioned, `completion` block. When this happens, `RootViewController`'s job is done and it is not anymore needed.

