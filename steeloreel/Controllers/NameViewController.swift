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
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.setArrowButtonImages(backButton: backButton, forwardButton: forwardButton)
        firstNameField.setBottomBorder()
        lastNameField.setBottomBorder()
        if(UserDefaults.standard.string(forKey: "first_name") != nil) {
            firstNameField.text = UserDefaults.standard.string(forKey: "first_name")
        }
        if(UserDefaults.standard.string(forKey: "last_name") != nil) {
            lastNameField.text = UserDefaults.standard.string(forKey: "last_name")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Name validators
    func isValidNameString(testStr:String) -> Bool {
        let nameStringRegEx = "[A-Za-z'’.-]{2,64}"
        let nameStringTest = NSPredicate(format:"SELF MATCHES %@", nameStringRegEx)
        
        return nameStringTest.evaluate(with: testStr)
    }
    
    func isNameFieldValid(first_name: String, last_name: String) -> Bool {
        if((firstNameField.text?.isEmpty)! || (lastNameField.text?.isEmpty)!) {
            self.showToast(message: "Please enter your name")
            return false;
        }
        if(!isValidNameString(testStr: first_name) || !isValidNameString(testStr: last_name) ){
            self.showToast(message: "Please enter a valid name")
            return false;
        }
        return true;
    }
    @IBAction func firstNameReturnPressed(_ sender: Any) {
        savesFieldsAndMinimizesKeyboard()
        checkNameFieldAndSendsToNextViewController()
    }
    
    @IBAction func lastNameReturnPressed(_ sender: Any) {
        savesFieldsAndMinimizesKeyboard()
        checkNameFieldAndSendsToNextViewController()
    }
    
    @IBAction func nextPressedFromNameScreen(_ sender: Any) {
        savesFieldsAndMinimizesKeyboard()
        checkNameFieldAndSendsToNextViewController()
    }
    
    @IBAction func backPressedFromNameScreen(_ sender: Any) {
        savesFieldsAndMinimizesKeyboard()
    }
    
    func savesFieldsAndMinimizesKeyboard() {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        UserDefaults.standard.set(self.firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "first_name")
        UserDefaults.standard.set(self.lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "last_name")
    }
    
    func checkNameFieldAndSendsToNextViewController() {
        if(isNameFieldValid(first_name: (self.firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, last_name: (self.lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)) {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChooseUsernameViewController") as! ChooseUsernameViewController
            AppUtility.SegueFromLeftViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
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
