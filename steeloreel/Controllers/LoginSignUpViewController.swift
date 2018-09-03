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
    
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    
    var responseTemp: Dictionary<String, String>?
    var passedResponseDictionary: Dictionary<String, String>?
    var passedEmail : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.setupLandingView(view: self.view)
        if(UserDefaults.standard.string(forKey: "email") != nil) {
            emailField.text = UserDefaults.standard.string(forKey: "email")
        }
        view.bringSubview(toFront: emailField)
        view.bringSubview(toFront: continueBtn)
        continueBtn.setButtonOutlineBlack()
        facebookBtn.setButtonOutlineBlack()
        googleBtn.setButtonOutlineBlack()
        emailField.setTextboxOutlineDarkGrey()
        if(passedResponseDictionary?["email"] != nil) {
            emailField.text = passedResponseDictionary?["email"]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Helper functions
    
    func isEmailFieldValid(email: String) -> Bool {
        if(email.isEmpty) {
            emailField.becomeFirstResponder()
            self.showToast(message: "Please enter your email")
            return false;
        }
        if(!AppUtility.isValid(testStr: email, regex: AppUtility.emailRegex)) {
            self.showToast(message: "Please enter a valid email")
            return false;
        }
        return true;
    }
    // Email checker
    func checkEmail(email: String) {
        emailField.resignFirstResponder()
        if(UserDefaults.standard.string(forKey: "email") != nil && UserDefaults.standard.string(forKey: "email") != emailField.text) {
            AppUtility.clearLoginSignUpUserDefaults()
        }
        if(isEmailFieldValid(email: email)) {
            UserLoginSignUpAPI.checkEmail(email: email, completion: { response in
                let statusCode = response
                DispatchQueue.main.async {
                    if(statusCode == 404) {
                        print("inside outer 404")
                        UserDefaults.standard.set(email, forKey: "email")
                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
                        let chooseUsernameViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChooseUsernameViewController") as! ChooseUsernameViewController
                        var token = self.emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "@")
                        let username = token[0]
                        UserLoginSignUpAPI.checkUsername(username: username, completion: { response in
                            let statusCode = response
                            print("inside checkUsername call")
                                if(statusCode == 404) {
                                    print("inside 404")
                                    chooseUsernameViewController.usernameUnique = true
                                    print("This is what the username check api call returns")
                                }
                                else {
                                    print("inside else")
                                    chooseUsernameViewController.usernameUnique = false
                            }
                        })
                        AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
                    }
                    else if(statusCode == 200) {
                        UserDefaults.standard.set(email, forKey: "email")
                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnterPasswordViewController") as! EnterPasswordViewController

                        AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
                    }
                    else {
                        self.showToast(message: "Sorry, something went wrong")
                    }
                }
            })
        }
    }
    // Actions
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        checkEmail(email: emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines));
    }
    
    @IBAction func returnKeyPressed(_ sender: Any) {
        checkEmail(email: emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines));
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
