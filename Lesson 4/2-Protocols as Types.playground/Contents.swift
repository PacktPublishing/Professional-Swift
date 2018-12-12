//
//  2-Protocols as Types.playground
//  Packt Progressional Swift Courseware
//
//  Created by robkerr@mobiletoolworks.com on 11/19/2018.
//
import UIKit

protocol Employee {
    var name: String {get set}
    var phone: String {get set}
    func calcAnnualPay() -> Double
}

struct HourlyEmployee: Employee {
    var name: String
    var phone: String
    
    var hourlyWage: Double
    var hoursWorked: Double
    
    func calcAnnualPay() -> Double {
        return hourlyWage * hoursWorked
    }
}
struct Manager: Employee {
    var name: String
    var phone: String
    
    var annualSalary: Double
    
    func calcAnnualPay() -> Double {
        return annualSalary
    }
}

let obj1:AnyObject = Manager(name: "Jane Doe", phone: "444-444-4444", annualSalary: 50_000.0) as AnyObject

print(obj1 is HourlyEmployee)
print(obj1 is Manager)
print(obj1 is Employee)

