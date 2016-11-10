/**
 A type which acts as a controller for an instance of `UITableView`, 
 or some subclass.
 
 Types which conform to `TableControlling` are only required to have
 a `model` of the table, and a reference to the `view` itself. Other
 behaviours which involve these properties are codified in protocols
 which 'inherit' from `TableControlling`. Generally your types should
 conform to those protocols instead of using `TableControlling` directly.
*/
protocol TableControlling {
    associatedtype Model: TableModelling
    associatedtype View
    
    associatedtype Header: Equatable
    associatedtype SectionHeader: Equatable
    associatedtype Cell: Equatable
    associatedtype SectionFooter: Equatable
    associatedtype Footer: Equatable
    
    /**
     The view model underlying the table.
    */
    var model: Model { get set }
    
    /**
     The table view which is being controlled.
    */
    var view: View { get }
}

extension TableControlling {
    var numberOfSectionsInTable: Int {
        return model.numberOfSections
    }
}
