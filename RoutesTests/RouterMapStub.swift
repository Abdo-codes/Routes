//
//  RouterMapStub.swift
//  RoutesTests
//
//  Created by Abdoelrhman Eaita on 19/06/2021.
//

import Foundation
@testable import Routes

struct RouterStub: RouterMap {
    var flow = [AuthStep]()
    
    init(_ flow: [AuthStep]) {
        self.flow = flow
    }
    var firstView: Viewable? {
        flow.first?.view
    }
    
    func nextViewable(_ senderId: String) -> Viewable? {
        guard senderId.isEmpty else {
            return flow.first?.view
        }
        
        return nil
    }
    
    func view(for id: String) -> Viewable? {
        flow.first?.view
    }
}
