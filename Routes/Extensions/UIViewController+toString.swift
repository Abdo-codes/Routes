//
//  UIViewController+toString.swift
//  Routes
//
//  Created by Abdoelrhman Eaita on 19/06/2021.
//

import UIKit

extension UIViewController {
    static var toString :String {
        String(describing: Self.self)
    }
}

