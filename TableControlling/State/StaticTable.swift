import Foundation

/**
 A state model which represents the possible states for a static `Table`. 
 It can either be `ready` to display a `Table`, or currently `displaying` one.
 
 It has proxies for the `Table`s data methods - e.g. `numberOfSections`
 which it passes on to the underlying `Table`, if it exists, or returns
 sensible default values for otherwise.
*/
enum StaticTable<
    Header: Equatable,
    SectionHeader: Equatable,
    Cell: Equatable,
    SectionFooter: Equatable,
    Footer: Equatable
>: Equatable, TableModelling {
    /// The table is `ready` to display data. This is the default state of a newly-created table.
    case ready
    /// The table is currently `displaying` the associated `Table` view model.
    case displaying(
        Table<Header, SectionHeader, Cell, SectionFooter, Footer>
    )
    
    /**
     The number of sections in the underlying `Table`, or `0` if one is not displayed.
    */
    var numberOfSections: Int {
        guard case .displaying(let table) = self else { return 0 }
        return table.numberOfSections
    }
    
    /**
     The number of `Cell`s in the given section of the underlying `Table`.
     
     - parameter section: The `Int` index of the requested section.
     
     - returns: The `numberOfItems` for that section of the `Table`, 
                or `0` if not `display`ing one.
    */
    func numberOfItems(inSection section: Int) -> Int {
        guard case .displaying(let table) = self else { return 0 }
        return table.numberOfItems(inSection: section)
    }
    
    /**
     Fetches the item at the given index path of the underlying `Table`.
     
     - parameter indexPath: The `IndexPath` of the requested `Cell`.
     
     - returns: The result of calling `item(at:)` on the underlying `Table`,
                or `nil` if one is not currently displayed.
     */
    func item(at indexPath: IndexPath) -> Cell? {
        guard case .displaying(let table) = self else { return nil }
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
    case (.displaying(let lhsTable), .displaying(let rhsTable)): return lhsTable == rhsTable
    default: return false
    }
}
