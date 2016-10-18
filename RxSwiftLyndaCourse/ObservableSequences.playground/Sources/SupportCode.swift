import Foundation

public func exampleOf(description: String, action: (Void) -> Void) {
    print("\n--- Example of ", description, "---")

    action()
}
