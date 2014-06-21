XMCircleGestureRecognizer
=========================

**XMCircleGestureRecognizer** was written by **[Michael Teeuw](https://twitter.com/michmich)**


## What is it?

An one finger circle gesture recognizer written in swift.

## How to use
Add a XMCircleGestureRecognizer recognizer to your view

    let cgr = XMCircleGestureRecognizer(midPoint: self.view.center, innerRadius:10, outerRadius:200, target: self, action: "rotateGesture:"))
    view.addGestureRecognizer(cgr)
    
Or, of you don't need a minimum and maximum distance to your center point:

    let cgr = XMCircleGestureRecognizer(midPoint: self.view.center, target: self, action: "rotateGesture:"))
    view.addGestureRecognizer(cgr)
    
Add a gesture responder function to your target to respond to the gesture:

    func rotateGesture(recognizer:XMCircleGestureRecognizer)
    {
        if let rotation = recognizer.rotation {
            // rotation is the relative rotation for the current gesture in radians
        }
        
        if let angle = recognizer.angle {
            // angle is the absolute angle for the current gesture in radians
        }
        
        if let distance = recognizer.distance {
            // distance is the absolute distance from the midPoint
        }
    }
    
If you like to transform the values from radians to degrees, simply add ```.rad2deg``` to the variable:

    if let rotation = recognizer.rotation {
        // rotation.rad2deg is the relative rotation for the current gesture in degrees
    }

## So what does it look like?

Check out this [example movie](https://raw.githubusercontent.com/MichMich/XMCircleGestureRecognizer/master/Screenshots/example.mov).

## Disclaimer

This is my fist open source Swift class. So be gentle. ;)

## Contributing

Forks, patches and other feedback are welcome.