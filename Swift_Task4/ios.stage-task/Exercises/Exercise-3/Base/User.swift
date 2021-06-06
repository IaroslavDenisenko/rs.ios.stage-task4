import Foundation

struct User: Equatable {
    let id: UUID
}

extension User: Hashable {}
