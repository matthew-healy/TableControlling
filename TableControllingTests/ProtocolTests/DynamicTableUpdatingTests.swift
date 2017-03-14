import XCTest
@testable import TableControlling

class DynamicTableUpdatingTests: XCTestCase {
    
    private let mockView = MockDataReloadable()
    
    // MARK: model: DynamicTable update() tests
    
    func test_update_dynamicTable_displaying_callsReloadData() {
        let sut = PartialMockDynamicTableUpdating(
            model: .displaying(.create()),
            view: mockView
        )
        sut.update()
        XCTAssertTrue(mockView.didReloadData)
    }
    
    func test_update_dynamicTable_ready_doesNotCallReloadData() {
        let sut = PartialMockDynamicTableUpdating(
            model: .ready,
            view: mockView
        )
        sut.update()
        XCTAssertFalse(mockView.didReloadData)
    }
    
}

private typealias BlankDynamicTable = DynamicTable<None, None, None, None, None>

private class PartialMockDynamicTableUpdating: DynamicTableUpdating {
    typealias Model = BlankDynamicTable
    typealias View = MockDataReloadable
    typealias Header = None
    typealias SectionHeader = None
    typealias Cell = None
    typealias SectionFooter = None
    typealias Footer = None
    
    var model: BlankDynamicTable
    let view: MockDataReloadable
    
    init(model: BlankDynamicTable, view: MockDataReloadable) {
        self.model = model
        self.view = view
    }
    
    var didCallTableViewDidBeginLoading = false
    func tableViewDidBeginLoading() {
        didCallTableViewDidBeginLoading = true
    }
}
