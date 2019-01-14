# onboardingPrototype
Prototype app which implements the flow of controllers - like onboarding tutorial or even onboarding setup.

This can be used as a template or idea for project where it is needed to have some kind of flow setup and where data from 
ViewControllers in the flow needs to be saved for later to be used in some way (e.g. API call, saving the data locally).

## Flow navigation

In this project the flow of controllers is implemented such that it is independant of the ViewController from which it is
called since the class FlowCoordinator, as its name says, coordinates the flow. More specifically, FlowCoordinator 
determines the order of ViewControllers in the flow. 

There is a class RootViewController which is a subclass of the UINavigationController - this is where the logic of

Each ViewController in the flow must conform to the ceratain protocol - this way the communication between the 
RootViewController and its "children" is abstracted. Usage of protocols in situations like this is highly effective 
since it provides the possibility to change the implementation of the class which conforms to some protocol and the 
way communication will not be disrupted.
