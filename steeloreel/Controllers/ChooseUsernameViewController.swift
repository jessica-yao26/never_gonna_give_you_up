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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.setArrowButtonImages(backButton: backButton, forwardButton: forwardButton)
        usernameField.setBottomBorder()
        if(UserDefaults.standard.string(forKey: "username") != nil) {
            usernameField.text = UserDefaults.standard.string(forKey: "username")
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

}
