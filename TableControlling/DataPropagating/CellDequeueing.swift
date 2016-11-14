import UIKit

/**
 A type from which it is possible to dequeue a `UITableViewCell`.
 
 Only one type is intended to conform to `CellDequeueing` - 
 `UITableView`. This protocol exists mainly to prevent `UIKit`
 from becoming too entangled with application logic.
*/
protocol CellDequeueing {
    func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell
}

extension UITableView: CellDequeueing {}
