//
//  6-Associated Types.playground
//  Packt Progressional Swift Courseware
//
//  Created by robkerr@mobiletoolworks.com on 11/19/2018.
//
import UIKit

protocol Checksummable {
    associatedtype ChecksummableType
    func calcChecksum() -> Int
    func set(item: ChecksummableType)
}

class Filename : Checksummable {
    typealias ChecksummableType = String
    
    var filename: String?
    
    func set(item: ChecksummableType) {
        self.filename = item
    }
    func calcChecksum() -> Int {
        guard let fname = self.filename else {
            return 0
        }
        if let data = fname.data(using: .utf8, allowLossyConversion: false) {
            let array = [UInt8](data)
            let checksum = array.reduce(0, {$0 + Int($1)})
            return checksum
        }
        return 0
    }
}
class IntegerArray : Checksummable {
    typealias ChecksummableType = [Int]
    
    var array: [Int]?
    
    func set(item: ChecksummableType) {
        self.array = item
    }
    func calcChecksum() -> Int {
        guard let array = self.array else {
            return 0
        }
        return array.reduce(0, {$0 + Int($1)})
    }
}

var filename = Filename()
filename.set(item: "hello world.text")
print(filename.calcChecksum())

var intArray = IntegerArray()
intArray.set(item: [1,2,3,4,5])
print(intArray.calcChecksum())


