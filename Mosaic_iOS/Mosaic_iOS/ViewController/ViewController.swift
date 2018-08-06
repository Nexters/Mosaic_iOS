//
//  ViewController.swift
//  Mosaic_iOS
//
//  Created by Zedd on 2018. 7. 14..
//  Copyright © 2018년 Zedd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//https://stackoverflow.com/questions/13006464/how-to-fix-the-issue-command-bin-sh-failed-with-exit-code-1-in-iphone
var bottomInset: CGFloat {
    //use in viewDidLoad or viewDidLayoutSubviews
    if #available(iOS 11.0, *) {
        if let inset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom {
            return inset
        }
    }
    return 0
}
