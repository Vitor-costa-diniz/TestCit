# TestCit
## Project Overview
This repository was created as part of a technical test for CI&T. The task was to build a simple app that consumes an API of the candidate's choice, displaying a list of results and a detail screen when tapping on a list item, showing more information.  

For this project, the chosen API was [JSONPlaceholder](https://jsonplaceholder.typicode.com).  

The app was implemented following the **MVVM architecture** to separate concerns and improve maintainability. Tests were also created to ensure proper API consumption and to simulate user flows, validating the overall user experience.

## Instructions to run the application

1. Clone este repositório:  
   ```bash
   git clone https://github.com/Vitor-costa-diniz/TestCit.git
   cd TestCit

2. Open the project using Xcode.
3. Run the app on the desired simulator or device.

## Architectural overview and decisions discussion
1. 


## Libraries and tools used (and why)
* SwiftUI
    * SwiftUI was chosen to build the user interface due to my prior familiarity with the framework and its modern declarative syntax. Its powerful state management system allows for effortless handling of reactive updates, making the UI both robust and maintainable.

* URLSession
    * URLSession is used to perform requests to external APIs. It was selected because it is a native Swift API, which ensures reliability and long-term support. By using a built-in tool, the project avoids dependency on third-party libraries that could become deprecated, minimizing the need for future refactoring and ensuring a more stable codebase.

* XCTest
    * XCTest is the primary testing framework used in this project. I chose it because of my familiarity and its seamless integration with Xcode. It provides a stable and well-documented environment for unit and integration tests, eliminating the need for additional external testing libraries and ensuring consistent test execution across the project.

* SnapshotTesting(external lib)
    * SnapshotTesting is an external library used for UI and user flow testing. It was chosen due to its simplicity and practicality, allowing quick validation of visual components and interactions. Moreover, it is a well-established and widely adopted tool in the iOS community, providing confidence that tests will remain reliable and maintainable over time.


## What you would improve with more time
* Implement an internal list of `posts` and `comments` to serve as a fallback in case of API request failures. This would ensure that the user does not see only an error message, but can still experience the app’s normal functionality, simulating real usage.

* Add a separate tab for favorited posts. This would require implementing a database service to store the user’s saved posts. `CoreData` could be used as the persistent layer, following the `Repository` pattern to abstract data access..

* Enable the user to create new posts directly within the app, with these posts automatically saved and displayed in the favorites tab.