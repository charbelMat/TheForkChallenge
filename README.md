# TheForkChallenge

![alt text](https://github.com/charbelMat/TheForkChallenge/blob/main/TheForkChallengeScrennshot.png?raw=true)

- This application lists all the restaurants fetched from this URL: https://alanflament.github.io/TFTest/test.json and displays relevent data
- Each restaurant can be added or removed as favorite
- The list can be sorted by name and by rating score

- The architecture used is MVC considering the size of the application
 

## Preparing  IDE

### Installing Cocoapods

- Open Terminal
- Enter command: `sudo gem install cocoapods`
- Enter your password

> Wait for this to finish, don't touch your terminal.  It might take a couple minutes

- Run command `pod setup`

### Installing Dependencies

Now we're going to integrate our libraries into the Xcode project.

- Close Xcode Project
- Open Terminal
- Enter command `cd ~/path/to/your/project`
- Enter command `pod install`

> Wait for this to finish, depending on the requirements of the `Podfile`, particularly with new projects, this may take a minute or two.  Just leave it.

When cocoapods is done installing libraries, you will get a terminal readout that says:

>[!] From now on use `The Fork.xcworkspace`.

This app uses :

- RealmSwift is used as a local database to be able to save and get the old statistics. Realm is chosen over Core Data because it is faster.
https://cocoapods.org/pods/RealmSwift
- Alamofire is used for api requests
https://cocoapods.org/pods/alamofire
- SwiftyJSON is used to parse JSON fetched responses easily
https://cocoapods.org/pods/SwiftyJSON
- SDWebImage is load and display images URLs as it supports more formats than any other library and its tested and stable.
https://cocoapods.org/pods/SDWebImage

