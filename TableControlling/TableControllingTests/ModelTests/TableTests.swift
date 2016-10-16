import XCTest
@testable import TableControlling

class TableTests: XCTestCase {
    
    // MARK: init tests
    
    func test_init_noArguments_headerIsNil() {
        let table = Table<None, None, None, None, None>()
        XCTAssertNil(table.header)
    }
    
    func test_init_noArguments_sectionsIsEmpty() {
        let table = Table<None, None, None, None, None>()
        XCTAssertTrue(table.sections.isEmpty)
    }
    
    func test_init_noArguments_footerIsNil() {
        let table = Table<None, None, None, None, None>()
        XCTAssertNil(table.footer)
    }
    
    func test_init_headerABC_headerIsABC() {
        let expectedHeader = "ABC"
        let table = Table<String, None, None, None, None>(header: "ABC")
        XCTAssertEqual(expectedHeader, table.header)
    }
    
    func test_init_sectionsWithCellsAAndB_sectionsHaveCellsAAndB() {
        let expectedSections = [
            TableSection<None, String, None>(cells: ["A"]),
            TableSection<None, String, None>(cells: ["B"])
        ]
        let table = Table<None, None, String, None, None>(sections: expectedSections)
        XCTAssertEqual(expectedSections, table.sections)
    }
    
    func test_init_footerDEF_footerIsDEF() {
        let expectedFooter = "DEF"
        let table = Table<None, None, None, None, String>(footer: "DEF")
        XCTAssertEqual(expectedFooter, table.footer)
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
    
    // MARK numberOfSections tests
    
    func test_numberOfSections_emptySections_returns0() {
        let table = Table<None, None, None, None, None>()
        XCTAssertEqual(0, table.numberOfSections)
    }
    
    func test_numberOfSections_threeSections_returns3() {
        let sections = [
            TableSection<None, None, None>(),
            TableSection<None, None, None>(),
            TableSection<None, None, None>()
        ]
        let table = Table<None, None, None, None, None>(sections: sections)
        XCTAssertEqual(3, table.numberOfSections)
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
