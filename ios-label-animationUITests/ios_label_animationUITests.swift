//
//  ios_label_animationUITests.swift
//  ios-label-animationUITests
//
//  Created by Ivan M on 10/7/15.
//  Copyright © 2015 ivan3bx. All rights reserved.
//

import XCTest

class ios_label_animationUITests: XCTestCase {
    var firstLabel: UILabel!
    var secondLabel: UILabel!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testToggle() {
        XCUIApplication().launch()
        let toggleButton = XCUIApplication().buttons["Toggle"]

        toggleButton.tap()
        
        // TODO: how to assert a specific element is 'hidden' after animation?
        
        toggleButton.tap()

        // TODO: how to assert a specific element is 'hidden' after animation?
    }
    
}
