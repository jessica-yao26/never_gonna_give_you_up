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

    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("inside view did load")
        print("this is username unique")
        view.bringSubview(toFront: forwardButton)
        let hideIconImage = UIImage(named: "view")
        let viewIconImage = UIImage(named: "hide")
        hideIcon.setBackgroundImage(hideIconImage, for: .normal)
        viewIcon.setBackgroundImage(viewIconImage, for: .normal)
        hideIcon.isHidden = true;
        AppUtility.setArrowButtonImages(backButton: backButton, forwardButton: forwardButton)
        firstNameField.setTextboxOutlineDarkGrey()
        lastNameField.setTextboxOutlineDarkGrey()
        passwordField.setTextboxOutlineDarkGrey()

        if(UserDefaults.standard.string(forKey: "first_name") != nil) {
            firstNameField.text = UserDefaults.standard.string(forKey: "first_name")
        }
        
        if(UserDefaults.standard.string(forKey: "last_name") != nil) {
            lastNameField.text = UserDefaults.standard.string(forKey: "last_name")
        }
        
        if(UserDefaults.standard.string(forKey: "password") != nil) {
            passwordField.text = UserDefaults.standard.string(forKey: "password")
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) {
//        textField.resignFirstResponder()
        if (textField == firstNameField) {
            lastNameField.becomeFirstResponder()
        }
        else if (textField == lastNameField) {
            passwordField.becomeFirstResponder()
        }
        else{
            savesFieldsAndMinimizesKeyboard()
            checkNameFieldAndSendsToNextViewController()
        }
        
//        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // validators
    // do one with a callback escaping completion
    func isNameFieldValid(first_name: String, last_name: String) -> Bool {
//        checkUsernameUniqueOnLoad(username: self.usernameField.text!, completion: { response in })
//        print(self.usernameUnique)
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
        else if(!AppUtility.isValid(testStr: first_name, regex: AppUtility.nameRegex) || !AppUtility.isValid(testStr: last_name, regex: AppUtility.nameRegex) ){
            self.showToast(message: "Please enter a valid name")
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
    }
    
    @IBAction func lastNameReturnPressed(_ sender: Any) {
        textFieldShouldReturn(textField: lastNameField)
    }
    
    @IBAction func nextPressedFromNameScreen(_ sender: Any) {
        savesFieldsAndMinimizesKeyboard()
        checkNameFieldAndSendsToNextViewController()
    }
    
    @IBAction func backPressedFromNameScreen(_ sender: Any) {
        savesFieldsAndMinimizesKeyboard()
    }
    
    @IBAction func passwordReturn(_ sender: Any) {
        savesFieldsAndMinimizesKeyboard()
        checkNameFieldAndSendsToNextViewController()
    }
    
    @IBAction func viewIconTouched(_ sender: Any) {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry;
        hideIcon.isHidden = !hideIcon.isHidden
        viewIcon.isHidden = !viewIcon.isHidden

    }
    func savesFieldsAndMinimizesKeyboard() {
        UserDefaults.standard.set(self.firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "first_name")
        UserDefaults.standard.set(self.lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "last_name")
        UserDefaults.standard.set(self.passwordField.text, forKey: "password")
    }

    func checkNameFieldAndSendsToNextViewController() {
        if(isNameFieldValid(first_name: (self.firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, last_name: (self.lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)){
                                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChooseUsernameViewController") as! ChooseUsernameViewController
            AppUtility.SegueFromRightViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
    }
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


