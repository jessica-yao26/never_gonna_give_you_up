//
//  ChooseUsernameViewController.swift
//  steeloreel
//
//  Created by Jessica Yao on 4/9/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import UIKit

class ChooseUsernameViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    
    var usernameUnique : Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.setArrowButtonImages(backButton: backButton, forwardButton: forwardButton)
        usernameField.setTextboxOutlineDarkGrey()
        if(UserDefaults.standard.string(forKey: "username") != nil) {
            usernameField.text = UserDefaults.standard.string(forKey: "username")
        }
        if(usernameUnique != nil){
            print("inside username is not nil")
            if(usernameUnique)! {
                var token = UserDefaults.standard.string(forKey: "email")?.components(separatedBy: "@")
                usernameField.text = token?[0]
            }
        }
        else{
            print("inside username is nil")
            usernameField.text = nil
        }
        // Do any additional setup after loading the view.
    }
    
    func isValidUsernameString(testStr:String) -> Bool {
        let usernameStringRegEx = "[A-Za-z0-9_.]{2,64}"
        let usernameStringTest = NSPredicate(format:"SELF MATCHES %@", usernameStringRegEx)
        
        return usernameStringTest.evaluate(with: testStr)
    }
    
    func isUsernameFieldValid(username: String) -> Bool {
        if((usernameField.text?.isEmpty)!) {
            self.showToast(message: "Please enter a username")
            return false;
        }
        if(!isValidUsernameString(testStr: username)){
            self.showToast(message: "Usernames can only use letters, numbers, underscores, and periods")
            return false;
        }
        return true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnPressed(_ sender: Any) {
        saveUsernameAndMinimizeKeyboard(username: (usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
    }
    
    @IBAction func backArrowPressed(_ sender: Any) {
        saveUsernameAndMinimizeKeyboard(username: (usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
    }
    
    @IBAction func forwardArrowPressed(_ sender: Any) {
        saveUsernameAndMinimizeKeyboard(username: (usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
    }
    
    func saveUsernameAndMinimizeKeyboard(username: String) {
        usernameField.resignFirstResponder()
        UserDefaults.standard.set(username, forKey: "username")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //        var token = UserDefaults.standard.string(forKey: "email")?.components(separatedBy: "@")
    //        let username = token?[0]
    //        print("this is usernameunique")
    //        print(self.usernameUnique)
    //        if(self.usernameUnique != nil && self.usernameUnique!) {
    //            usernameField.text = username
    //        }
    //        else{
    //            usernameField.text = nil
    //        }
    // Do any additional setup after loading the view.
    func checkNameFieldAndSendsToNextViewController() {
//        if(isUsernameFieldValid(first_name: (self.firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, last_name: (self.lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)){
            //            UserLoginSignUpAPI.createNewUser(email: UserDefaults.standard.string(forKey: "email")!, username: <#String#>, password: self.passwordField.text!, first_name: (self.firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, last_name: (self.lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))! , completion: { response in
            //                let statusCode = response
            //                DispatchQueue.main.async {
            //                    if(statusCode == 201) {
            //                        self.showToast(message: "Yay")
            ////                        UserDefaults.standard.set(email, forKey: "email")
            ////                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
            ////                        AppUtility.SegueFromLeftViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
            //                    }
            ////                    else if(statusCode == 200) {
            ////                        UserDefaults.standard.set(email, forKey: "email")
            ////                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnterPasswordViewController") as! EnterPasswordViewController
            ////                        AppUtility.SegueFromLeftViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
            ////                    }
            //                    else {
            //                        self.showToast(message: "Sorry, something went wrong")
            //                    }
            //                }
            //            })
        }
    //        else if(usernameField.text?.isEmpty)! {
    //            usernameField.becomeFirstResponder()
    //            self.showToast(message: "Please enter a username")
    //            return false;
    //        }
    //        else if(!self.usernameUnique!) {
    //            usernameField.becomeFirstResponder()
    //            self.showToast(message: "A user with that username already exists")
    //            return false;
    //        }
    //        else if(!AppUtility.isValid(testStr: username, regex: AppUtility.usernameRegex)) {
    //            self.showToast(message: "Only characters, numbers, underscores, and periods are allowed")
    //            return false;
    //        }
        //            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SetPasswordViewController") as! SetPasswordViewController
        //            AppUtility.SegueFromLeftViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
    }

//    @IBAction func checkUsernameUniqueOnChange(_ sender: Any) {
//        //        if(isEmailFieldValid(email: email)) {
//        UserLoginSignUpAPI.checkUsername(username: usernameField.text!, completion: { response in
//            let statusCode = response
//            DispatchQueue.main.async {
//                if(statusCode == 404) {
//                    self.usernameUnique = true;
//                    //                        UserDefaults.standard.set(email, forKey: "email")
//                    //                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
//                    //                        AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
//                }
//                else if(statusCode == 200) {
//                    self.usernameUnique = false;
//                    self.showToast(message: "A user with that username already exists")
//                    //                        UserDefaults.standard.set(email, forKey: "email")
//                    //                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnterPasswordViewController") as! EnterPasswordViewController
//                    //                        AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
//                }
//                else {
//                    self.showToast(message: "Sorry, something went wrong")
//                }
//            }
//        })
//        //        }
//    }
//    @IBAction func checkUsernameUnique(_ sender: Any) {
////        if(isEmailFieldValid(email: email)) {
//        UserLoginSignUpAPI.checkUsername(username: usernameField.text!, completion: { response in
//                let statusCode = response
//                DispatchQueue.main.async {
//                    if(statusCode == 404) {
//                        self.usernameUnique = true;
////                        UserDefaults.standard.set(email, forKey: "email")
////                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
////                        AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
//                    }
//                    else if(statusCode == 200) {
//                        self.usernameUnique = false;
//                        self.showToast(message: "A user with that username already exists")
////                        UserDefaults.standard.set(email, forKey: "email")
////                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnterPasswordViewController") as! EnterPasswordViewController
////                        AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
//                    }
//                    else {
//                        self.showToast(message: "Sorry, something went wrong")
//                    }
//                }
//            })
////        }
//    }
//    @IBAction func checkUsernameUniqueTouchOutside(_ sender: Any) {
////        checkUsernameUniqueOnLoad(username: usernameField.text, completion: <#T##(Bool) -> Void#>)
//    }
//    func checkUsernameUniqueOnLoad(username: String, completion: @escaping (Bool) -> Void) {
//        //        if(isEmailFieldValid(email: email)) {
//        UserLoginSignUpAPI.checkUsername(username: username, completion: { response in
//            let statusCode = response
////            DispatchQueue.main.async {
//                if(statusCode == 404) {
//                    print("in 404")
////                    self.usernameUnique = true
////                    print(self.usernameUnique)
////                    completion(self.usernameUnique!)
//                    //                        UserDefaults.standard.set(email, forKey: "email")
//                    //                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
//                    //                        AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
//                }
//                else if(statusCode == 200) {
//                    print("in200")
////                    self.usernameUnique = false
////                    print(self.usernameUnique)
////                    completion(self.usernameUnique!)
////                    returnBoolean = false
////                    self.showToast(message: "A user with that username already exists")
//                    //                        UserDefaults.standard.set(email, forKey: "email")
//                    //                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnterPasswordViewController") as! EnterPasswordViewController
//                    //                        AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
//                }
//                else {
////                    self.showToast(message: "Sorry, something went wrong")
//                }
////            }
//        })
//        //        }
//    }
//UserLoginSignUpAPI.createNewUser(email: UserDefaults.standard.string(forKey: "email")!, password: self.passwordField.text!, first_name: (self.firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, last_name: (self.lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))! , completion: { response in
//    let statusCode = response
//    DispatchQueue.main.async {
//        if(statusCode == 201) {
//            self.showToast(message: "Yay")
            //                        UserDefaults.standard.set(email, forKey: "email")
            //                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
            //                        AppUtility.SegueFromLeftViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
//}
//                    else if(statusCode == 200) {
//                        UserDefaults.standard.set(email, forKey: "email")
//                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnterPasswordViewController") as! EnterPasswordViewController
//            AppUtility.SegueFromLeftViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
////                    }
//                    else {
//                        self.showToast(message: "Sorry, something went wrong")
//                    }
//                }
//            })
//        }
////            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SetPasswordViewController") as! SetPasswordViewController
//            AppUtility.SegueFromLeftViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
//        }
