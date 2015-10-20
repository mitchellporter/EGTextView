## EIGTextView

UITextView subclasses with an attributed placeholder that change into floating labels when the fields are populated with text.Released under the [MIT license](LICENSE.txt).

*Used by millions of people in the their apps!* Is your app using it? [Let me know!](mailto:lihao_ios@hotmail.com)


![(example)](https://github.com/LiHaofromChina/EIGTextView/blob/master/Example/EIGTextView/example.gif)


## Usage
Please see the included example app for sample usage.

``` objc
// Initialize a text view
EIGTextView *textview = [[EIGTextView alloc]initWithFrame:CGRectMake(0.f, 0.f, 200.f, 200.f)];

// Add a placeholder
textview.placeHolder = [self someAttributedString];
```

For more advanced control of the placeholder, you can set the `placeHolder` property instead. See the [header](EIGTextView/EIGTextView.h) for full documentation.

### Supports: 

ARC & iOS 7+, Autolayout or springs and struts

## Installation

Simply add the files in the `EIGTextView.h` and `EIGTextView.m` to your project or add `EIGTextView` to your Podfile if you're using CocoaPods.
