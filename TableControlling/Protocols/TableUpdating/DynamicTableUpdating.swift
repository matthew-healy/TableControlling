/**
 A type which is able to update the display of a `UITableView` based on the state of its model.
*/
protocol DynamicTableUpdating: TableHandling {}

extension DynamicTableUpdating where
    Model == DynamicTable<Header, SectionHeader, Cell, SectionFooter, Footer>,
    View: DataReloadable
{
    func update() {
        switch model {
        case .displaying(_): view.reloadData()
        default: return
        }
    }
}
