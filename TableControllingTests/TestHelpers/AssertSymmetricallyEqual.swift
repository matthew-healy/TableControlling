import XCTest

/**
 Asserts that the equality operation on an `Equatable` type `T` is symmetric.
 i.e., it asserts that `t_1 == t_2` if and only if `t_2 == t_1`.
 
 This is a dumb function to need, because in reality equality should be an
 equivalence relation, and therefore guarantee symmetry, but `XCTAssertEqual`
 doesn't check in both directions. This is only really necessary when actually 
 defining `==` for a type.
 
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

/**
 Asserts that the non-equality operation on an `Equatable` type `T` is symmetric.
 i.e., it asserts that `t_1 != t_2` if and only if `t_2 != t_1`.
 
 This is a dumb function to need, because in reality equality should be an
 equivalence relation, and therefore guarantee symmetry, but `XCTAssertNotEqual`
 doesn't check in both directions. This is only really necessary when actually
 defining `==` (and therefore `!=`) for a type.
 
 - parameter expression1: An `@autoclosure` which evaluates to something of type `T`.
 - parameter expression2: An `@autoclosure` which evaluates to something of type `T`.
 - parameter message: The message to print in case of failure. Defaults to "AssertSymmetricallyNotEqual failed."
 */
func AssertSymmetricallyNotEqual<T: Equatable>(
    _ expression1: @autoclosure () throws -> T,
    _ expression2: @autoclosure () throws -> T,
    _ message: @autoclosure () -> String = "AssertSymmetricallyNotEqual failed.",
    file: StaticString = #file,
    line: UInt = #line
) {
    XCTAssertNotEqual(expression1, expression2, message(), file: file, line: line)
    XCTAssertNotEqual(expression2, expression1, message(), file: file, line: line)
}
