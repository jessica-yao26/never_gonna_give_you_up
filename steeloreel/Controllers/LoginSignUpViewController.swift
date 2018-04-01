//
//  LoginSignUpViewController.swift
//  steeloreel
//
//  Created by Jessica Yao on 3/27/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import UIKit

class LoginSignUpViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Change and lock orientation to portrait
        AppUtility.lockOrientation(.landscape, andRotateTo: .portrait)
        AppUtility.lockOrientation(.portrait)
        // Set and scale background image
        let image = AppUtility.scaleUIImageToSize(image: UIImage(named: "pattern")!, size: CGSize(width: 175, height: 175))
        self.view.backgroundColor = UIColor(patternImage: image)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        print("inside CBP")
        if(emailField.text?.isEmpty)! {
            print("email field is empty")
            self.showToast(message:"Please Email field")
        }
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
