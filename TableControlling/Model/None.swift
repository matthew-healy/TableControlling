/**
 `None` represents the absence of a type.
 
 It can be thought of as being similar to Swift's own `Void`
 type, with the vital difference being that `None` is `Equatable`.
 This allows us to use `None` in place of a generic type which must
 be `Equatable`.
 
 In theory this won't need to exist in a future verison of Swift, once
 conditional protocol conformance is added.
*/
enum None: Equatable {}

func ==(lhs: None, rhs: None) -> Bool {
    return true
}
