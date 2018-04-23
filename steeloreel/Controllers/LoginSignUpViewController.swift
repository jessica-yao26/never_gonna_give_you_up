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
    }
    
    @IBDesignable
    class LeftAlignedIconButton: UIButton {
        override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
            let titleRect = super.titleRect(forContentRect: contentRect)
            let imageSize = currentImage?.size ?? .zero
            let availableWidth = contentRect.width - imageEdgeInsets.right - imageSize.width - titleRect.width
            return titleRect.offsetBy(dx: round(availableWidth / 2), dy: 0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Helper functions
    
    // Email validators
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: testStr)
    }
    
    func isEmailFieldValid(email: String) -> Bool {
        if(email.isEmpty) {
            emailField.becomeFirstResponder()
            self.showToast(message: "Please enter your email")
            return false;
        }
        if(!isValidEmail(testStr: email)) {
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
                        UserDefaults.standard.set(email, forKey: "email")
                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
                        AppUtility.SegueFromLeftViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
                    }
                    else if(statusCode == 200) {
                        UserDefaults.standard.set(email, forKey: "email")
                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnterPasswordViewController") as! EnterPasswordViewController
                        AppUtility.SegueFromLeftViewControllerHelper(sourceViewController: self, destinationViewController: nextViewController)
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
