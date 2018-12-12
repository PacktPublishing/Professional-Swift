//
//  3-Protocols default implementation.playground
//  Packt Progressional Swift Courseware
//
//  Created by robkerr@mobiletoolworks.com on 11/19/2018.
//
import UIKit

protocol Employee {
    var name: String {get set}
    var phone: String {get set}
    func calcAnnualPay() -> Double
    var directReportCount: Int {get}
}
extension Employee {
    var directReportCount: Int {
        get {
            return 0
        }
    }
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
    var directReports: [Employee]?
    
    func calcAnnualPay() -> Double {
        return annualSalary
    }
    var directReportCount: Int {
        get {
            return directReports?.count ?? 0
        }
    }
}

let joe = HourlyEmployee(name: "Joe Smith", phone: "333-333-3333", hourlyWage: 15.50, hoursWorked: 2_000.0)
let jane = Manager(name: "Jane Doe", phone: "444-444-4444", annualSalary: 50_000.0, directReports: [joe])

print(joe.directReportCount)
print(jane.directReportCount)


