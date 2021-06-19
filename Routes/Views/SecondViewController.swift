//
//  SecondViewController.swift
//  Routes
//
//  Created by Abdoelrhman Eaita on 05/06/2021.
//

import UIKit

class SecondViewController: BaseViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Password"
        textField.placeholder = "Password"
        button.setTitle("Continue", for: .normal)
    }
}
