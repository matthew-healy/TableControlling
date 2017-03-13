/**
 A type which is able to update the display of a `UITableView` based on
 the state of its model.
*/
protocol StaticTableUpdating: TableHandling {}

extension StaticTableUpdating where
    Model == StaticTable<Header, SectionHeader, Cell, SectionFooter, Footer>,
    View: DataReloadable
{
    func update() {
        guard case .displaying = model else {
            return
        }
        view.reloadData()
    }
}

