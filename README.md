![alt_text] [appIcon]
# Metadata-fetch-queuing

Application that fetches metadata using serial queue. Implementation of a serial queue using OperationQueue. Runs only one concurrent operation. Refer to [overview](cocoapodsURL)

## Cloning the project 🚴

```
git clone --recursive git@github.com:apple/apple.git
```

## Features 🚀
General overview for the project:
    - Employs MVVM architecture with functional reactive programming.
    - Uses the combine framework for reactive binding.
    - Uses diffable datsource for tableview population.
    - Minimal use of external dependencies, used Kingfisher for image caching.
    - Avoided the use of IBDesignable and IBInspectable inorder to make storyboards a bit light.
    - Unit tested only a small portion of the application.
    - Made sure that there are no constraint breaks and memory leaks

## Areas for improvement
Some notable areas for fixing:
    - Unit testing can be implemented throughout the application with a very significant code coverage.
    - Metadata caching can be done, so we do not have to always make api calls
    
## Links
Here are some of the important links:

Environment | URL
---------------------
staging | www.apple.com
production | www.apple.com

## Other links
Here are a few other links:

- ⏰ [cocoapods](cocoapodsURL)
- 🤟 [carthage](carthageURL)
- 🏁 [fastlane](fastlaneURL):
            - Employs MVVM architecture with functional reactive programming.
            - Uses the combine framework for reactive binding.
            - Uses diffable datsource for tableview population.

Total time: 3 hrs

## License

Closed Source.
Copyright (c) 2018-2019 [Nirvana](https://apple.com)

![alt_text](company-logo)

[company-logo]: https://user-images.githubusercontent.com/14129317/144711920-b5d1e98d-ca77-4b41-aae8-230dbe0528c2.png
[appIcon]: https://user-images.githubusercontent.com/14129317/144711920-b5d1e98d-ca77-4b41-aae8-230dbe0528c2.png
[cocoapodsURL]: https://cocoapods.org
[carthageURL]: https://github.com/Carthage/Carthage
[fastlaneURL]: https://fastlane.tools
[fastlaneMatch]: https://docs.fastlane.tools/actions/match/#match
