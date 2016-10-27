import XCTest
@testable import TableControlling

class DynamicTableTests: XCTestCase {
    
    // MARK: equals tests
    
    var lhs: DynamicTable<None, None, None, None, None>!
    var rhs: DynamicTable<None, None, None, None, None>!
    
    func test_equals_bothReady_true() {
        (lhs, rhs) = (.ready, .ready)
        AssertSymmetricallyEqual(lhs, rhs)
    }
    
    func test_equals_bothLoading_true() {
        (lhs, rhs) = (.loading, .loading)
        AssertSymmetricallyEqual(lhs, rhs)
    }
    
    func test_equals_bothDisplaying_sameTable_true() {
        (lhs, rhs) = (.displaying(.create()), .displaying(.create()))
        AssertSymmetricallyEqual(lhs, rhs)
    }
    
    func test_equals_bothDisplaying_differentTables_false() {
        (lhs, rhs) = (.displaying(.create()), .displaying(.create(sections: [.create()])))
        AssertSymmetricallyNotEqual(lhs, rhs)
    }
    
    func test_equals_oneReadyOneLoading_false() {
        (lhs, rhs) = (.ready, .loading)
        AssertSymmetricallyNotEqual(lhs, rhs)    }
    
    func test_equals_bothFailed_sameError_true() {
        (lhs, rhs) = (.failed(Failure.bees), .failed(Failure.bees))
        AssertSymmetricallyEqual(lhs, rhs)
    }
    
    enum Failure: Error { case ants, bees }
    
    func test_equals_bothFailed_differentErrors_false() {
        (lhs, rhs) = (.failed(Failure.ants), .failed(Failure.bees))
        AssertSymmetricallyNotEqual(lhs, rhs)    }
    
    // MARK: numberOfSections tests
    
    typealias IntTableSection = TableSection<None, Int, None>
    typealias IntTable = Table<None, None, Int, None, None>
    typealias IntDynamicTable = DynamicTable<None, None, Int, None, None>
    var sut: IntDynamicTable!
    
    func test_numberOfSections_displaying_1Section_returns1() {
        sut = .displaying(.create(sections: [.create()]))
        XCTAssertEqual(1, sut.numberOfSections)
    }
    
    func test_numberOfSections_notDisplaying_returns0() {
        sut = .failed(Failure.bees)
        XCTAssertEqual(0, sut.numberOfSections)
    }
    
    func test_numberOfSections_displaying_3Sections_returns3() {
        let threeSectionTable: IntTable = .create(sections: [.create(), .create(), .create()])
        sut = .displaying(threeSectionTable)
        XCTAssertEqual(3, sut.numberOfSections)
    }
    
    // MARK: numberOfItems(inSection:) tests
    
    func test_numberOfItemsInSection_0_displaying_1ItemInSection0_returns1() {
        sut = .displaying(.create(sections: [.create(cells: [1])]))
        XCTAssertEqual(1, sut.numberOfItems(inSection: 0))
    }
    
    func test_numberOfItemsInSection_notDisplaying_returns0() {
        sut = .loading
        XCTAssertEqual(0, sut.numberOfItems(inSection: 3))
    }
    
    func test_numberOfItemsInSection_2_displaying_3ItemsInSection2_returns3() {
        let threeCellSection: IntTableSection = .create(cells: [0, 0, 0])
        let fourSectionTable: IntTable = .create(
            sections: [.create(), .create(), threeCellSection, .create()]
        )
        sut = .displaying(fourSectionTable)
        XCTAssertEqual(3, sut.numberOfItems(inSection: 2))
    }
    
    // MARK: item(at:) tests
    
    func test_itemAt_row0section0_displaying_99AtRow0Section0_returns99() {
        sut = .displaying(.create(sections: [.create(cells: [99])]))
        XCTAssertEqual(99, sut.item(at: IndexPath(row: 0, section: 0)))
    }
    
    func test_itemAt_row2section9_notDisplaying_returnsNil() {
        sut = .ready
        XCTAssertNil(sut.item(at: IndexPath(row: 2, section: 9)))
    }
    
    func test_itemAt_row3section1_displaying_516AtRow3Section1_returns516() {
        let fourRowSection: IntTableSection = .create(cells: [0, 0, 0, 516])
        sut = .displaying(.create(sections: [.create(), fourRowSection]))
        XCTAssertEqual(516, sut.item(at: IndexPath(row: 3, section: 1)))
    }
}
