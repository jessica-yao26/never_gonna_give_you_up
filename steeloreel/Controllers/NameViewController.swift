//
//  NameViewController.swift
//  steeloreel
//
//  Created by Jessica Yao on 4/8/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBOutlet weak var hideIcon: UIButton!
    @IBOutlet weak var viewIcon: UIButton!
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var customView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubview(toFront: forwardButton)
        let hideIconImage = UIImage(named: "view")
        let viewIconImage = UIImage(named: "hide")
        hideIcon.setBackgroundImage(hideIconImage, for: .normal)
        viewIcon.setBackgroundImage(viewIconImage, for: .normal)
        hideIcon.isHidden = true;
        AppUtility.setArrowButtonImages(backButton: backButton, forwardButton: forwardButton)
//        firstNameField.setBottomBorder()
//        lastNameField.setBottomBorder()
//        passwordField.setBottomBorder()
//        usernameField.setBottomBorder()
        firstNameField.setTextboxOutlineDarkGrey()
        lastNameField.setTextboxOutlineDarkGrey()
        usernameField.setTextboxOutlineDarkGrey()
        passwordField.setTextboxOutlineDarkGrey()
        
        if(UserDefaults.standard.string(forKey: "first_name") != nil) {
            firstNameField.text = UserDefaults.standard.string(forKey: "first_name")
        }
        if(UserDefaults.standard.string(forKey: "last_name") != nil) {
            lastNameField.text = UserDefaults.standard.string(forKey: "last_name")
        }
        if(UserDefaults.standard.string(forKey: "username") != nil) {
            usernameField.text = UserDefaults.standard.string(forKey: "username")
        }
        var token = UserDefaults.standard.string(forKey: "email")?.components(separatedBy: "@")
        usernameField.text = token?[0]
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(textField: UITextField) {
//        textField.resignFirstResponder()
        if (textField == firstNameField) {
            lastNameField.becomeFirstResponder()
        }
        else if (textField == lastNameField) {
            usernameField.becomeFirstResponder()
        }
        else if (textField == usernameField) {
            passwordField.becomeFirstResponder()
        }
        else{
            savesFieldsAndMinimizesKeyboard()
            checkNameFieldAndSendsToNextViewController()
//            }
        }
        
//        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Name validators
    func isValidNameString(testStr:String) -> Bool {
        let nameStringRegEx = "[A-Za-z'’.-]{1,64}"
        let nameStringTest = NSPredicate(format:"SELF MATCHES %@", nameStringRegEx)
        
        return nameStringTest.evaluate(with: testStr)
    }
    
    func isValidUsernameString(testStr:String) -> Bool {
        let nameStringRegEx = "[A-Za-z0-9._]{1,64}"
        let nameStringTest = NSPredicate(format:"SELF MATCHES %@", nameStringRegEx)
        
        return nameStringTest.evaluate(with: testStr)
    }
    func isNameFieldValid(first_name: String, last_name: String, username: String) -> Bool {
        if((firstNameField.text?.isEmpty)!) {
            firstNameField.becomeFirstResponder()
            self.showToast(message: "Please enter your first name")
            return false;
        }
        else if((lastNameField.text?.isEmpty)!) {
            lastNameField.becomeFirstResponder()
            self.showToast(message: "Please enter your last name")
            return false;
        }
        else if(!isValidNameString(testStr: first_name) || !isValidNameString(testStr: last_name) ){
            self.showToast(message: "Please enter a valid name")
            return false;
        }
        else if(usernameField.text?.isEmpty)! {
            usernameField.becomeFirstResponder()
            self.showToast(message: "Please enter a username")
            return false;
        }
        else if(!isValidUsernameString(testStr: username)) {
            self.showToast(message: "Only characters, numbers, underscores, and periods are allowed")
            return false;
        }
        else if(passwordField.text?.isEmpty)! {
            passwordField.becomeFirstResponder()
            self.showToast(message: "Please enter a password")
            return false;
        }
        else if((passwordField.text?.count)! < 8) {
            self.showToast(message: "Please enter a longer password")
            return false;
        }
        return true;
    }
    @IBAction func firstNameReturnPressed(_ sender: Any) {
        textFieldShouldReturn(textField: firstNameField)
        //savesFieldsAndMinimizesKeyboard()
        //checkNameFieldAndSendsToNextViewController()
    }
    
    @IBAction func lastNameReturnPressed(_ sender: Any) {
        textFieldShouldReturn(textField: lastNameField)
        //savesFieldsAndMinimizesKeyboard()
        //checkNameFieldAndSendsToNextViewController()
    }
    
    @IBAction func nextPressedFromNameScreen(_ sender: Any) {
        savesFieldsAndMinimizesKeyboard()
        checkNameFieldAndSendsToNextViewController()
    }
    
    @IBAction func usernameReturnPressed(_ sender: Any) {
        textFieldShouldReturn(textField: usernameField)
        //savesFieldsAndMinimizesKeyboard()
        //checkNameFieldAndSendsToNextViewController()
    }
//    @IBAction func passwordReturnPressed(_ sender: Any) {
//        savesFieldsAndMinimizesKeyboard()
//        checkNameFieldAndSendsToNextViewController()
//    }
    
    @IBAction func backPressedFromNameScreen(_ sender: Any) {
        savesFieldsAndMinimizesKeyboard()
    }
    
    @IBAction func viewIconTouched(_ sender: Any) {
        print("viewIcontouched")
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry;
        hideIcon.isHidden = !hideIcon.isHidden
        viewIcon.isHidden = !viewIcon.isHidden

    }
    func savesFieldsAndMinimizesKeyboard() {
 //       firstNameField.resignFirstResponder()
   //     lastNameField.resignFirstResponder()
//        passwordField.resignFirstResponder()
     //   usernameField.resignFirstResponder()
        UserDefaults.standard.set(self.firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "first_name")
        UserDefaults.standard.set(self.lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "last_name")
        UserDefaults.standard.set(self.usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "username")
    }

    func checkNameFieldAndSendsToNextViewController() {
        if(isNameFieldValid(first_name: (self.firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, last_name: (self.lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, username: (self.usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)){
            UserLoginSignUpAPI.createNewUser(email: UserDefaults.standard.string(forKey: "email")!, username: (self.usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, password: self.passwordField.text!, first_name: (self.firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, last_name: (self.lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))! , completion: { response in
                let statusCode = response
                DispatchQueue.main.async {
                    if(statusCode == 201) {
                        self.showToast(message: "Yay")
//                        UserDefaults.standard.set(email, forKey: "email")
//                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
//                        AppUtility.SegueFromLeftViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
                    }
//                    else if(statusCode == 200) {
//                        UserDefaults.standard.set(email, forKey: "email")
//                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnterPasswordViewController") as! EnterPasswordViewController
//                        AppUtility.SegueFromLeftViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
//                    }
                    else {
                        self.showToast(message: "Sorry, something went wrong")
                    }
                }
            })
        }
//            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SetPasswordViewController") as! SetPasswordViewController
//            AppUtility.SegueFromLeftViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
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


