//
//  RouterMap.swift
//  Routes
//
//  Created by Abdoelrhman Eaita on 19/06/2021.
//

import Foundation

protocol RouterMap {
    var firstView: Viewable? { get }
    func nextViewable(_ senderId: String) -> Viewable?
    func view(for id: String) -> Viewable?
}

struct RouterMapper: RouterMap {
    var flow = [Viewable]()

    init(_ flow: [AuthSteps]) {
        self.flow = flow.compactMap { $0.view }
    }
    
    var firstView: Viewable? {
        flow.first
    }
    
    func nextViewable(_ senderId: String) -> Viewable? {
        let index = flow.firstIndex { view in
            view.id == senderId
        }
        
        guard let next = index?.advanced(by: 1),
              next < flow.count else { return nil }
        
        return flow[next]
    }
    
    func view(for id: String) -> Viewable? {
        let item = flow.first { view in
            view.id == id
        }
        return item
    }
}
