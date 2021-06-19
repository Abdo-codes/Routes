//
//  ViewController.swift
//  Routes
//
//  Created by Abdoelrhman Eaita on 05/06/2021.
//

import UIKit


class ViewController: BaseViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Username"
        textField.placeholder = "Username"
        button.setTitle("Continue", for: .normal)
    }
}

