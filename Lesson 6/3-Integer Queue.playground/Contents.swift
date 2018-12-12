//
//  3-Integer Queue.playground
//  Packt Progressional Swift Courseware
//
//  Created by robkerr@mobiletoolworks.com on 11/19/2018.
//
import UIKit

struct Queue {
    var members : [Int] = []
    
    mutating func add(member: Int) {
        members.append(member)
    }
    mutating func remove() -> Int? {
        if let topItem = members.first {
            members.remove(at: 0)
            return topItem
        }
        return nil
    }
}

var q = Queue()
q.add(member: 5)
q.add(member: 10)
q.add(member: 99)

for _ in 1...4 {
    print(q.remove() ?? "Empty Queue")
}
