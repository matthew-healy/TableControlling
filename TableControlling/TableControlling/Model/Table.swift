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
