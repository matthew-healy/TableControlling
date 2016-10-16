struct Table<
    Header: Equatable,
    SectionHeader: Equatable, Cell: Equatable, SectionFooter:Equatable,
    Footer: Equatable
>: Equatable {
    typealias Section = TableSection<SectionHeader, Cell, SectionFooter>
    
    let header: Header?
    let sections: [Section]
    let footer: Footer?
    
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
