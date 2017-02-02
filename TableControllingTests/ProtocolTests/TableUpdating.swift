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
    typealias ContextualTable = StaticTable<Header, SectionHeader, Cell, SectionFooter, Footer>
    func update() {
        guard case .displaying = model else {
            return
        }
        view.reloadData()
    }
}
