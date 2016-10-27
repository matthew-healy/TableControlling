import XCTest
@testable import TableControlling

class CollectionExtensionTests: XCTestCase {
    
    func test_safeSubscript_noSuchIndex_returnsNil() {
        let sut: [String] = []
        XCTAssertNil(sut[safe: 0])
    }
    
    func test_safeSubscript_0_hasHELLOAtIndex0_returnsHELLO() {
        let sut = ["HELLO"]
        XCTAssertEqual("HELLO", sut[safe: 0])
    }
    
    func test_safeSubscript_3_has3Point14AtIndex3_returns3Point14() {
        let sut = [1.12, 9.74, 2.22, 3.14, 5.55]
        XCTAssertEqual(3.14, sut[safe: 3])
    }
    
}
