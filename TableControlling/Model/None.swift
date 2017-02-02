/**
 `None` represents the absence of a type.
 
 It can be thought of as being similar to Swift's own `Void`
 type, with the vital difference that `None` is `Equatable`.
 This allows us to use `None` to represent the absence of type
 in cases where types are nevertheless required to be `Equatable`.
 
 e.g. `TableSection`'s three generic parameters are required to be
 `Equatable` in order for us to equate them in tests.
 
 In theory this won't need to exist in a future verison of Swift, once
 conditional protocol conformance is added.
*/
enum None: Equatable {

    static func ==(lhs: None, rhs: None) -> Bool {
        return true
    }

}
