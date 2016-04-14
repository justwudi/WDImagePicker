//
//  WDCropBorderView.swift
//  WDImagePicker
//
//  Created by Wu Di on 27/8/15.
//  Copyright (c) 2015 Wu Di. All rights reserved.
//

import UIKit

internal class WDCropBorderView: UIView {
    private let kNumberOfBorderHandles: CGFloat = 8
    private let kHandleDiameter: CGFloat = 24

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.clearColor()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.backgroundColor = UIColor.clearColor()
    }

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        CGContextSetStrokeColorWithColor(context,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).CGColor)
        CGContextSetLineWidth(context, 1.5)
        CGContextAddRect(context, CGRectMake(kHandleDiameter / 2, kHandleDiameter / 2,
            rect.size.width - kHandleDiameter, rect.size.height - kHandleDiameter))
        CGContextStrokePath(context)

        CGContextSetRGBFillColor(context, 1, 1, 1, 0.95)
        for handleRect in calculateAllNeededHandleRects() {
            CGContextFillEllipseInRect(context, handleRect)
        }
    }

    private func calculateAllNeededHandleRects() -> [CGRect] {

        let width = self.frame.width
        let height = self.frame.height

        let leftColX: CGFloat = 0
        let rightColX = width - kHandleDiameter
        let centerColX = rightColX / 2

        let topRowY: CGFloat = 0
        let bottomRowY = height - kHandleDiameter
        let middleRowY = bottomRowY / 2

        //starting with the upper left corner and then following clockwise
        let topLeft = CGRectMake(leftColX, topRowY, kHandleDiameter, kHandleDiameter)
        let topCenter = CGRectMake(centerColX, topRowY, kHandleDiameter, kHandleDiameter)
        let topRight = CGRectMake(rightColX, topRowY, kHandleDiameter, kHandleDiameter)
        let middleRight = CGRectMake(rightColX, middleRowY, kHandleDiameter, kHandleDiameter)
        let bottomRight = CGRectMake(rightColX, bottomRowY, kHandleDiameter, kHandleDiameter)
        let bottomCenter = CGRectMake(centerColX, bottomRowY, kHandleDiameter, kHandleDiameter)
        let bottomLeft = CGRectMake(leftColX, bottomRowY, kHandleDiameter, kHandleDiameter)
        let middleLeft = CGRectMake(leftColX, middleRowY, kHandleDiameter, kHandleDiameter)

        return [topLeft, topCenter, topRight, middleRight, bottomRight, bottomCenter, bottomLeft,
            middleLeft]
    }
}