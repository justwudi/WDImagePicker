//
//  WDImageCropViewController.swift
//  WDImagePicker
//
//  Created by Wu Di on 27/8/15.
//  Copyright (c) 2015 Wu Di. All rights reserved.
//

import UIKit
import CoreGraphics

internal protocol WDImageCropControllerDelegate {
    func imageCropController(imageCropController: WDImageCropViewController, didFinishWithCroppedImage croppedImage: UIImage)
}

internal class WDImageCropViewController: UIViewController {
    var sourceImage: UIImage!
    var delegate: WDImageCropControllerDelegate?
    var cropSize: CGSize!
    var resizableCropArea = false

    private var croppedImage: UIImage!

    private var imageCropView: WDImageCropView!
    private var toolbar: UIToolbar!
    private var useButton: UIButton!
    private var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false

        self.title = "Choose Photo"

        self.setupNavigationBar()
        self.setupCropView()
        self.setupToolbar()

        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            self.navigationController?.navigationBarHidden = true
        } else {
            self.navigationController?.navigationBarHidden = false
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.imageCropView.frame = self.view.bounds
        self.toolbar?.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - 54,
            self.view.frame.size.width, 54)
    }

    func actionCancel(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    func actionUse(sender: AnyObject) {
        croppedImage = self.imageCropView.croppedImage()
        self.delegate?.imageCropController(self, didFinishWithCroppedImage: croppedImage)
    }

    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel,
                                                                target: self, action: #selector(actionCancel))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Use", style: .Plain,
            target: self, action: #selector(actionUse))
    }

    private func setupCropView() {
        self.imageCropView = WDImageCropView(frame: self.view.bounds)
        self.imageCropView.imageToCrop = sourceImage
        self.imageCropView.resizableCropArea = self.resizableCropArea
        self.imageCropView.cropSize = cropSize
        self.view.addSubview(self.imageCropView)
    }

    private func setupCancelButton() {
        self.cancelButton = UIButton()
        self.cancelButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        self.cancelButton.titleLabel?.shadowOffset = CGSizeMake(0, -1)
        self.cancelButton.frame = CGRectMake(0, 0, 58, 30)
        self.cancelButton.setTitle("Cancel", forState: .Normal)
        self.cancelButton.setTitleShadowColor(
            UIColor(red: 0.118, green: 0.247, blue: 0.455, alpha: 1), forState: .Normal)
        self.cancelButton.addTarget(self, action: #selector(actionCancel), forControlEvents: .TouchUpInside)
    }

    private func setupUseButton() {
        self.useButton = UIButton()
        self.useButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        self.useButton.titleLabel?.shadowOffset = CGSizeMake(0, -1)
        self.useButton.frame = CGRectMake(0, 0, 58, 30)
        self.useButton.setTitle("Use", forState: .Normal)
        self.useButton.setTitleShadowColor(
            UIColor(red: 0.118, green: 0.247, blue: 0.455, alpha: 1), forState: .Normal)
        self.useButton.addTarget(self, action: #selector(actionUse), forControlEvents: .TouchUpInside)
    }

    private func toolbarBackgroundImage() -> UIImage {
        let components: [CGFloat] = [1, 1, 1, 1, 123.0 / 255.0, 125.0 / 255.0, 132.0 / 255.0, 1]

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(320, 54), true, 0)

        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradientCreateWithColorComponents(colorSpace, components, nil, 2)

        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, 54), [])

        let viewImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return viewImage
    }

    private func setupToolbar() {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            self.toolbar = UIToolbar(frame: CGRectZero)
            self.toolbar.translucent = true
            self.toolbar.barStyle = .Black
            self.view.addSubview(self.toolbar)

            self.setupCancelButton()
            self.setupUseButton()

            let info = UILabel(frame: CGRectZero)
            info.text = ""
            info.textColor = UIColor(red: 0.173, green: 0.173, blue: 0.173, alpha: 1)
            info.backgroundColor = UIColor.clearColor()
            info.shadowColor = UIColor(red: 0.827, green: 0.731, blue: 0.839, alpha: 1)
            info.shadowOffset = CGSizeMake(0, 1)
            info.font = UIFont.boldSystemFontOfSize(18)
            info.sizeToFit()

            let cancel = UIBarButtonItem(customView: self.cancelButton)
            let flex = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
            let label = UIBarButtonItem(customView: info)
            let use = UIBarButtonItem(customView: self.useButton)

            self.toolbar.setItems([cancel, flex, label, flex, use], animated: false)
        }
    }
}
