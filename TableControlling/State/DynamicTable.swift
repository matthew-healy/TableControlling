enum DynamicTable<
    Header: Equatable,
    SectionHeader: Equatable,
    Cell: Equatable,
    SectionFooter: Equatable,
    Footer: Equatable
>: Equatable {
    case ready
    case loading
    case displaying(
        Table<Header, SectionHeader, Cell, SectionFooter, Footer>
    )
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
