import XCTest
@testable import TableControlling

class DynamicTableTests: XCTestCase {
    
    // MARK: equals tests
    
    var lhs: DynamicTable<None, None, None, None, None>!
    var rhs: DynamicTable<None, None, None, None, None>!
    
    func test_equals_bothReady_true() {
        (lhs, rhs) = (.ready, .ready)
        XCTAssertEqual(lhs, rhs)
        XCTAssertEqual(rhs, lhs)
    }
    
    func test_equals_bothLoading_true() {
        (lhs, rhs) = (.loading, .loading)
        XCTAssertEqual(lhs, rhs)
        XCTAssertEqual(rhs, lhs)
    }
    
    func test_equals_bothDisplaying_sameTable_true() {
        (lhs, rhs) = (.displaying(.create()), .displaying(.create()))
        XCTAssertEqual(lhs, rhs)
        XCTAssertEqual(rhs, lhs)
    }
    
    func test_equals_bothDisplaying_differentTables_false() {
        (lhs, rhs) = (.displaying(.create()), .displaying(.create(sections: [.create()])))
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(rhs, lhs)
    }
    
    func test_equals_oneReadyOneLoading_false() {
        (lhs, rhs) = (.ready, .loading)
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(rhs, lhs)
    }
    
    func test_equals_bothFailed_sameError_true() {
        (lhs, rhs) = (.failed(Failure.bees), .failed(Failure.bees))
        XCTAssertEqual(lhs, rhs)
        XCTAssertEqual(rhs, lhs)
    }
    
    enum Failure: Error { case ants, bees }
    
    func test_equals_bothFailed_differentErrors_false() {
        (lhs, rhs) = (.failed(Failure.ants), .failed(Failure.bees))
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(rhs, lhs)
    }
    
    // MARK: numberOfSections tests
    
    typealias IntTableSection = TableSection<None, Int, None>
    typealias IntTable = Table<None, None, Int, None, None>
    typealias IntDynamicTable = DynamicTable<None, None, Int, None, None>
    var sut: IntDynamicTable!
    
    func test_numberOfSections_displayingTableWith1Section_returns1() {
        sut = .displaying(.create(sections: [.create()]))
        XCTAssertEqual(1, sut.numberOfSections)
    }
    
    func test_numberOfSections_notDisplaying_returns0() {
        sut = .failed(Failure.bees)
        XCTAssertEqual(0, sut.numberOfSections)
    }
    
    func test_numberOfSections_displayingTableWith3Sections_returns3() {
        let threeSectionTable: IntTable = .create(sections: [.create(), .create(), .create()])
        sut = .displaying(threeSectionTable)
        XCTAssertEqual(3, sut.numberOfSections)
    }
}
