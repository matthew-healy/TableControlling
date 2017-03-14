import XCTest
@testable import TableControlling

class TableControllingTests: XCTestCase {
    
    private var model: StubTableModel!
    private var view: MockCellDequeueing!
    private var sut: PartialMockTableController!
    
    override func setUp() {
        model = StubTableModel()
        view = MockCellDequeueing()
        sut = PartialMockTableController(model: model, view: view)
    }
    
    // MARK: numberOfSectionsInTable tests
    
    func test_numberOfSectionsInTable_modelHas5Sections_returns5() {
        model.stubNumberOfSections = 5
        XCTAssertEqual(5, sut.numberOfSectionsInTable)
    }
    
    func test_numberOfSectionsInTable_modelHas7Sections_returns7() {
        model.stubNumberOfSections = 7
        XCTAssertEqual(7, sut.numberOfSectionsInTable)
    }
    
    // MARK: numberOfItems(inTableSection:) tests
    
    func test_numberOfItemsInTableSection_1_asksModelForItemsInSection7() {
        _ = sut.numberOfItems(inTableSection: 1)
        guard let requestedSection = model.spyNumberOfItemsInSection else {
            return XCTFail("Did not ask model for number of items")
        }
        XCTAssertEqual(1, requestedSection)
    }
    
    func test_numberOfItemsInTableSection14_asksModelForItemsInSection14() {
        _ = sut.numberOfItems(inTableSection: 14)
        guard let requestedSection = model.spyNumberOfItemsInSection else {
            return XCTFail("Did not ask model for number of items")
        }
        XCTAssertEqual(14, requestedSection)
    }
    
    func test_numberOfItemsInTableSection_modelReturns3_returns3() {
        model.stubNumberOfItemsInSection = 3
        XCTAssertEqual(3, sut.numberOfItems(inTableSection: -1))
    }
    
    func test_numberOfItemsInTableSection_modelReturns168_returns168() {
        model.stubNumberOfItemsInSection = 168
        XCTAssertEqual(168, sut.numberOfItems(inTableSection: 808))
    }
    
    // MARK: tableCell(forRowAt:) tests
    
    func test_tableCellForRowAt_row0Section0_modelItemIsNil_returnsNil() {
        model.stubItemAtIndexPath = nil
        XCTAssertNil(sut.tableCell(forRowAt: IndexPath(row: 0, section: 0)))
    }
    
    func test_tableCellForRowAt_row0Section0_modelItemHAM_configuresCellWithHAM() {
        model.stubItemAtIndexPath = "HAM"
        _ = sut.tableCell(forRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual("HAM", sut.spyCellModel)
    }
    
    func test_tableCellForRowAt_modelNonNil_dequeuesCell() {
        _ = sut.tableCell(forRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(view.didDequeueReusableCell)
    }
    
    func test_tableCellForRowAt_row9Section9_getsIdentiiferForRow9Section9() {
        let expected = IndexPath(row: 9, section: 9)
        _ = sut.tableCell(forRowAt: expected)
        XCTAssertEqual(expected, sut.spyIdentifierIndexPath)
    }
    
    func test_tableCellForRowAt_row1Section12_getsIdentifierForRow1Section12() {
        let expected = IndexPath(row: 1, section: 12)
        _ = sut.tableCell(forRowAt: expected)
        XCTAssertEqual(expected, sut.spyIdentifierIndexPath)
    }
    
    func test_tableCellForRowAt_row1Section12_dequeuesCellAtRow1Section12() {
        let expected = IndexPath(row: 1, section: 12)
        _ = sut.tableCell(forRowAt: expected)
        XCTAssertEqual(expected, view.spyIndexPath)
    }
    
    func test_tableCellForRowAt_row3Section2_dequeuesCellAtRow3Section2() {
        let expected = IndexPath(row: 3, section: 2)
        _ = sut.tableCell(forRowAt: expected)
        XCTAssertEqual(expected, view.spyIndexPath)
    }
    
    func test_tableCellForRowAt_identiiferYAS_dequeuesCellForIDYAS() {
        sut.stubIdentifier = "YAS"
        _ = sut.tableCell(forRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual("YAS", view.spyIdentifier)
    }
    
    func test_tableCellForRowAt_identifierBOOP_dequeuesCellForIDBOOP() {
        sut.stubIdentifier = "BOOP"
        _ = sut.tableCell(forRowAt: IndexPath(row: 1, section: 14))
        XCTAssertEqual("BOOP", view.spyIdentifier)
    }
    
    func test_tableCellForRowAt_always_configuresDequeuedCell() {
        let expected = UITableViewCell()
        view.stubReusableCell = expected
        _ = sut.tableCell(forRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(expected === sut.spyConfigureCell)
    }
    
    func test_tableCellForRowAt_always_returnsDequeuedCell() {
        let expected = UITableViewCell()
        view.stubReusableCell = expected
        let actual = sut.tableCell(forRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(expected === actual)
    }
}

private class PartialMockTableController: TableControlling {
    typealias Header = String
    typealias SectionHeader = String
    typealias Cell = String
    typealias SectionFooter = String
    typealias Footer = String
    
    var model: StubTableModel
    let view: MockCellDequeueing
    
    init(model: StubTableModel, view: MockCellDequeueing) {
        self.model = model
        self.view = view
    }
    
    var didGetIdentifier = false
    var spyIdentifierIndexPath: IndexPath?
    var stubIdentifier = ""
    func identifier(for indexPath: IndexPath) -> String {
        didGetIdentifier = true
        spyIdentifierIndexPath = indexPath
        return stubIdentifier
    }
    
    var didConfigureCell = false
    var spyConfigureCell: UITableViewCell?
    var spyCellModel: String?
    func configure(_ cell: UITableViewCell, with model: String) {
        didConfigureCell = true
        spyConfigureCell = cell
        spyCellModel = model
    }
}

private class StubTableModel: TableModelling {
    var stubNumberOfSections = 0
    var numberOfSections: Int {
        return stubNumberOfSections
    }
    
    var stubNumberOfItemsInSection = 0
    var spyNumberOfItemsInSection: Int? = nil
    func numberOfItems(inSection section: Int) -> Int {
        spyNumberOfItemsInSection = section
        return stubNumberOfItemsInSection
    }
    
    var stubItemAtIndexPath: String? = ""
    func item(at indexPath: IndexPath) -> String? {
        return stubItemAtIndexPath
    }
}
