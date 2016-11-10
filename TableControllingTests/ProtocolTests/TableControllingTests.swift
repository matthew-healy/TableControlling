import XCTest
@testable import TableControlling

class TableControllingTests: XCTestCase {
    
    var model: StubTableModel!
    var sut: PartialMockTableController!
    
    override func setUp() {
        model = StubTableModel()
        sut = PartialMockTableController(model: model, view: "")
    }
    
    func test_numberOfSectionsInTable_modelHas5Sections_returns5() {
        model.stubNumberOfSections = 5
        XCTAssertEqual(5, sut.numberOfSectionsInTable)
    }
    
    func test_numberOfSectionsInTable_modelHas7Sections_returns7() {
        model.stubNumberOfSections = 7
        XCTAssertEqual(7, sut.numberOfSectionsInTable)
    }
    
}

class PartialMockTableController: TableControlling {
    typealias Header = String
    typealias SectionHeader = String
    typealias Cell = String
    typealias SectionFooter = String
    typealias Footer = String
    
    var model: StubTableModel
    let view: String
    
    init(model: StubTableModel, view: String) {
        self.model = model
        self.view = view
    }
}

class StubTableModel: TableModelling {
    var stubNumberOfSections = 0
    var numberOfSections: Int {
        return stubNumberOfSections
    }
    
    var stubNumberOfItemsInSection = 0
    var spyNumberOfItemsInSection: Int? = nil
    func numberOfItems(inSection section: Int) -> Int {
        return stubNumberOfItemsInSection
    }
    
    var stubItemAtIndexPath: String? = nil
    func item(at indexPath: IndexPath) -> String? {
        return stubItemAtIndexPath
    }
}
