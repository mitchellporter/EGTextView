//  EGTextView.swift
//
//  Copyright (c) 2015 Egg swift. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the “Software”), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

public class EGTextView: UITextView {
    
    public var minimumHeight: CGFloat? {
        didSet{
            self.updateHeightConstraint(false)
        }
    }
    public var maximumHeight: CGFloat? {
        didSet{
            self.updateHeightConstraint(false)
        }
    }
    public var heightConstraint: NSLayoutConstraint?
    public var placeHolder: NSAttributedString? {
        didSet{
            placeHolderLabel.attributedText = placeHolder
        }
    }

    private var placeHolderLabel: UILabel! {
        didSet {
            placeHolderLabel.hidden = true
            placeHolderLabel.layer.borderWidth = 1.0
        }
    }
    public var editing: Bool {
        get {
            return self.isFirstResponder()
        }
        set(editing) {
            self.editing = editing
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configInit()
        self.configNotification()
    }
   
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        if let _ = textContainer {
            super.init(frame: frame, textContainer: textContainer)
        }else {
            let tempContainer = NSTextContainer(size: frame.size);
            tempContainer.widthTracksTextView = true
            let layoutManager : NSLayoutManager = NSLayoutManager()
            layoutManager.addTextContainer(tempContainer)
            let textStorage = NSTextStorage()
            textStorage.addLayoutManager(layoutManager)
            super.init(frame: frame, textContainer: tempContainer)
        }
        self.configInit()
        self.configNotification()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func configInit() {
        for constraint in self.constraints {
            if constraint.firstAttribute == NSLayoutAttribute.Height {
                self.heightConstraint = constraint
                break
            }
        }
        editable = true;
        layoutManager.allowsNonContiguousLayout = false;
        scrollsToTop = false;
        autoresizingMask = UIViewAutoresizing.FlexibleWidth;
        scrollIndicatorInsets = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 0.0);
        textContainerInset = UIEdgeInsets(top: 8.0, left: 5.0, bottom: 8.0, right: 5.0);
        scrollEnabled = true;
        scrollsToTop = false;
        userInteractionEnabled = true;
        font = UIFont.systemFontOfSize(16.0);
        textColor = UIColor.blackColor();
        backgroundColor = UIColor.whiteColor();
        keyboardAppearance = UIKeyboardAppearance.Default;
        keyboardType = UIKeyboardType.Default;
        returnKeyType = UIReturnKeyType.Default;
        textAlignment = NSTextAlignment.Left;
        
        placeHolderLabel = UILabel.init(frame: CGRectZero)
        self.insertSubview(placeHolderLabel, atIndex: 0)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if self.text.characters.count > 0{
            placeHolderLabel.hidden = true
        }
        else if let _ = placeHolder{
            placeHolderLabel.hidden = false
            placeHolderLabel.sizeToFit()
            let firstGlyph = caretRectForPosition((selectedTextRange?.start)!);
            let placeHolderRect = CGRect.init(origin: firstGlyph.origin, size: placeHolderLabel.bounds.size)
            placeHolderLabel.frame = placeHolderRect
        }
    }
    
    private func updateContentOffset(withTextRange textRange : UITextRange) {
        let line = self.caretRectForPosition(textRange.start)
        let overflow = line.origin.y + line.size.height - (self.contentOffset.y + self.bounds.size.height - self.contentInset.bottom - self.contentInset.top)
        if overflow > 0 {
            var offset: CGPoint = self.contentOffset
            offset.y += overflow + 7.0
    
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.2)
            UIView.setAnimationCurve(.EaseIn)
            UIView.setAnimationBeginsFromCurrentState(true)
            self.contentOffset = offset
            UIView.commitAnimations()
        }
    }
    
    private func updateHeightConstraint(animated: Bool) {
        if let _ = self.maximumHeight {
        
        }else if let _ = self.minimumHeight {
        
        }else{
            return
        }
        
        var totalSize: CGSize = self.contentSize
        totalSize.width  += self.textContainerInset.left + self.textContainerInset.right
        totalSize.height += self.textContainerInset.top  + self.textContainerInset.bottom
        
        var changeSize = totalSize
        if let maximum = self.maximumHeight {
            changeSize.height = min(changeSize.height, CGFloat(maximum))
        }
        if let minimum = self.minimumHeight {
            changeSize.height = max(changeSize.height, CGFloat(minimum))
        }
        
        if animated == true {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.2)
            UIView.setAnimationCurve(.EaseIn)
            UIView.setAnimationBeginsFromCurrentState(true)
            self.heightConstraint?.constant = ceil(changeSize.height);
            self.layoutIfNeeded()
            UIView.commitAnimations()
        }else {
            self.heightConstraint?.constant = ceil(changeSize.height);
            self.layoutIfNeeded()
        }
    }
    
    
    func configNotification() {
        unowned let unownedSelf = self
        NSNotificationCenter.defaultCenter().addObserverForName(UITextViewTextDidChangeNotification, object: nil, queue: nil) { (noti) -> Void in
            if unownedSelf.isFirstResponder() == true, let textRange = unownedSelf.selectedTextRange{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    unownedSelf.updateContentOffset(withTextRange: textRange)
                    unownedSelf.layoutSubviews()
                    self.updateHeightConstraint(true)
                })
            }
        }
        NSNotificationCenter.defaultCenter().addObserverForName(UITextViewTextDidBeginEditingNotification, object: nil, queue: nil) { (noti) -> Void in
            if unownedSelf.isFirstResponder() == true, let textRange = unownedSelf.selectedTextRange{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    unownedSelf.updateContentOffset(withTextRange: textRange)
                })
            }
        }
        NSNotificationCenter.defaultCenter().addObserverForName(UITextViewTextDidEndEditingNotification, object: nil, queue: nil) { (noti) -> Void in
            
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidChangeNotification, object: nil);
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidBeginEditingNotification, object: nil);
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidEndEditingNotification, object: nil);
    }
}
