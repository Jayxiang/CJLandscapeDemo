//
//  BaseNavigationController.swift
//  LandscapeSwift
//
//  Created by Jayxiang on 2021/7/13.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // 重写以下两个方法任意一个即可改变状态栏样式
//    open override var preferredStatusBarStyle: UIStatusBarStyle {
//        return visibleViewController?.preferredStatusBarStyle ?? .default
//    }
    
    open override var childForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
}

extension UINavigationController {
    open override var shouldAutorotate: Bool {
        return visibleViewController?.shouldAutorotate ?? false
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return visibleViewController?.supportedInterfaceOrientations ?? .portrait
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return visibleViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
    
    open override var prefersStatusBarHidden: Bool {
        return visibleViewController?.prefersStatusBarHidden ?? false
    }
    
    
}
