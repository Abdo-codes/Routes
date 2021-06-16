//
//  ViewRouting.swift
//  Routes
//
//  Created by Abdoelrhman Eaita on 05/06/2021.
//

import UIKit

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
            print("CFBundleName - \(appName)")
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


var flow: [Viewable] {
    let first = Viewable(id: "ViewController", presentationType: .push)
    let second = Viewable(id: "SecondViewController", presentationType: .push)
    let third = Viewable(id: "ThirdViewController", presentationType: .push)
    let fourth = Viewable(id: "ViewController", presentationType: .push)
    let fifth = Viewable(id: "SecondViewController", presentationType: .push)
    let sixth = Viewable(id: "ThirdViewController", presentationType: .push)
    return [first, second, third, fourth, fifth, sixth]
}

class Router {
    var navigationController: UINavigationController?
    var flow = [Viewable]()
    
    init(_ nav: UINavigationController, flow: [Viewable]) {
       
        self.flow = flow
        self.navigationController = nav
    }
    
    func presentableTappedNext(_ senderId: String) {
        let index = flow.firstIndex { view in
            view.id?.className == senderId
        }
        
        guard let next = index?.advanced(by: 1) else { return }
        
        let nextViewable = flow[next]
        
        guard let view = nextViewable.viewController else { return }
        
        (view as? Routable)?.router = self
        
        switch nextViewable.presentationType {
        case .present:
            navigationController?.present(view, animated: true, completion: nil)
        default:
            navigationController?.pushViewController(view, animated: true)
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
