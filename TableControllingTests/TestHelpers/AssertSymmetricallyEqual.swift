import XCTest

/**
 Asserts that the equality operation on an `Equatable` type `T` is symmetric.
 i.e., it asserts that `t_1 == t_2` if and only if `t_2 == t_1`.
 
 - parameter expression1: An `@autoclosure` which evaluates to something of type `T`.
 - parameter expression2: An `@autoclosure` which evaluates to something of type `T`.
 - parameter message: The message to print in case of failure. Defaults to "AssertSymmetricallyEqual failed."
*/
func AssertSymmetricallyEqual<T: Equatable>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> T,
    _ message: @autoclosure () -> String = "AssertSymmetricallyEqual failed.",
    file: StaticString = #file,
    line: UInt = #line
) {
    XCTAssertEqual(expression1, expression2, message(), file: file, line: line)
    XCTAssertEqual(expression2, expression1, message(), file: file, line: line)
}
