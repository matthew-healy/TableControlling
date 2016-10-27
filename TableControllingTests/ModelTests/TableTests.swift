import XCTest
@testable import TableControlling

class TableTests: XCTestCase {
    
    // MARK: init tests
    
    func test_init_noArguments_headerIsNil() {
        let sut = Table<None, None, None, None, None>()
        XCTAssertNil(sut.header)
    }
    
    func test_init_noArguments_sectionsIsEmpty() {
        let sut = Table<None, None, None, None, None>()
        XCTAssertTrue(sut.sections.isEmpty)
    }
    
    func test_init_noArguments_footerIsNil() {
        let sut = Table<None, None, None, None, None>()
        XCTAssertNil(sut.footer)
    }
    
    func test_init_headerABC_headerIsABC() {
        let expectedHeader = "ABC"
        let sut = Table<String, None, None, None, None>(header: "ABC")
        XCTAssertEqual(expectedHeader, sut.header)
    }
    
    func test_init_sectionsWithCellsAAndB_sectionsHaveCellsAAndB() {
        let expectedSections = [
            TableSection<None, String, None>(cells: ["A"]),
            TableSection<None, String, None>(cells: ["B"])
        ]
        let sut = Table<None, None, String, None, None>(sections: expectedSections)
        XCTAssertEqual(expectedSections, sut.sections)
    }
    
    func test_init_footerDEF_footerIsDEF() {
        let expectedFooter = "DEF"
        let sut = Table<None, None, None, None, String>(footer: "DEF")
        XCTAssertEqual(expectedFooter, sut.footer)
    }
    
    // MARK: equals tests
    
    var lhs: Table<Bool, Bool, Bool, Bool, Bool>!
    var rhs: Table<Bool, Bool, Bool, Bool, Bool>!
    
    func test_equals_headerSectionsAndFooterMatch_true() {
        (lhs, rhs) = (.create(), .create())
        XCTAssertEqual(lhs, rhs)
        XCTAssertEqual(rhs, lhs)
    }
    
    func test_equals_headersDoNotMatch_false() {
        (lhs, rhs) = (.create(header: false), .create(header: true))
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(rhs, lhs)
    }
    
    func test_equals_sectionsDoNotMatch_false() {
        lhs = .create(sections: [.create(header: false)])
        rhs = .create(sections: [])
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(rhs, lhs)
    }
    
    func test_equals_footerDoNotMatch_false() {
        (lhs, rhs) = (.create(footer: false), .create(footer: true))
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(rhs, lhs)
    }
    
    // MARK: numberOfSections tests
    
    func test_numberOfSections_emptySections_returns0() {
        let sut = Table<None, None, None, None, None>()
        XCTAssertEqual(0, sut.numberOfSections)
    }
    
    func test_numberOfSections_threeSections_returns3() {
        let sections = [
            TableSection<None, None, None>(),
            TableSection<None, None, None>(),
            TableSection<None, None, None>()
        ]
        let sut = Table<None, None, None, None, None>(sections: sections)
        XCTAssertEqual(3, sut.numberOfSections)
    }
    
    // MARK: numberOfItems(inSection:) tests
    
    func test_numberOfItemsInSection_noSections_returns0() {
        let sut = Table<None, None, None, None, None>()
        XCTAssertEqual(0, sut.numberOfItems(inSection: 0))
    }
    
    func test_numberOfItemsInSection_0_sectionHas3Cells_returns3() {
        let section = TableSection<None, Int, None>(cells: [0, 0, 0])
        let sut = Table<None, None, Int, None, None>(sections: [section])
        XCTAssertEqual(3, sut.numberOfItems(inSection: 0))
    }
    
    func test_numberOfItemsInSection_1_sectionHas1Cell_returns1() {
        let section = TableSection<None, Int, None>(cells: [1])
        let sut = Table<None, None, Int, None, None>(
            sections: [TableSection<None, Int, None>(), section]
        )
        XCTAssertEqual(1, sut.numberOfItems(inSection: 1))
    }
    
    // MARK: item(at:_) tests
    
    func test_itemAt_row0section0_emptySections_returnsNil() {
        let sut = Table<None, None, None, None, None>()
        XCTAssertNil(sut.item(at: IndexPath(row: 0, section: 0)))
    }
    
    func test_itemAt_row0section0_sectionFirstCellIsA_returnsA() {
        let section = TableSection<None, String, None>(cells: ["A"])
        let sut = Table<None, None, String, None, None>(
            sections: [section]
        )
        XCTAssertEqual("A", sut.item(at: IndexPath(row: 0, section: 0)))
    }
    
    func test_itemAt_row1section3_secondSectionThirdCellIs12_returns12() {
        let section = TableSection<None, Int, None>(cells: [0, 0, 0, 12])
        let sut = Table<None, None, Int, None, None>(
            sections: [TableSection<None, Int, None>(), section]
        )
        XCTAssertEqual(12, sut.item(at: IndexPath(row: 3, section: 1)))
    }
    
}

extension Table {
    static func create(
        header: Header? = nil,
        sections: [Table.Section] = [],
        footer: Footer? = nil
    ) -> Table<Header, SectionHeader, Cell, SectionFooter, Footer> {
        return Table(header: header, sections: sections, footer: footer)
    }
}
