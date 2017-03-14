import UIKit

/**
 A type which can have its data reloaded.

 Only one type is intended to conform to `DataReloadable` -
 `UITableView`. This protocol exists mainly to prevent `UIKit`
 from becoming too entangled with application logic.
 */
protocol DataReloadable {
    func reloadData()
}

extension UITableView: DataReloadable {}
