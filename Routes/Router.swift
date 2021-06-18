//
//  Router.swift
//  Routes
//
//  Created by Abdoelrhman Eaita on 19/06/2021.
//

import UIKit

class Router {
    var navigationController: UINavigationController?
    var flow = [Viewable]()
    
    init(_ nav: UINavigationController = UINavigationController(), flow: [AuthSteps]) {
       
        self.flow = flow.compactMap { $0.view }
        self.navigationController = nav
        guard let viewController = flow.first?.view.viewController else { return }
        
        (viewController as? Routable)?.router = self
        self.navigationController?.setViewControllers([viewController], animated: false)
    }
    
    func nextViewable(_ senderId: String) -> Viewable? {
        let index = flow.firstIndex { view in
            view.id?.className == senderId
        }
        
        guard let next = index?.advanced(by: 1),
              next < flow.count else { return nil }
        
        return flow[next]
    }
    
    func presentableTappedNext(_ senderId: String) {
        guard let view = nextViewable(senderId),
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
        let item = flow.first { view in
            view.id == senderId
        }
        
        guard let item = item else { return }
        
        switch item.presentationType {
        case .push:
            navigationController?.popViewController(animated: true)
        default:
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
}
