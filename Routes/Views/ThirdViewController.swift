//
//  ThirdViewController.swift
//  Routes
//
//  Created by Abdoelrhman Eaita on 05/06/2021.
//

import UIKit

class ThirdViewController: BaseViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Email"
        textField.placeholder = "Email"
        button.setTitle("Continue", for: .normal)
    }
}
