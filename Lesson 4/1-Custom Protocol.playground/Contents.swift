//  1-Custom Protocol.playground
//  Packt Progressional Swift Courseware
//
//  Created by robkerr@mobiletoolworks.com on 11/19/2018.
//
import Foundation

protocol SomeProtocol {
    func transferInformation(_ info: String)
}

class Receiver: SomeProtocol {
    var sender: Sender?
    
    init() {
        sender = Sender()
        sender?.delegate = self
        sender?.doOperation()
    }
    
    func transferInformation(_ info: String)
    {
        print(info)
    }
}

class Sender {
    var delegate: SomeProtocol?
    
    func doOperation()
    {
        delegate?.transferInformation("Hello")
    }
}

var obj = Receiver()
