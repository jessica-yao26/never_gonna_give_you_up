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
    
    var nextViewController: UIViewController?
    var loginSession: LoginSession?

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    
    var responseTemp: Dictionary<String, String>?
    var passedResponseDictionary: Dictionary<String, String>?
    var passedEmail: String?
//    var nextViewController: UIViewController?
    // if there's a question mark it can be nil and doesn't need more info before initializing the set
//    var chooseUsernameViewController: ChooseUsernameViewController?
    // when it inits the vc, it wants properties values, but it doesn't have self

    
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
//        chooseUsernameViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChooseUsernameViewController") as! ChooseUsernameViewController
    }
    
    func set(email: String) {
    }
    
//    func goToNext() {
//        let nextViewController = EnterPasswordViewController()
//        nextViewController.loginSession = loginSession
//    }
    
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
            print("finished the check")
            print("this is test bool")
            print(self.loginSession?.usernameUnique)
//            loginSession = LoginSession(email: email, username: nil, password: nil, usernameUnique: nil)
//            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
//            nextViewController.loginSession = loginSession
//            chooseUsernameViewController = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
//            self.present(nextViewController, animated: true, completion: nil)
//            AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
//            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        print("THIS IS outside the look")
//        self.loginSession = LoginSession(email: email, username: nil, password: nil, usernameUnique: nil)
//        let nextViewController = NameViewController()
//        nextViewController.loginSession = self.loginSession
////                                AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
//
//        self.navigationController?.pushViewController(nextViewController, animated: true)
//        print(email)
//        loginSession = LoginSession(email: email, username: nil, password: nil, usernameUnique: nil)
//        let nextViewController = NameViewController()
//        nextViewController.loginSession = loginSession
//        AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)

//        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func completeEmailRegisteredCheck(email: String, handler:@escaping (_ nextViewController: UIViewController?) -> Void) {
        UserLoginSignUpAPI.checkEmail(email: email, completion: { response in
            let statusCode = response
                            DispatchQueue.main.async {
            if(statusCode == 404) {
                print("inside outer 404")
                UserDefaults.standard.set(email, forKey: "email")
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
                self.loginSession = LoginSession(email: email, username: nil, password: nil, usernameUnique: nil)
                nextViewController.loginSession = self.loginSession
                handler(nextViewController)
//                            AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
//                let nextViewController = NameViewController()
//                nextViewController.loginSession = self.loginSession
                // self navigation controller is null
//                self.navigationController!.pushViewController(nextViewController, animated: true)
//                AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
                //                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
//                self.loginSession?.usernameUnique = true
                //                        self.loginSession = LoginSession(email: email, username: nil, password: nil, usernameUnique: nil)
                //                        let nextViewController = NameViewController()
                //                        nextViewController.loginSession = self.loginSession
                //                        self.navigationController?.pushViewController(nextViewController, animated: true)
                //                        let chooseUsernameViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChooseUsernameViewController") as! ChooseUsernameViewController
                //
                //
                //                        var token = self.emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "@")
                //                        let username = token[0]
                //                        UserLoginSignUpAPI.checkUsername(username: username, completion: { response in
                //                            let statusCode = response
                //                            print("inside checkUsername call")
                //                                if(statusCode == 404) {
                //                                    print("inside 404")
                //                                    print("I've the if statement where usernameunique is set")
                ////                                    self.chooseUsernameViewController?.usernameUnique = true
                //                                    self.loginSession?.usernameUnique = true
                //                                }
                //                                else {
                //                                    print("inside else")
                ////                                    self.chooseUsernameViewController?.usernameUnique = false
                //                                    self.loginSession?.usernameUnique = true
                //                            }
                //                        })
                //                        AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
            }
            else if(statusCode == 200) {
                UserDefaults.standard.set(email, forKey: "email")
                //                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnterPasswordViewController") as! EnterPasswordViewController
                
                //                        AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
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
