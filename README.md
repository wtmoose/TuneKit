#TuneKit

TuneKit lets you modify the look and feel of your iOS app in real time. Tune animations, colors, etc. and get instant feedback.

The current state of this project is very experimental. _APIs or even the name of the project may change drastically_. Check back later for a more stable version.

##Overview

First, enable TuneKit, for example in your app's delegate:

```Objective-C
[TuneKit enable];
```
    
Then display the control panel, for example, when an admin button is tapped:

```Objective-C
[TuneKit presentControlPanelAtLeftOrigin:];
```
    
You can drag the control panel around the screen, collapse it, or dismiss it (well actually, right now you can only drag and dismiss it). But it is designed to remain on screen while the app is in use.

Content is added to the control panel using the various `add` methods after setting default values for the tunable parameters:

```Objective-C
// set default values for tunable parameters
self.animationDuration = 0.65;
self.animationDampingRatio = 0.3;
self.animationScale = 0.75;
self.animationView.backgroundColor = [UIColor colorWithHexRGB:0x1694AE];

// add a button to start the animation
[TuneKit addButton:@"Run Animation" target:self selector:@selector(runAnimation)];

// add a slider to adjust the animation duration
[TuneKit addSlider:@"Duration" target:self keyPath:@"animationDuration" min:0.1 max:1.5];

// add a slider to adjust the animation damping ratio (for a spring animation)
[TuneKit addSlider:@"Damping Ratio" target:self keyPath:@"animationDampingRatio" min:0 max:1];

// add a slider to adjust the animation scale factor
[TuneKit addSlider:@"Scale" target:self keyPath:@"animationScale" min:0.25 max:1.25];

// add a color picker to set the animation view's color
[TuneKit addColorPicker:@"Color" target:self keyPath:@"animationView.backgroundColor"];

// present the control panel (automatically)
[TuneKit presentControlPanel];
```

Then somewhere in the view controller, the `runAnimation` method would be defined like:

```Objective-C
- (void)runAnimation
{
    CGFloat width = self.animationViewWidth.constant;
    CGFloat height = self.animationViewHeight.constant;
    
    // bounce
    [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:self.animationDampingRatio initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.animationViewWidth.constant = width * self.animationScale;
        self.animationViewHeight.constant = height * self.animationScale;
        [self.animationView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        // bounce back
        [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:self.animationDampingRatio initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            self.animationViewWidth.constant = width;
            self.animationViewHeight.constant = height;
            [self.animationView layoutIfNeeded];
            
        } completion:nil];
        
    }];
}
```

Content can be organized hierarchically using a block-based syntax and providing an array of strings representing the path:

```Objective-C
[TuneKit add:^{
    
    // add content here

} inPath:@[@"Animation Example"]];
```

Content is removed from the control panel using:
```Objective-C
// Remove the animation example
[TuneKit removePath:@[@"Animation Example"]];

// Remove everything
[TuneKit removePath:nil];
```

Typically, one would add and remove content as view controllers appear and disappear, respectively.

##Installation

Use CocoaPods. The podspec is not published, so you'll need to point to the GitHub repo:

    pod 'TuneKit', :git => 'https://github.com/wtmoose/TuneKit.git'

##Examples

See the Examples workspace.
