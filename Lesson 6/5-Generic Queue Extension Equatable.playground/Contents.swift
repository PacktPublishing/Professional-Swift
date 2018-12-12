//
//  5-Generic Queue Extension Equatable.playground
//  Packt Progressional Swift Courseware
//
//  Created by robkerr@mobiletoolworks.com on 8/17/17.
//
import UIKit

struct Queue<Member> {
    var members : [Member] = []
    
    mutating func add(member: Member) {
        members.append(member)
    }
    mutating func remove() -> Member? {
        if let topItem = members.first {
            members.remove(at: 0)
            return topItem
        }
        return nil
    }
    func peek() -> Member? {
        if let topItem = members.first {
            return topItem
        }
        return nil
    }
}

extension Queue where Member: Equatable {
    func isLastMember(member: Member?) -> Bool {
        guard let member = member else {
            return false
        }
        
        if let lastMember = members.last, lastMember == member {
            return true
        }
        return false
    }
}

struct Employee {
    var name: String
    var salary: Double
}
extension Employee: Equatable {
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.name == rhs.name && lhs.salary == rhs.salary
    }
}

var q1 = Queue<Int>()

q1.add(member: 60)
q1.add(member: 45)
q1.add(member: 30)
q1.add(member: 15)

while !q1.isLastMember(member: q1.peek())  {
    print(q1.remove() ?? "Empty Queue")
}

var q2 = Queue<Employee>()

q2.add(member: Employee(name: "John Smith", salary: 50_000.0))
q2.add(member: Employee(name: "Alan Stirk", salary: 55_000.0))
q2.add(member: Employee(name: "Mary Adams", salary: 60_000.0))

while !q2.isLastMember(member: q2.peek())  {
    print(q2.remove() ?? "Empty Queue")
}

//repeat {
//    if let member = q2.remove() {
//        print(member)
//    }
//} while q2.peek() != nil


