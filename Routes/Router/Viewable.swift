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
    
    var appname: String? {
        Bundle.main.infoDictionary?["CFBundleName"] as? String
    }
}

extension Viewable {
    var viewController: UIViewController? {
        guard let appname = appname, let id = id,
              let viewControllerType = NSClassFromString("\(appname).\(id)") as? UIViewController.Type  else {
            return nil
        }
        return viewControllerType.init()
    }
}
