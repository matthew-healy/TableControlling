import Foundation

struct TableSection<Header: Equatable, Cell: Equatable, Footer: Equatable>: Equatable {
    let header: Header?
    let cells: [Cell]
    let footer: Footer?
    
    init(header: Header? = nil, cells: [Cell] = [], footer: Footer? = nil) {
        self.header = header
        self.cells = cells
        self.footer = footer
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
