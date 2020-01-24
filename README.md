# Coffee-With-Intercom
A simple iOS application that reads all the customers from a .txt file and invites all the customers withing 100km range of Intercom office in Dublin.

# Steps to run the app
1. Clone the project and switch to dev branch.
2. Open terminal and run the command ```pod install``` or ```pod update``` (If you need to update your version of cocoapods)
Install cocoapods ```$ sudo gem install cocoapod```. Refer here: https://guides.cocoapods.org/using/getting-started.html
3. Open ```Coffee With Intercom.xcworkspace``` and run the app on any iOS device or iOS simulator.

# Distance formula - Approach
1. Initially, the method ```CLLocation.distance(from: CLLocation)``` was used to get the distance between each and Intercom's Dublin office.
2. After sudying and understanding the distance formula given by the ```spherical law of cosines``` (https://en.wikipedia.org/wiki/Great-circle_distance), the same implementation was done in Swift. Below is the code snippet for reference:
```
func distanceBetween(latitude1: Double, longitude1: Double, latitude2: Double, longitude2: Double) -> Double {
    let radius: Double = 6378.137.toRadians() // earth's radius in km
        
    let lat1Rad = latitude1.toRadians()
    let lng1Rad = longitude1.toRadians()
    let lat2Rad = latitude2.toRadians()
    let lng2Rad = longitude2.toRadians()
        
    let absLngDiff = abs(lng1Rad - lng2Rad)
        
    let centralAngle = acos(sin(lat1Rad) * sin(lat2Rad) + cos(lat1Rad) * cos(lat2Rad) * cos(absLngDiff))
    let distance = radius * centralAngle
        
    return distance.toDegrees() // Distance in km
}
```

The distance calculated from the above formula was test by comparing with the distance result using ```CLLocation.distance(from: CLLocation)``` and the results matched 🥳.
