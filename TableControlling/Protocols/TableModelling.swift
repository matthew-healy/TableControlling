/**
 A type that models a `UITableView`.
 
 Types which conform to `TableModelling` can respond to requests for
 the `Table`'s number of sections, number of items in a particular 
 section, or the item at a given `IndexPath`. `Table`, `StaticTable`
 and `DynamicTable` all conform to `TableModelling`.
*/
protocol TableModelling {
    associatedtype Cell
    
    /**
     The number of sections to show in the table.
    */
    var numberOfSections: Int { get }
    
    /**
     The number of `Cell`s in the given section.
     
     - parameter section: The `Int` value of the requested section.
     
     - returns: The number of cells in that section.
    */
    func numberOfItems(inSection section: Int) -> Int
    
    /** 
     Fetches the `Cell` at the given `IndexPath` of the table.
     
     - parameter indexPath: The `IndexPath` of the requested `Cell`.
     
     - returns: The `Cell`, if it exists, or `nil` otherwise.
    */
    func item(at indexPath: IndexPath) -> Cell?
}
