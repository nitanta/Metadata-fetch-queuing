# Metadata-fetch-queuing

Application that fetches metadata using serial queue. Implementation of a serial queue using OperationQueue. Runs only one concurrent operation.

## Features

    Employs MVVM architecture with functional reactive programming.
    Uses the combine framework for reactive binding.
    Uses diffable datsource for tableview population.
    Minimal use of external dependencies, used Kingfisher for image caching.
    Avoided the use of IBDesignable and IBInspectable inorder to make storyboards a bit light.
    Unit tested only a small portion of the application.
    Made sure that there are no constraint breaks and memory leaks

## Areas for improvement

    Unit testing can be implemented throughout the application with a very significant code coverage.
    Metadata caching can be done, so we do not have to always make api calls

Total time: 3 hrs
