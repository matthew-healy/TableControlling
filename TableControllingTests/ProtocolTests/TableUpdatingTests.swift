import XCTest

class TableControlingExtensionTests: XCTestCase {

}

private class PartialMockStaticTableControlilng: TableControlling {
    
}

private class MockDataReloadable: DataReloadable {
    var didReloadData = false
    func reloadData() {
        didReloadData = true
    }
}
