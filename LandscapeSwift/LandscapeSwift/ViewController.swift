//
//  ViewController.swift
//  LandscapeSwift
//
//  Created by Jayxiang on 2021/7/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var allowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func allowClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        // 由于有 allowOrentitaionRotation 全局控制，BaseViewController 可以不需要
        AppDelegate.allowOrentitaionRotation = sender.isSelected
    }
    
}
