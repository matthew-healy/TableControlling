/**
 Describes some common features shared by types which
 manage `UITableView`s. 
 
 In particular this is used as the base protocol for 
 `TableControlling` and `TableUpdating`.
*/
protocol TableHandling {
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
    var view: View { get}
}
