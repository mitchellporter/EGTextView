## EIGTextView

UITextView subclasses with an attributed placeholder that change into floating labels when the fields are populated with text.Released under the [MIT license](LICENSE.txt).


*Used by millions of people in the their apps!* Is your app using it? [Let me know!](mailto:lihao_ios@hotmail.com)


![(example)](https://github.com/LiHaofromChina/EIGTextView/blob/master/Example/EIGTextView/example.gif)




## Usage
Please see the included example app for sample usage.

``` swift
// Initialize a text view
let textview: EGTextView = EGTextView.init(frame: CGRectMake(20.0, 20.0, UIScreen.mainScreen().bounds.size.width - 40.0, 180.0), textContainer: nil)
// Add a placeholder
textview.placeHolder = placeHolder()
textview.maximumHeight = 500.0
textview.minimumHeight = 100.0
self.view.addSubview(textview)
```



For more advanced control of the placeholder, you can set the `placeHolder` property instead. See the [header](EGTextView/EGTextView/EGTextView.swift) for full documentation.

There are also Objective-C version:   [EIGTextView](https://github.com/eggswift/EGTextView)

### Supports: 

ARC & iOS 7+, Autolayout or springs and struts

## Installation

Simply add the files in the `EIGTextView.swift` to your project or add `EIGTextView` to your Podfile if you're using CocoaPods.
