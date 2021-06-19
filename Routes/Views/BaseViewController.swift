//
//  BaseViewController.swift
//  Routes
//
//  Created by Abdoelrhman Eaita on 19/06/2021.
//

import UIKit

class BaseViewController: UIViewController, Routable {
    var router: Router?

    lazy var textField: UITextField =  {
        let textField = UITextField()
        return textField
    }()
    
    lazy var button: UIButton =  {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = 16.0
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(button)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(stackView)
        makeConstrains()
    }
    
    private func makeConstrains() {
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 12),
                           stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
                           stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
                           stackView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        view.addConstraints(constraints)
    }
    
    @objc func didTap(_ sender: UIButton) {
        router?.presentableTappedNext(id)
    }
}
