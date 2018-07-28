//
//  HomeViewController.swift
//  Mosaic_iOS
//
//  Created by Zedd on 2018. 7. 28..
//  Copyright © 2018년 Zedd. All rights reserved.
//


import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var newTabBarFrame = self.tabBar.frame
        let newTabBarHeight: CGFloat = 60
        newTabBarFrame.size.height = newTabBarHeight
        newTabBarFrame.origin.y = self.view.frame.size.height - newTabBarHeight
        self.tabBar.frame = newTabBarFrame
    }
}

class HomeViewController: UIViewController {

    static func create() -> HomeViewController?{
        return UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? HomeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tabBarController?.tabBar.frame.size.height = 100

    
    }

}
