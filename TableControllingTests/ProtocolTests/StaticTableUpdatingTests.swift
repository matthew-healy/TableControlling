import XCTest
@testable import TableControlling

class TableUpdatingTests: XCTestCase {
    
    private let mockView = MockDataReloadable()
    
    // MARK: update() tests

    func test_update_staticTable_displaying_callsReloadData() {
        let sut = PartialMockStaticTableUpdating(
            model: .displaying(.create()),
            view: mockView
        )
        sut.update()
        XCTAssertTrue(mockView.didReloadData)
    }

    func test_update_staticTable_ready_doesNotCallReloadData() {
        let sut = PartialMockStaticTableUpdating(
            model: .ready,
            view: mockView
        )
        sut.update()
        XCTAssertFalse(mockView.didReloadData)
    }
    
}

private typealias BlankStaticTable = StaticTable<None, None, None, None, None>

private class PartialMockStaticTableUpdating: StaticTableUpdating {
    typealias Model = BlankStaticTable
    typealias View = MockDataReloadable
    typealias Header = None
    typealias SectionHeader = None
    typealias Cell = None
    typealias SectionFooter = None
    typealias Footer = None
    
    var model: BlankStaticTable
    let view: MockDataReloadable

    init(model: BlankStaticTable, view: MockDataReloadable) {
        self.model = model
        self.view = view
    }
}
