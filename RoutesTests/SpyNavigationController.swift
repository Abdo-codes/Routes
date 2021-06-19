//
//  SpyNavigationController.swift
//  RoutesTests
//
//  Created by Abdoelrhman Eaita on 19/06/2021.
//

import UIKit

class SpyNavigationController: UINavigationController {
    var userpushedViewController: UIViewController?
    var userpresentedViewController: UIViewController?
    var userdidpopViewController = false
    var userdidDismissViewController = false
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        userpushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        userpresentedViewController = viewControllerToPresent
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        userdidpopViewController = true
        return super.popViewController(animated: true)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        userdidDismissViewController = true
        super.dismiss(animated: flag, completion: completion)
    }
}
