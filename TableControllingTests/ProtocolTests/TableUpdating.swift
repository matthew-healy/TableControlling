/**
 A type which is able to update the display of a `UITableView` based on
 the state of its model.
*/
protocol TableUpdating: TableHandling {
    func update()
}

extension TableUpdating where
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

extension TableUpdating where
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
