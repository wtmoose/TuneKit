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
[TuneKit presentControlPanel];
```
    
You can drag the control panel around the screen, collapse it, or dismiss it (well actually, right now you can only dismiss it). But it is designed to remain on screen while the app is in use.

Content is added to the control panel using the various `add` methods:

```Objective-C
[TuneKit addButton:@"Run Animation" target:self selector:@selector(runAnimation)];
[TuneKit addSlider:@"Duration" target:self keyPath:@"animationDuration" min:0.25 max:3];
[TuneKit addSlider:@"Delay" target:self keyPath:@"animationDelay" min:9 max:3];
[TuneKit addColorPicker:@"Color" target:self keyPath:@"animationView.backgroundColor"];
```

Content is removed from the control panel using:
```Objective-C
// Remove the color picker
[TuneKit removePath:@"Color"];

// Remove everything
[TuneKit removePath:nil];
```

TuneKit is meant to support hierarchical configuration, but currently only supports flat paths specified as strings as illustrated above.

##Installation

Use CocoaPods. The podspec is not published, so you'll need to point to the GitHub repo:

    pod 'TuneKit', :git => 'https://github.com/wtmoose/TuneKit.git'

##Examples

See the Examples workspace.
