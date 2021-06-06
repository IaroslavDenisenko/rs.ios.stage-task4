import Foundation

final class CallStation {
    var registeredUsers = Set<User>()
    var allCalls = Set<Call>()
}

extension CallStation: Station {
    func users() -> [User] {
        registeredUsers.map{$0}
    }
    
    func add(user: User) {
        registeredUsers.insert(user)
    }
    
    func remove(user: User) {
        registeredUsers.remove(user)
    }
    
    func execute(action: CallAction) -> CallID? {
        switch action {
        case let .start(from: user1, to: user2):
            guard registeredUsers.contains(user1) else { break }
            var call = Call(
                id: UUID(),
                incomingUser: user2,
                outgoingUser: user1,
                status: .calling)
            
            if !registeredUsers.contains(user2) {
                call.status = .ended(reason: .error)
            } else {
                if let _ = allCalls.filter({$0.incomingUser == user2 && $0.status == .talk}).first {
                    call.status = .ended(reason: .userBusy)
                }
            }
    
            allCalls.insert(call)
            return call.id
            
        case .answer(from: let user):
            if var call = allCalls.filter({$0.incomingUser == user}).first {
                allCalls.remove(call)
                if registeredUsers.contains(user) {
                    call.status = .talk
                    allCalls.insert(call)
                    return call.id
                } else {
                    call.status = .ended(reason: .error)
                    allCalls.insert(call)
                }
            }
                
        case .end(from: let user):
            if var call = allCalls.filter({$0.incomingUser == user || $0.outgoingUser == user}).first {
                allCalls.remove(call)
                if call.status == .talk {
                    call.status = .ended(reason: .end)
                } else if call.status == .calling {
                    call.status = .ended(reason: .cancel)
                }
                allCalls.insert(call)
                return call.id
            }
        }
        return nil
    }
    
    func calls() -> [Call] {
        allCalls.map{$0}
    }
    
    func calls(user: User) -> [Call] {
        allCalls.filter{$0.incomingUser == user || $0.outgoingUser == user}
    }
    
    func call(id: CallID) -> Call? {
        allCalls.filter{$0.id == id}.first
    }
    
    func currentCall(user: User) -> Call? {
        allCalls.filter({($0.incomingUser == user || $0.outgoingUser == user) && ($0.status == .calling || $0.status == .talk) }).first
    }
}
