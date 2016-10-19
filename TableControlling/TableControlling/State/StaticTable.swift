enum StaticTable<
    Header: Equatable,
    SectionHeader: Equatable,
    Cell: Equatable,
    SectionFooter: Equatable,
    Footer: Equatable
>: Equatable {
    case ready
    case display(
        Table<Header, SectionHeader, Cell, SectionFooter, Footer>
    )
}

func ==<
    Header: Equatable,
    SectionHeader: Equatable,
    Cell: Equatable,
    SectionFooter: Equatable,
    Footer: Equatable
>(
    lhs: StaticTable<Header, SectionHeader, Cell, SectionFooter, Footer>,
    rhs: StaticTable<Header, SectionHeader, Cell, SectionFooter, Footer>
) -> Bool {
    switch (lhs, rhs) {
    case (.ready, .ready): return true
    case (.display(let lhsTable), .display(let rhsTable)): return lhsTable == rhsTable
    default: return false
    }
}
