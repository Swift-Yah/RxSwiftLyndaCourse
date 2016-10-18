import Foundation

public func exampleOf(_ description: String, _ action: (Void) -> Void) {
    print("\n--- Example of", description, "---")

    action()
}
