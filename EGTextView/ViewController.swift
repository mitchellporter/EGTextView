//
//  ViewController.swift
//  EGTextView
//
//  Created by lihao on 15/10/20.
//  Copyright © 2015年 Egg Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textview1: EGTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let textview : EGTextView = EGTextView.init(frame: CGRectMake(20.0, 20.0, UIScreen.mainScreen().bounds.size.width - 40.0, 180.0), textContainer: nil)
        textview.placeHolder = placeHolder()
        self.view.addSubview(textview)
        textview.layer.borderWidth = 1.0
        */
        textview1.placeHolder = placeHolder()
        textview1.maximumHeight = 500
        textview1.minimumHeight = 100
        textview1.layer.borderWidth = 1.0
        
    }
    
    func placeHolder() -> NSAttributedString {
        let string : NSMutableAttributedString = NSMutableAttributedString.init()
        string.appendAttributedString(NSAttributedString.init(string: "Try", attributes: [NSFontAttributeName : UIFont.systemFontOfSize(12.0)]))
        string.appendAttributedString(NSAttributedString.init(string: "this", attributes: [NSFontAttributeName : UIFont.systemFontOfSize(18.0),
            NSForegroundColorAttributeName : UIColor.redColor()]))
        
        return string
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

