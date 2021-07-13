//
//  TabBarController.swift
//  LandscapeSwift
//
//  Created by Jayxiang on 2021/7/13.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension UITabBarController {
    // 是否可以旋转
    open override var shouldAutorotate: Bool {
        if let selectedViewController = selectedViewController as? UINavigationController {
            return selectedViewController.visibleViewController?.shouldAutorotate ?? false
        }
        return selectedViewController?.shouldAutorotate ?? false
    }

    // 当前页面支持的方向
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let selectedViewController = selectedViewController as? UINavigationController {
            return selectedViewController.visibleViewController?.supportedInterfaceOrientations ?? .portrait
        }
        return selectedViewController?.supportedInterfaceOrientations ?? .portrait
    }
    
    // 模态视图的方向
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if let selectedViewController = selectedViewController as? UINavigationController {
            return selectedViewController.visibleViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
        }
        return selectedViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
    
    // 是否隐藏状态栏
    open override var prefersStatusBarHidden: Bool {
        if let selectedViewController = selectedViewController as? UINavigationController {
            return selectedViewController.visibleViewController?.prefersStatusBarHidden ?? false
        }
        return selectedViewController?.prefersStatusBarHidden ?? false
    }
    
    // 状态栏的样式 经测试，这个放到扩展没有作用
//    open override var preferredStatusBarStyle: UIStatusBarStyle {
//        if let selectedViewController = selectedViewController as? UINavigationController {
//            return selectedViewController.visibleViewController?.preferredStatusBarStyle ?? .default
//        }
//        return selectedViewController?.preferredStatusBarStyle ?? .default
//    }
}
