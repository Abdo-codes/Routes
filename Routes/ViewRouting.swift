//
//  ViewRouting.swift
//  Routes
//
//  Created by Abdoelrhman Eaita on 05/06/2021.
//

import UIKit

enum AuthSteps {
    case username
    case password
    case custom(view: Viewable)
    
    var view: Viewable {
        switch self {
        case .custom(let view):
            return view
        case .username:
            return Viewable(id: "ViewController", presentationType: .push)
        case .password:
            return Viewable(id: "SecondViewController", presentationType: .push)
        }
    }
}
