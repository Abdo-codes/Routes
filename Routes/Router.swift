//
//  Router.swift
//  Routes
//
//  Created by Abdoelrhman Eaita on 19/06/2021.
//

import UIKit

class Router {
    var navigationController: UINavigationController?
    var mapper: RouterMap
    
    init(_ nav: UINavigationController = UINavigationController(), mapper: RouterMap) {
        self.mapper = mapper
        self.navigationController = nav
        guard let viewController = mapper.firstView?.viewController else { return }
        
        (viewController as? Routable)?.router = self
        self.navigationController?.setViewControllers([viewController], animated: false)
    }
    
    func presentableTappedNext(_ senderId: String) {
        guard let view = mapper.nextViewable(senderId),
              let viewController = view.viewController else { return }
        
        (viewController as? Routable)?.router = self
        
        switch view.presentationType {
        case .present:
            navigationController?.present(viewController, animated: true, completion: nil)
        default:
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func back(_ senderId: String) {
        guard let item = mapper.view(for: senderId) else { return }
        
        switch item.presentationType {
        case .push:
            navigationController?.popViewController(animated: true)
        default:
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
}
