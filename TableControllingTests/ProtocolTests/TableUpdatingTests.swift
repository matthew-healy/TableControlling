import XCTest
@testable import TableControlling

class TableUpdatingTests: XCTestCase {

    func test_update_staticTable_displaying_callsReloadData() {
        let mockView = MockDataReloadable()
        let displayingTable = BlankStaticTable.displaying(.create())
        let sut = PartialMockTableUpdating(model: displayingTable, view: mockView)
        sut.update()
        XCTAssertTrue(mockView.didReloadData)
    }

    func test_update_staticTable_ready_doesNotCallReloadData() {
        let mockView = MockDataReloadable()
        let readyTable = BlankStaticTable.ready
        let sut = PartialMockTableUpdating(model: readyTable, view: mockView)
        sut.update()
        XCTAssertFalse(mockView.didReloadData)
    }
}

private typealias BlankStaticTable = StaticTable<None, None, None, None, None>

private class PartialMockTableUpdating: TableUpdating {
    typealias Model = BlankStaticTable
    typealias View = MockDataReloadable
    typealias Header = None
    typealias SectionHeader = None
    typealias Cell = None
    typealias SectionFooter = None
    typealias Footer = None
    
    let model: BlankStaticTable
    let view: MockDataReloadable

    init(model: BlankStaticTable, view: MockDataReloadable) {
        self.model = model
        self.view = view
    }
}

private class MockDataReloadable: DataReloadable {
    var didReloadData = false
    func reloadData() {
        didReloadData = true
    }
}
