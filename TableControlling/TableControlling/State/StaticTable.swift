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
    
    var numberOfSections: Int {
        guard case .display(let table) = self else { return 0 }
        return table.numberOfSections
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        guard case .display(let table) = self else { return 0 }
        return table.numberOfItems(inSection: section)
    }
    
    func item(at indexPath: IndexPath) -> Cell? {
        guard case .display(let table) = self else { return nil }
        return table.item(at: indexPath)
    }
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
