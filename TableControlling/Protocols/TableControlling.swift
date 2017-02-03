/**
 A type which acts as a controller for an instance of `UITableView`, 
 or some subclass.
*/
protocol TableControlling: TableHandling {
    associatedtype CellView
    
    /**
     Returns the `String` identifier for the cell at the
     given index path.
    */
    func identifier(for indexPath: IndexPath) -> String
    /**
     Inserts the data from the `Cell` model into the `CellView`.
     
     Should generally be implemented as 
     `configure(_ cell: UITableViewCell, with model: CellViewModel)` 
     where `CellViewModel` is some user-defined type.
    */
    func configure(_ cell: CellView, with model: Cell)
}

extension TableControlling {
    /**
     The number of sections the table currently contains.

     This is designed to be returned from `numberOfSections(in:)`.
    */
    var numberOfSectionsInTable: Int {
        return model.numberOfSections
    }
    
    /**
     The number of items in the given section of the table.

     This is designed to be called from `tableView(_:numberOfRowsInSection:)`.
    */
    func numberOfItems(inTableSection section: Int) -> Int {
        return model.numberOfItems(inSection: section)
    }
}

extension TableControlling where
    CellView == UITableViewCell,
    Cell == Model.Cell,
    View: CellDequeueing
{
    /**
     The cell to be displayed at the given index path.

     This is designed to be called from `tableView(_:cellForRowAt:)`
    */
    func tableCell(forRowAt indexPath: IndexPath) -> UITableViewCell? {
        guard let cellModel = model.item(at: indexPath) else {
            return nil
        }
        let id = identifier(for: indexPath)
        let cell = view.dequeueReusableCell(
            withIdentifier: id,
            for: indexPath
        )
        configure(cell, with: cellModel)
        return cell
    }
}
