//
//  ViewRouting.swift
//  Routes
//
//  Created by Abdoelrhman Eaita on 05/06/2021.
//

import UIKit


/*
 
 
  - >> - >> - >> - >>
 
 
 
 
 */


enum PresentationType {
    case push
    case present
}


protocol Routable: AnyObject {
    var router: Router? { get set }
    var id: String { get }
}


extension Routable {
    var id :String {
        NSStringFromClass(Self.self)
    }
}

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

extension String {
    var className: String? {
        guard let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String else { return nil }
        return "\(appName).\(self)"
    }
}

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

class Router {
    var navigationController: UINavigationController?
    var flow = [Viewable]()
    
    init(_ nav: UINavigationController = UINavigationController(), flow: [AuthSteps]) {
       
        self.flow = flow.compactMap { $0.view }
        self.navigationController = nav
        guard let viewController = flow.first?.view.viewController else {
            return
        }
        (viewController as? Routable)?.router = self
        self.navigationController?.setViewControllers([viewController], animated: false)
    }
    
    func nextViewable(_ senderId: String) -> Viewable? {
        let index = flow.firstIndex { view in
            view.id?.className == senderId
        }
        
        guard let next = index?.advanced(by: 1), next < flow.count else { return nil }
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
