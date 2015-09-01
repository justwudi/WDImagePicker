//
//  WDImageCropOverlayView.swift
//  WDImagePicker
//
//  Created by Wu Di on 27/8/15.
//  Copyright (c) 2015 Wu Di. All rights reserved.
//

import UIKit

internal class WDImageCropOverlayView: UIView {

    var cropSize: CGSize!
    var toolbar: UIToolbar!

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.clearColor()
        self.userInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.backgroundColor = UIColor.clearColor()
        self.userInteractionEnabled = true
    }

    override func drawRect(rect: CGRect) {

        let toolbarSize = CGFloat(UIDevice.currentDevice().userInterfaceIdiom == .Pad ? 0 : 54)

        let width = CGRectGetWidth(self.frame)
        let height = CGRectGetHeight(self.frame) - toolbarSize

        let heightSpan = floor(height / 2 - self.cropSize.height / 2)
        let widthSpan = floor(width / 2 - self.cropSize.width / 2)

        // fill outer rect
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).set()
        UIRectFill(self.bounds)

        // fill inner border
        UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).set()
        UIRectFrame(CGRectMake(widthSpan - 2, heightSpan - 2, self.cropSize.width + 4,
            self.cropSize.height + 4))

        // fill inner rect
        UIColor.clearColor().set()
        UIRectFill(CGRectMake(widthSpan, heightSpan, self.cropSize.width, self.cropSize.height))
    }
}
