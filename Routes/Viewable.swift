//
//  Viewable.swift
//  Routes
//
//  Created by Abdoelrhman Eaita on 19/06/2021.
//

import UIKit

struct Viewable: Identifiable {
    var id: String?
    var presentationType: PresentationType
}

extension Viewable {
    var viewController: UIViewController? {
        if let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String, let id = id {
            if let viewControllerType = NSClassFromString("\(appName).\(id)") as? UIViewController.Type {
                return viewControllerType.init()
            }
        }

        return nil
    }
}
