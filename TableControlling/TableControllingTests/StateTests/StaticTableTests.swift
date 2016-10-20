import XCTest
@testable import TableControlling

class StaticTableTests: XCTestCase {
    
    // MARK: equals tests
    
    var lhs: StaticTable<None, None, String, None, None>!
    var rhs: StaticTable<None, None, String, None, None>!
    
    func test_equals_bothReady_true() {
        (lhs, rhs) = (.ready, .ready)
        XCTAssertEqual(lhs, rhs)
        XCTAssertEqual(rhs, lhs)
    }
    
    func test_equals_oneReadyOneDisplay_false() {
        (lhs, rhs) = (.ready, .display(.create()))
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(rhs, lhs)
    }
    
    func test_equals_bothDisplayMatchingTables_true() {
        lhs = .display(.create())
        rhs = .display(.create())
        XCTAssertEqual(lhs, rhs)
        XCTAssertEqual(rhs, lhs)
    }
    
    func test_equals_bothDisplayDifferentTables_false() {
        lhs = .display(.create(sections: [.create()]))
        rhs = .display(.create())
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(rhs, lhs)
    }
    
    // MARK: numberOfSections tests
    
    var staticStringTable: StaticTable< None, None, String, None, None>!
    
    func test_numberOfSections_ready_returns0() {
        staticStringTable = .ready
        XCTAssertEqual(0, staticStringTable.numberOfSections)
    }
    
    func test_numberOfSections_display_with1Section_returns1() {
        staticStringTable = .display(.create(sections: [.create()]))
        XCTAssertEqual(1, staticStringTable.numberOfSections)
    }
    
    func test_numberOfSections_display_with0Sections_returns0() {
        staticStringTable = .display(.create())
        XCTAssertEqual(0, staticStringTable.numberOfSections)
    }
    
    // MARK: numberOfItems(inSection:_) tests
    
    func test_numberOfItemsInSection_0_ready_returns0() {
        staticStringTable = .ready
        XCTAssertEqual(0, staticStringTable.numberOfItems(inSection: 0))
    }
    
    func test_numberOfItemsInSection_0_display_2CellsInSection0_returns2() {
        let twoCellSection: TableSection<None, String, None> = .create(cells: ["", ""])
        staticStringTable = .display(.create(sections: [twoCellSection]))
        XCTAssertEqual(2, staticStringTable.numberOfItems(inSection: 0))
    }
    
    func test_numberOfItemsInSection_3_display_1CellInSection3_returns3() {
        let oneCellSection: TableSection<None, String, None> = .create(cells: [""])
        staticStringTable = .display(
            .create(sections: [.create(), .create(), .create(), oneCellSection])
        )
        XCTAssertEqual(1, staticStringTable.numberOfItems(inSection: 3))
    }

}
