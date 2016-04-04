# ContainerViewManager

## Usage

### ContainerViewSegueManager

`ContainerViewSegueManager` is responsible for telling your `UIViewController` which segue it should perform.

#### Creating your containerView

After dropping your container into your `UIViewController` you should name its embedSegue identifier:

![Screenshots/EmbedSegueSS.png](Screenshots/EmbedSegueSS.png)

you also need to make sure the embed `UIViewController` custom class is `ContainerViewSegueManager`

![Screenshots/ContainerViewSegueManagerSS.png](Screenshots/ContainerViewSegueManagerSS.png)

and then in your `UIViewController` class override `prepareForSegue:sender:` with references to `ContainerViewSegueManager` and to your `ContainerDataManager` subclass, 
note it's VERY important that you pass your class type and not an object of it!:

```objective-c
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
if ([segue.identifier isEqualToString:@"embedSegue"]) {
self.containerView = (ContainerViewSegueManager*)segue.destinationViewController;
self.containerView.containerDataClass = [CVMViewDataManager class];
}
}
```

Make sure `shouldPerformSegueWithIdentifier:sender:` returns `YES`

```objective-c
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
return YES;
}
```

### EmptySegue

All segues from your `ContainerViewSegueManager` to your `UIViewController` should be of the type `EmptySegue` and have an identifier:

![Screenshots/EmptySegueSS.png](Screenshots/EmptySegueSS.png)

### ContainerDataManager

`ContainerDataManager` is responsible for deciding which `segueIdentifier` should be passed to `performSegueWithIdentifier:sender:` of `ContainerViewSegueManager` based on your application data and needs.

#### Subclassing `ContainerDataManager`

You should create a subclass of `ContainerDataManager` and override the `additionalSetup` method:

`MyContainerDataManager.h`
```objective-c
#import <Foundation/Foundation.h>
#import <ContainerDataManager/ContainerDataManager.h>

@interface CVMViewDataManager : ContainerDataManager

@end
```

#### Choosing which `segueIdentifier` will be used

`ContainerDataManager additionalSetup` method will be overridden by your class implementation. You MUST call `[super additionalSetup]` and `self.currentSegueIdentifier` must NOT be nil.

`MyContainerDataManager.m`
```objective-c
-(void)additionalSetup{
_array = @[@"1",@"2"];

self.currentSegueIdentifier = @"FirstViewController";

if ([_array count] != 0) {
self.currentSegueIdentifier = @"FirstViewController";
self.parent.navigationItem.title = @"FIRST";
}
else {
self.currentSegueIdentifier = @"SecondViewController";
self.parent.navigationItem.title = @"SECOND";
}

[super additionalSetup];
}
```

### Swapping viewController

You can use `ContainerViewSegueManager swapFromViewController:toViewController` to go from one `UIViewController` to another `UIViewController` easily.

```objective-c
UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
CVMFirstViewController *firstView = [storyboard instantiateViewControllerWithIdentifier:@"CVMFirstViewController"];
[ContainerViewSegueManager swapFromViewController:self toViewController:firstView];
```

## Requirements

ContainerViewManager supports iOS 8.3+.

## Installation

ContainerViewManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.3'

pod 'ContainerViewManager', '~> 1.0.5'
```

Then, run the following command:

```bash
$ pod install
```

## Author

Bruno Rendeiro, brurend@hotmail.com.

## License

ContainerViewManager is available under the MIT license. See the [License](https://github.com/brurend/ContainerManager/blob/master/LICENSE.md) file for more info.
