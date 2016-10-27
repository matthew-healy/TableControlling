/**
 A state model which represents the possible states for a dynamic `Table`.
 It can either be `ready` to display a `Table`, `loading` one, `displaying` one, 
 or showing an `Error`.
*/
enum DynamicTable<
    Header: Equatable,
    SectionHeader: Equatable,
    Cell: Equatable,
    SectionFooter: Equatable,
    Footer: Equatable
>: Equatable {
    /// The table is `ready` to display data. This is the default state of a newly-created table.
    case ready
    /// The table is `loading` data to display. This is the appropriate time to show an activity indicator.
    case loading
    /// The table is currently `displaying` the associated `Table` view model.
    case displaying(
        Table<Header, SectionHeader, Cell, SectionFooter, Footer>
    )
    /// The table has `failed` to load. This is the appropriate time to retry, or show an error.
    case failed(Error)
}

func ==<
    Header: Equatable,
    SectionHeader: Equatable,
    Cell: Equatable,
    SectionFooter: Equatable,
    Footer: Equatable
>(
    lhs: DynamicTable<Header, SectionHeader, Cell, SectionFooter, Footer>,
    rhs: DynamicTable<Header, SectionHeader, Cell, SectionFooter, Footer>
) -> Bool {
    switch (lhs, rhs) {
    case (.ready, .ready): return true
    case (.loading, .loading): return true
    case (.displaying(let lhsTable), .displaying(let rhsTable)): return lhsTable == rhsTable
    case (.failed(let lhsError as NSError), .failed(let rhsError as NSError)):
        return lhsError == rhsError
    default: return false
    }
}
