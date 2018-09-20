//
//  LoginSignUpViewController.swift
//  steeloreel
//
//  Created by Jessica Yao on 3/27/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import UIKit
struct LoginSession {
    //put all properties in here
    var email: String?
    var username: String?
    var password: String?
    var usernameUnique: Bool?
//    var usernameUnique: Bool?
}
class LoginSignUpViewController: UIViewController {
    
    var loginSession: LoginSession?
    var nextViewController: UIViewController?

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    
//    will need unwind segue
//    var responseTemp: Dictionary<String, String>?
//    var passedResponseDictionary: Dictionary<String, String>?
//    var passedEmail: String?
    
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
//        if(passedResponseDictionary?["email"] != nil) {
//            emailField.text = passedResponseDictionary?["email"]
//        }
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
            completeEmailRegisteredCheck(email: email) { (nextViewController) -> Void in
                if let nextViewController = nextViewController {
                    DispatchQueue.main.async {
                        print("inside calling func")
                        self.nextViewController = nextViewController
                        print(nextViewController)
                    }
                }
                AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController!)
            }
        }
    }
    
    func completeEmailRegisteredCheck(email: String, handler:@escaping (_ nextViewController: UIViewController?) -> Void) {
        UserLoginSignUpAPI.checkEmail(email: email, completion: { response in
            let statusCode = response
            DispatchQueue.main.async {
                if(statusCode == 404) {
                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
                    self.loginSession = LoginSession(email: email, username: nil, password: nil, usernameUnique: nil)
                    nextViewController.loginSession = self.loginSession
                    handler(nextViewController)

                }
                else if(statusCode == 200) {
                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnterPasswordViewController") as! EnterPasswordViewController
                    self.loginSession = LoginSession(email: email, username: nil, password: nil, usernameUnique: nil)
                    nextViewController.loginSession = self.loginSession
                    handler(nextViewController)
                }
                else {
                    self.showToast(message: "Sorry, something went wrong")
                }
            }
        })
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
