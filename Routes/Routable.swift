//
//  Routable.swift
//  Routes
//
//  Created by Abdoelrhman Eaita on 19/06/2021.
//

import Foundation

protocol Routable: AnyObject {
    var router: Router? { get set }
    var id: String { get }
}

extension Routable {
    var id :String {
        String(describing: Self.self)
    }
}
