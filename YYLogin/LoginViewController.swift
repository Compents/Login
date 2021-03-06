//
//  YYLoginViewController.swift
//  YYLoginViewController
//
//  Created by Yalin on 15/6/3.
//  Copyright (c) 2015年 yalin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Property
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logoUpConstraint: NSLayoutConstraint!
    
    func performOperation(operation :Double -> Double)
    {
        
    }
    
    
    // MARK: - Life Cycle
    deinit {
        // perform the deinitialization
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "登录"
        
        let keyboardShowSelector: Selector = "keyboardShow"
        let keyboardHideSelector: Selector = "keyboardHide"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: keyboardShowSelector, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: keyboardHideSelector, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - response method
    @IBAction func loginButtonPressed(sender: UIButton?) {
        
        LoginRequest.login(usernameTextField.text, password: passwordTextField.text) { (userInfo : NSDictionary?, error : NSError?) -> Void in
            if let err = error {
                let alert = UIAlertView(title: "登录失败", message: err.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            else {
                let alert = UIAlertView(title: "登录成功", message: "", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
        }
        backgroundPressed(sender)
    }
    
    @IBAction func backgroundPressed(sender: AnyObject?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
    }

    // MARK: - KeyboardNotification
    func keyboardShow() {
        if !self.usernameTextField.isFirstResponder() && !self.passwordTextField.isFirstResponder() {
            return
        }
        logoUpConstraint.constant = 10
        view.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardHide() {
        if !self.usernameTextField.isFirstResponder() && !self.passwordTextField.isFirstResponder() {
            return
        }
        
        logoUpConstraint.constant = 124
        view.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    // MARK: - UITextFieldDelegate
    // 按回车可以登录
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if string == "\n" {
            loginButtonPressed(nil)
            return false
        }
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
