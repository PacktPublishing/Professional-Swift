//
//  1-Employee Struct.playground
//  Packt Progressional Swift Courseware
//
//  Created by robkerr@mobiletoolworks.com on 11/19/2018.
//
import UIKit

struct Employee {
    
    enum PayType {
        case hourly
        case salaried
    }
    
    var name: String
    var isManager: Bool = false
    var payType: PayType
    
    var hourlyWage: Double?
    var hoursWorked: Double?
    
    var annualSalary: Double?
    
    var directReports: [Employee]?
    
    init(name: String, hourlyWage: Double, hoursWorked: Double) {
        self.name = name
        self.payType = .hourly
        self.hourlyWage = hourlyWage
        self.hoursWorked = hoursWorked
    }
    
    init(name: String, annualSalary: Double, isManager: Bool) {
        self.name = name
        self.payType = .salaried
        self.annualSalary = annualSalary
        self.isManager = isManager
    }
    
    func calcAnnualPay() -> Double {
        switch payType {
        case .hourly:
            return (hourlyWage ?? 0.0) * (hoursWorked ?? 0.0)
        case .salaried:
            return annualSalary ?? 0.0
        }
    }
    
    mutating func addDirectReport(employee: Employee) {
        if directReports == nil {
            directReports = [Employee]()
        }
        
        directReports?.append(employee)
    }
}

var employees = [Employee]()

let worker1 = Employee(name: "Jack Holt", hourlyWage: 35.75, hoursWorked: 2000.0)
let worker2 = Employee(name: "Loren Vanderbilt", hourlyWage: 28.50, hoursWorked: 2_000.0)
var manager = Employee(name: "Wendy Smith", annualSalary: 80_000.0, isManager: true)

manager.addDirectReport(employee: worker1)
manager.addDirectReport(employee: worker2)

employees.append(worker1)
employees.append(worker2)
employees.append(manager)

print("*List employees")
for employee in employees {
    print("  \(employee.name): \(employee.calcAnnualPay())")
    
    if employee.isManager {
        print("** List direct reports of \(employee.name)")
        if let directReports = employee.directReports {
            for directReport in directReports {
                print("   \(directReport.name): \(directReport.calcAnnualPay())")
            }
        }
    }
}
