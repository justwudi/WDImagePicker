WDImagePicker
=============
Ever wanted a custom crop area for the UIImagePickerController? Now you can have it with _WDImagePicker_. Just set your custom crop area and that's it. Just 4 lines of code. If you don't set it, it uses the same crop area as the default UIImagePickerController.

### Installation

#### CocoaPods

```ruby
use_frameworks!

pod 'WDImagePicker', :git => 'https://github.com/justwudi/WDImagePicker.git', :tag => '0.2.2'
```
and run `pod install`

#### Manually

- just drag and drop the files in under "Classes" into your project.
- look at the sample code below.
- this project contains a sample project as well, just have a look at the implementation of `ViewController.swift`

### Sample Code

```swift
self.imagePicker = WDImagePicker()
self.imagePicker.cropSize = CGSizeMake(280, 90)
self.imagePicker.delegate = self

self.presentViewController(self.imagePicker.imagePickerController, animated: true, completion: nil)
```

This code results into the following controller + crop area:

![Sample Crop Image](https://raw.githubusercontent.com/justwudi/WDImagePicker/master/screenshot1.png)

It's even possible to let the user adjust the crop area by setting one additional property:

```swift
self.imagePicker.resizeableCropArea = true
```

This code results into the following controller + adjustable crop area:

![Sample Crop Image Adjustable](https://raw.githubusercontent.com/justwudi/WDImagePicker/master/screenshot2.png)

### License
Under MIT. See license file for details.



