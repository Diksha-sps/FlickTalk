//
//  RegisterViewController.swift
//  Bubbly
//
//  Created by Sharandeep Singh on 04/10/24.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    //MARK: - LifeCycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    //MARK: - IBActions
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(ofType: .insufficientData)
            
            return
        }
        
        let indicator = showLoader()
        
        /// Creation of user or signup process using firebase
        Auth.auth().createUser(withEmail: email,
                               password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            hideLoader(indicator: indicator)
            
            if let e = error {
                showAlert(ofType: .externalError(e))
            } else {
                performSegue(withIdentifier: "ChatViewController", sender: self)
            }
        }
    }
    
    //MARK: - UIConfiguration Methods
    private func configureUI() {
        emailTextField.layer.cornerRadius = 16
        passwordTextField.layer.cornerRadius = 16
        registerButton.layer.cornerRadius = 16
    }
}
