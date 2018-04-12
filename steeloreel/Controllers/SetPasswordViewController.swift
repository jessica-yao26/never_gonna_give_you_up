//
//  SetPasswordViewController.swift
//  steeloreel
//
//  Created by Jessica Yao on 4/7/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import UIKit

class SetPasswordViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.setArrowButtonImages(backButton: backButton, forwardButton: forwardButton)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
