//
//  ThirdViewController.swift
//  Routes
//
//  Created by Abdoelrhman Eaita on 05/06/2021.
//

import UIKit

class ThirdViewController: UIViewController, Routable {
    var router: Router?
    
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        button.center = view.center
    }
    
    @objc func didTap(_ sender: UIButton) {
        router?.presentableTappedNext(id)
    }
}
