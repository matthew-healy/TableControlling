extension Collection where Index == IndexDistance {
    /**
     Allows access to the elements of a collection without fear of 
     out-of-bounds errors.
     
     - parameter index: The index of the element requested.
     
     - returns: The element at the requested index, or `nil` if the index does not exist.
    */
    subscript(safe index: Index) -> Generator.Element? {
        guard index < count else { return nil }
        return self[index]
    }
}
