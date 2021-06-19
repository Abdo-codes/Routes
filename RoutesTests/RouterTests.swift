//
//  RouterTests.swift
//  RoutesTests
//
//  Created by Abdoelrhman Eaita on 19/06/2021.
//

import XCTest

@testable import Routes

class RouterTests: XCTestCase {
    var sut: Router!
    var spyNavController: SpyNavigationController!
    
    override func setUpWithError() throws {
        spyNavController = SpyNavigationController()
        sut = Router(spyNavController, mapper: RouterStub([.password, .username]))
    }

    override func tearDownWithError() throws {
        sut = nil
        spyNavController = nil
    }

    func testGivenTappedWithIDWhenUserTapNextOnPush() {
        //given
        let firstController = AuthStep.password
        
        // when
        sut.presentableTappedNext( firstController.view.id!)
        
        // then
        let pushed = spyNavController.userpushedViewController as? Routable
        
        XCTAssertNotNil(pushed)
        
        XCTAssertEqual(pushed?.id, firstController.view.id!)
    }
    
    func testGivenTappedWithIDWhenUserTapNextOnPresent() {
        //given
        let step: AuthStep = .custom(view: Viewable(id: "ThirdViewController",
                                                     presentationType: .present))
        let mapper = RouterStub([step])
        sut.mapper = mapper
        
        // when
        sut.presentableTappedNext( step.view.id!)
        
        // then
        let presented = spyNavController.userpresentedViewController as? Routable
        
        XCTAssertNotNil(presented)
        
        XCTAssertEqual(presented?.id, step.view.id!)
    }
    
    func testGivenTappedWithNoIDWhenUserTapNext() {
        //given
        let controllerID = ""
        
        //when
        sut.presentableTappedNext(controllerID)
        
        //then
        XCTAssertNil(spyNavController.userpushedViewController)
    }
    
    func testGivenTappedBackOnPush() {
        // given another view is pushed
        let secondController = AuthStep.username
        let passId = AuthStep.password.view.id
        
        
        // when
        sut.presentableTappedNext(secondController.view.id!)
        sut.back(passId!)
        
        // then
        XCTAssertTrue(spyNavController.userdidpopViewController)
    }
    
    func testGivenTappedBackOnPresent() {
        //given
        let step: AuthStep = .custom(view: Viewable(id: "ThirdViewController",
                                                     presentationType: .present))
        let mapper = RouterStub([step])
        sut.mapper = mapper
        
        // when
        sut.presentableTappedNext( step.view.id!)
        sut.back(step.view.id!)
        
        // then
        XCTAssertTrue(spyNavController.userdidDismissViewController)
    }
    
}
