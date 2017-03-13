@testable import TableControlling

class MockCellDequeueing: CellDequeueing {
    var spyIdentifier: String?
    var spyIndexPath: IndexPath?
    var didDequeueReusableCell = false
    var stubReusableCell: UITableViewCell?
    func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        didDequeueReusableCell = true
        spyIdentifier = identifier
        spyIndexPath = indexPath
        return stubReusableCell ?? UITableViewCell()
    }
}
