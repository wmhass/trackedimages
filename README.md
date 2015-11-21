## About

I, William Hass, created this project as a sample project that tracks the user's location and shows him pictures of places that he passed by, in order to proof some code concepts and implementations.

This README file explains the development process of the whole project.


## Architecture

The code architecture used  in this project is based on the [VIPER](https://www.objc.io/issues/13-architecture/viper/) architecture. This architecture provides a clear separation for business logic, view related code and navigation. In this project the Apple's `Storyboard` was used, so, the navigation separation layer wasn't necessary. The most crucial and important classes are described below:

- `InitialViewInteractor.h`: This class takes care of data only code. It is its responsibility to request the data from the webserver and returns to its delegate. It doesn't know anything about the rest of the application, it just get the data, load the models and return them by a delegate call.

- `InitialViewControllerPresenter.h`: This class receives calls from the view controller, and holds all the application's business logic. It communicates with the interactor to fetch the data that will be presented, and tells to its `delegate` (which is the `InitialViewController` in this project) when the data is available and when other important business logic events occurs.

- `InitialView.m`: This is a `UIView` subclass holds just view related code. It is its responsibility to animate, hide and customize views. Doing so, makes the view controller more clear, since it will never touch directly on views.

- `CustomLocationManager.h`: This is a `CLLocationManager` subclass. It is responsible to configure itself location parameters, and track the user's location. Once the location is obtained, it calls its delegate passing the location as a parameter.


## Technical specs

- `InitialViewInteractor`
    - In the way the app is designed, this class will request data every time the user moves at least 100 meters. In case the user is moving super fast, a big amount of requests can be done. Do minimize possible issues, this class has it's own queue, `com.TrackedPictures.DownloadPicturesQueue` queue, which is a serial queue that will dispatch the next thread just when the last one has finished. This is a good approach not only to reduce the number of simultaneous requests, but since those requests will end up updating the view, it avoids simultaneous view's updates, which could potentially mess up some animations.


- `PanoramioPictureTableViewCell+PanoramioPicture`
    - This is a category of the `PanoramioPictureTableViewCell` class, which is a subclass of `UITableViewCell` and is the cell we present on our photo's list. Since the cell shouldn't communicate with the models (`PanoramioPicture` and `PanoramioPictureOwner`) and also will not makes sense to add logic to setup the cell with the model data in the view controller, this category was created to hold exactly and only the logic to get a model and populate the cell's views with the properly data.

## Miscellaneous

- Class' categories in implementation files:
    - If you notice, all classes that are implementing a protocol, they actually have a category inside its implementation. This is `Swift` like coding style, where the protocols implementation lives in a extension. Though it can be a bit odd to have categories in the same file as the class' implementation, it improves the code's readability, since each protocol's implementation will live in a specific category for that. You can se an example of this implementation in the `InitialViewController.m` file, where we one category for each of these protocols implementation: `UITableViewDelegate`, `UITableViewDataSource` and `InitialViewControllerPresenterDelegate`.

- Resizable table view cell:
    - If you run the you will notice some cells can have a different height based on its content. This was simply made using one object of `PanoramioPictureTableViewCell` that is used for sizing only purpose. As we have a category that setup the cell's data, it makes really easy to populate the cell every time the tableview asks its delegate for the height of the cell at a index path. We simply have to force the cell to layout and then use the `contentHeight` to returns the necessary size to fit its content
