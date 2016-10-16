/**
 A view model which represents a section in a `UITableView`.
 
 It has an optional `Header` and `Footer`, and a non-optional array
 of `Cell`s. The `Header`, `Footer` and `Cell` types are `Equatable` in order
 for us to equate entire `TableSection`s.
*/
struct TableSection<Header: Equatable, Cell: Equatable, Footer: Equatable>: Equatable {
    let header: Header?
    let cells: [Cell]
    let footer: Footer?
    
    /**
     Creates a `TableSection` with the given parameters.
     
     - parameter header: The view model for the section's header. The default argument is `nil`.
     - parameter cells: An array of view models for the sections' cells. The default argument is an empty array.
     - parameter footer: The view model for the section's footer. The default argument is `nil`.
    */
    init(header: Header? = nil, cells: [Cell] = [], footer: Footer? = nil) {
        self.header = header
        self.cells = cells
        self.footer = footer
    }
    
    var numberOfItems: Int {
        return cells.count
    }
}

func ==<Header: Equatable, Cell: Equatable, Footer: Equatable>(
    lhs: TableSection<Header, Cell, Footer>,
    rhs: TableSection<Header, Cell, Footer>
) -> Bool {
    return lhs.header == rhs.header
        && lhs.cells == rhs.cells
        && lhs.footer == rhs.footer
}
