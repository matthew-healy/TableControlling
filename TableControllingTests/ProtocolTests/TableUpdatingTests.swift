import XCTest
@testable import TableControlling

class TableUpdatingTests: XCTestCase {
    
    private let mockView = MockDataReloadable()
    
    // MARK: model: StaticTable update() tests

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

private typealias BlankStaticTable = StaticTable<None, None, None, None, None>
private typealias BlankDynamicTable = DynamicTable<None, None, None, None, None>

private class PartialMockStaticTableUpdating: TableUpdating {
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

private class PartialMockDynamicTableUpdating: TableUpdating {
    typealias Model = BlankDynamicTable
    typealias View = MockDataReloadable
    typealias Header = None
    typealias SectionHeader = None
    typealias Cell = None
    typealias SectionFooter = None
    typealias Footer = None
    
    let model: BlankDynamicTable
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
