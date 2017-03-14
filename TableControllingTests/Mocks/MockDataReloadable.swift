@testable import TableControlling

class MockDataReloadable: DataReloadable {
    var didReloadData = false
    func reloadData() {
        didReloadData = true
    }
}
