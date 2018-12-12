//
//  3-Employee PO Structs.playground
//  Packt Progressional Swift Courseware
//
//  Created by robkerr@mobiletoolworks.com on 11/19/2018.
//
import UIKit

protocol Employee {
    var name: String {get set}
    func calcAnnualPay() -> Double
    var numberOfDirectReports: Int {get}
}
extension Employee {
    var numberOfDirectReports: Int {
        return 0
    }
}

struct HourlyEmployee: Employee {
    var name: String
    
    var hourlyWage: Double
    var hoursWorked: Double
    
    func calcAnnualPay() -> Double {
        return hourlyWage * hoursWorked
    }
}

struct Manager: Employee {
    var name: String
    
    var annualSalary: Double
    var directReports: [Employee]?
    
    var numberOfDirectReports: Int {
        get {
            if let reports = directReports {
                return reports.count
            } else {
                return 0
            }
        }
    }
    
    func calcAnnualPay() -> Double {
        return annualSalary
    }
    
    mutating func addDirectReport(employee: Employee) {
        if directReports == nil {
            directReports = [HourlyEmployee]()
        }
        directReports?.append(employee)
    }
}

var employees = [Employee]()

let worker1 = HourlyEmployee(name: "Jack Holt", hourlyWage: 35.75, hoursWorked: 2_000.0)
let worker2 = HourlyEmployee(name: "Loren Vanderbilt", hourlyWage: 28.50, hoursWorked: 2_000.0)
var manager = Manager(name: "Wendy Smith", annualSalary: 80_000.0, directReports: nil)

manager.addDirectReport(employee: worker2)
manager.addDirectReport(employee: worker1)

employees.append(worker1)
employees.append(worker2)
employees.append(manager)

print("* List employees: ")
for employee in employees {
    print("  \(employee.name): annual pay is \(employee.calcAnnualPay()) and has \(employee.numberOfDirectReports) direct reports.")
    
    if let manager = employee as? Manager, let directReports = manager.directReports {
        print("   ** List direct reports of \(manager.name)")
        for directReport in directReports {
            print("      \(directReport.name): \(directReport.calcAnnualPay())")
        }
    }
}
