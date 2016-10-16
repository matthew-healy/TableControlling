/**
 A view model which represents the contents of a `UITableView`.
 
 It has an optional `Header` and `Footer`, and a non-optional 
 array of `Section`s (where a `Section` is a `typealias` for
 `TableSection<SectionHeader, Cell, SectionFooter>`. The `Header`, 
 `Footer` and `Section` types are `Equatable` in order for us to equate 
 entire `Table`s.
*/
struct Table<
    Header: Equatable,
    SectionHeader: Equatable, Cell: Equatable, SectionFooter:Equatable,
    Footer: Equatable
>: Equatable {
    typealias Section = TableSection<SectionHeader, Cell, SectionFooter>
    
    let header: Header?
    let sections: [Section]
    let footer: Footer?
    
    /**
     Creates a `Table` with given parameters.
     
     - parameter header: The view model for the table's header. The default argument is `nil`.
     - parameter sections: An array of view models for the table's sections. The default argument is an empty array.
     - parameter footer: The view model for the table's footer. The default argument is `nil`.
    */
    init(header: Header? = nil, sections: [Section] = [], footer: Footer? = nil) {
        self.header = header
        self.sections = sections
        self.footer = footer
    }
    
    /**
     The number of sections in the `Table`.
    */
    var numberOfSections: Int {
        return sections.count
    }
    
    /**
     The number of `Cell`s in the given section of the `Table`.
     
     - parameter section: The `Int` value of the requested section.
     
     - returns: The `numberOfItems` in the secition, if it exists, or `0` otherwise.
    */
    func numberOfItems(inSection section: Int) -> Int {
        guard section < numberOfSections else { return 0 }
        return sections[section].numberOfItems
    }
    
    /**
     Fetches the item at the given index path of the `Table`.
     
     - parameter indexPath: The `IndexPath` of the requested cell.
     
     - returns: The cell's view model, if it exists, or `nil` otherwise.
    */
    func item(at indexPath: IndexPath) -> Cell? {
        let (section, row) = (indexPath.section, indexPath.row)
        guard section < numberOfSections else { return nil }
        return sections[section].item(atRow: row)
    }
}

func ==<
    Header: Equatable,
    SectionHeader: Equatable, Cell: Equatable, SectionFooter: Equatable,
    Footer: Equatable
    >(
    lhs: Table<Header, SectionHeader, Cell, SectionFooter, Footer>,
    rhs: Table<Header, SectionHeader, Cell, SectionFooter, Footer>
) -> Bool {
    return lhs.header == rhs.header
        && lhs.sections == rhs.sections
        && lhs.footer == rhs.footer
}
