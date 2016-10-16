import XCTest
@testable import TableControlling

class TableSectionTests: XCTestCase {
    
    // MARK: init tests
    
    func test_init_noArguments_headerNil() {
        let tableSection = TableSection<None, None, None>()
        XCTAssertNil(tableSection.header)
    }
    
    func test_init_noArguments_cellsIsEmpty() {
        let tableSection = TableSection<None, None, None>()
        XCTAssertTrue(tableSection.cells.isEmpty)
    }
    
    func test_init_noArguments_footerNil() {
        let tableSection = TableSection<None, None, None>()
        XCTAssertNil(tableSection.footer)
    }
    
    func test_init_headerIsABC_headerABC() {
        let expectedHeader = "ABC"
        let tableSection = TableSection<String, None, None>(header: expectedHeader)
        XCTAssertEqual(expectedHeader, tableSection.header)
    }
    
    func test_init_cellsAreABAndC_cellsAreABAndC() {
        let expectedCells = ["A", "B", "C"]
        let tableSection = TableSection<None, String, None>(cells: expectedCells)
        XCTAssertEqual(expectedCells, tableSection.cells)
    }
    
    func test_init_footerIsDEF_footerIsDEF() {
        let expectedFooter = "DEF"
        let tableSection = TableSection<None, None, String>(footer: expectedFooter)
        XCTAssertEqual(expectedFooter, tableSection.footer)
    }
    
    // MARK: equatable tests
    
    var lhs: TableSection<String, Int, Bool>!
    var rhs: TableSection<String, Int, Bool>!
    
    func test_equals_headerCellsAndFooterMatch_true() {
        (lhs, rhs) = (.create(), .create())
        XCTAssertEqual(lhs, rhs)
        XCTAssertEqual(rhs, lhs)
    }
    
    func test_equals_headersDoNotMatch_false() {
        (lhs, rhs) = (.create(header: "A"), .create(header: "B"))
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(rhs, lhs)
    }
    
    func test_equals_cellsDoNotMatch_false() {
        (lhs, rhs) = (.create(cells: [1, 2, 3]), .create())
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(rhs, lhs)
    }
    
    func test_equals_footersDoNotMatch_false() {
        (lhs, rhs) = (.create(footer: false), .create(footer: true))
        XCTAssertNotEqual(lhs, rhs)
        XCTAssertNotEqual(rhs, lhs)
    }
    
    // MARK: numberOfItems tests
    
    func test_numberOfItems_cellsIsEmpty_returns0() {
        let tableSection = TableSection<None, String, None>()
        XCTAssertEqual(0, tableSection.numberOfItems)
    }
    
    func test_numberOfItems_cellsIsABCD_returns4() {
        let tableSection = TableSection<None, String, None>(cells: ["A", "B", "C", "D"])
        XCTAssertEqual(4, tableSection.numberOfItems)
    }
    
}

extension TableSection {
    
    static func create(
        header: Header? = nil,
        cells: [Cell] = [],
        footer: Footer? = nil
    ) -> TableSection<Header, Cell, Footer> {
        return TableSection(header: header, cells: cells, footer: footer)
    }
    
}
