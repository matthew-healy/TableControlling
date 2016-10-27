import XCTest
@testable import TableControlling

class StaticTableTests: XCTestCase {
    
    // MARK: equals tests
    
    var lhs: StaticTable<None, None, String, None, None>!
    var rhs: StaticTable<None, None, String, None, None>!
    
    func test_equals_bothReady_true() {
        (lhs, rhs) = (.ready, .ready)
        AssertSymmetricallyEqual(lhs, rhs)
    }
    
    func test_equals_oneReadyOneDisplay_false() {
        (lhs, rhs) = (.ready, .displaying(.create()))
        AssertSymmetricallyNotEqual(lhs, rhs)    }
    
    func test_equals_bothDisplayMatchingTables_true() {
        lhs = .displaying(.create())
        rhs = .displaying(.create())
        AssertSymmetricallyEqual(lhs, rhs)
    }
    
    func test_equals_bothDisplayDifferentTables_false() {
        lhs = .displaying(.create(sections: [.create()]))
        rhs = .displaying(.create())
        AssertSymmetricallyNotEqual(lhs, rhs)    }
    
    // MARK: numberOfSections tests
    
    typealias StringStaticTable = StaticTable<None, None, String, None, None>
    typealias StringTable = Table<None, None, String, None, None>
    typealias StringTableSection = TableSection<None, String, None>
    var sut: StringStaticTable!
    
    func test_numberOfSections_ready_returns0() {
        sut = .ready
        XCTAssertEqual(0, sut.numberOfSections)
    }
    
    func test_numberOfSections_display_with1Section_returns1() {
        sut = .displaying(.create(sections: [.create()]))
        XCTAssertEqual(1, sut.numberOfSections)
    }
    
    func test_numberOfSections_display_with0Sections_returns0() {
        sut = .displaying(.create())
        XCTAssertEqual(0, sut.numberOfSections)
    }
    
    // MARK: numberOfItems(inSection:_) tests
    
    func test_numberOfItemsInSection_0_ready_returns0() {
        sut = .ready
        XCTAssertEqual(0, sut.numberOfItems(inSection: 0))
    }
    
    func test_numberOfItemsInSection_0_display_2CellsInSection0_returns2() {
        let twoCellSection: StringTableSection = .create(cells: ["", ""])
        sut = .displaying(.create(sections: [twoCellSection]))
        XCTAssertEqual(2, sut.numberOfItems(inSection: 0))
    }
    
    func test_numberOfItemsInSection_3_display_1CellInSection3_returns3() {
        let oneCellSection: StringTableSection = .create(cells: [""])
        sut = .displaying(
            .create(sections: [.create(), .create(), .create(), oneCellSection])
        )
        XCTAssertEqual(1, sut.numberOfItems(inSection: 3))
    }
    
    // MARK: item(at:) tests
    
    func test_itemAt_row0section1_ready_returnsNil() {
        sut = .ready
        XCTAssertNil(sut.item(at: IndexPath(row: 0, section: 1)))
    }
    
    func test_itemAt_row2Section0_display_cellHEYYAAtRow2Section0_returnsHEYYA() {
        let threeCellSection: StringTableSection = .create(cells: ["", "", "HEY YA"])
        sut = .displaying(.create(sections: [threeCellSection]))
        XCTAssertEqual("HEY YA", sut.item(at: IndexPath(row: 2, section: 0)))
    }
    
    func test_itemAt_row1section2_display_cellSupAtRow1Section2_returnsSup() {
        let twoCellSection: StringTableSection = .create(cells: ["", "Sup"])
        sut = .displaying(.create(sections: [.create(), .create(), twoCellSection]))
        XCTAssertEqual("Sup", sut.item(at: IndexPath(row: 1, section: 2)))
    }

}
