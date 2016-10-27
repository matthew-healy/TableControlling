import XCTest
@testable import TableControlling

class TableSectionTests: XCTestCase {
    
    // MARK: init tests
    
    func test_init_noArguments_headerNil() {
        let sut = TableSection<None, None, None>()
        XCTAssertNil(sut.header)
    }
    
    func test_init_noArguments_cellsIsEmpty() {
        let sut = TableSection<None, None, None>()
        XCTAssertTrue(sut.cells.isEmpty)
    }
    
    func test_init_noArguments_footerNil() {
        let sut = TableSection<None, None, None>()
        XCTAssertNil(sut.footer)
    }
    
    func test_init_headerIsABC_headerABC() {
        let expectedHeader = "ABC"
        let sut = TableSection<String, None, None>(header: expectedHeader)
        XCTAssertEqual(expectedHeader, sut.header)
    }
    
    func test_init_cellsAreABAndC_cellsAreABAndC() {
        let expectedCells = ["A", "B", "C"]
        let sut = TableSection<None, String, None>(cells: expectedCells)
        XCTAssertEqual(expectedCells, sut.cells)
    }
    
    func test_init_footerIsDEF_footerIsDEF() {
        let expectedFooter = "DEF"
        let sut = TableSection<None, None, String>(footer: expectedFooter)
        XCTAssertEqual(expectedFooter, sut.footer)
    }
    
    // MARK: equatable tests
    
    var lhs: TableSection<String, Int, Bool>!
    var rhs: TableSection<String, Int, Bool>!
    
    func test_equals_headerCellsAndFooterMatch_true() {
        (lhs, rhs) = (.create(), .create())
        AssertSymmetricallyEqual(lhs, rhs)
    }
    
    func test_equals_headersDoNotMatch_false() {
        (lhs, rhs) = (.create(header: "A"), .create(header: "B"))
        AssertSymmetricallyNotEqual(lhs, rhs)
    }
    
    func test_equals_cellsDoNotMatch_false() {
        (lhs, rhs) = (.create(cells: [1, 2, 3]), .create())
        AssertSymmetricallyNotEqual(lhs, rhs)
    }
    
    func test_equals_footersDoNotMatch_false() {
        (lhs, rhs) = (.create(footer: false), .create(footer: true))
        AssertSymmetricallyNotEqual(lhs, rhs)
    }
    
    // MARK: numberOfItems tests
    
    func test_numberOfItems_cellsIsEmpty_returns0() {
        let sut = TableSection<None, String, None>()
        XCTAssertEqual(0, sut.numberOfItems)
    }
    
    func test_numberOfItems_cellsIsABCD_returns4() {
        let sut = TableSection<None, String, None>(cells: ["A", "B", "C", "D"])
        XCTAssertEqual(4, sut.numberOfItems)
    }
    
    // MARK: item(atRow:_) tests
    
    func test_itemAtRow_noCellAtGivenRow_reutrnsNil() {
        let sut = TableSection<None, None, None>()
        XCTAssertNil(sut.item(atRow: 0))
    }
    
    func test_itemAtRow_0_cellAIsAtRow0_returnsA() {
        let sut = TableSection<None, String, None>(cells: ["A"])
        XCTAssertEqual("A", sut.item(atRow: 0))
    }
    
    func test_itemAtRow_4_cell310IsAtRow4_returns310() {
        let sut = TableSection<None, Int, None>(cells: [0, 0, 0, 0, 310])
        XCTAssertEqual(310, sut.item(atRow: 4))
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
