//
//  FirstViewController.swift
//  HW11-TableViewPupils
//
//  Created by Игорь Тимофеев on 30.10.21.
//

import UIKit

private struct MyStrings {
    let login: String
    let password: String
}

final class FirstViewController: UIViewController {
    
    @IBOutlet weak var loginLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func verifyButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        let firstController = ViewController()
        
       let keys = MyStrings (login: "123", password: "123")
        if loginLabel.text == keys.login && passwordLabel.text == keys.password {
            present(firstController, animated: true, completion: nil)
        } else {
            loginLabel.text = ""
            passwordLabel.text = ""
        }
    }
}

