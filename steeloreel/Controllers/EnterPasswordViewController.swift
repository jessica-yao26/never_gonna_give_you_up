//
//  EnterPasswordViewController.swift
//  steeloreel
//
//  Created by Jessica Yao on 4/7/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import UIKit

class EnterPasswordViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBOutlet weak var viewIcon: UIButton!
    @IBOutlet weak var hideIcon: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.setArrowButtonImages(backButton: backButton, forwardButton: forwardButton)
        let hideIconImage = UIImage(named: "view")
        let viewIconImage = UIImage(named: "hide")
        hideIcon.setBackgroundImage(hideIconImage, for: .normal)
        viewIcon.setBackgroundImage(viewIconImage, for: .normal)
        hideIcon.isHidden = true;
        passwordField.setTextboxOutlineDarkGrey()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewIconTouched(_ sender: Any) {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry;
        hideIcon.isHidden = !hideIcon.isHidden
        viewIcon.isHidden = !viewIcon.isHidden
        
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
//        if(isEmailFieldValid(email: email)) {
        UserLoginSignUpAPI.loginUser(username: UserDefaults.standard.string(forKey: "email")!, password: passwordField.text!, completion: { response in
                let statusCode = response
                DispatchQueue.main.async {
//                    if(statusCode == 404) {
//                        UserDefaults.standard.set(email, forKey: "email")
//                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
//                        AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
//                    }
                        if(statusCode == 200) {
//                        UserDefaults.standard.set(email, forKey: "email")
//                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnterPasswordViewController") as! EnterPasswordViewController
//                        AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
                        self.showToast(message: "yay")
                    }
                    else {
                        self.showToast(message: "Sorry, something went wrong")
                    }
                }
            })
//        }
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
