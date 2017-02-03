protocol TableUpdating {
    associatedtype Model
    associatedtype View

    associatedtype Header: Equatable
    associatedtype SectionHeader: Equatable
    associatedtype Cell: Equatable
    associatedtype SectionFooter: Equatable
    associatedtype Footer: Equatable

    var model: Model { get }
    var view: View { get }

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
