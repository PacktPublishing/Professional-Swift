//
//  2-Employee OO Classes.playground
//  Packt Progressional Swift Courseware
//
//  Created by robkerr@mobiletoolworks.com on 11/19/2018.
//
import UIKit

class Employee: NSObject {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func calcAnnualPay() -> Double {
        fatalError()
    }
}

class HourlyEmployee: Employee {
    var hourlyWage: Double
    var hoursWorked: Double
    
    init(name: String, hourlyWage: Double, hoursWorked: Double) {
        self.hourlyWage = hourlyWage
        self.hoursWorked = hoursWorked
        super.init(name: name)
    }
    
    override func calcAnnualPay() -> Double {
        return hourlyWage * hoursWorked
    }
}

class Manager: Employee {
    var annualSalary: Double
    var directReports: [Employee]?
    
    init(name: String, annualSalary: Double) {
        self.annualSalary = annualSalary
        super.init(name: name)
    }
    
    override func calcAnnualPay() -> Double {
        return annualSalary
    }
    
    func addDirectReport(employee: Employee) {
        if directReports == nil {
            directReports = [Employee]()
        }
        directReports?.append(employee)
    }
}

var employees = [Employee]()

let worker1 = HourlyEmployee(name: "Jack Holt", hourlyWage: 35.75, hoursWorked: 2_000.0)
let worker2 = HourlyEmployee(name: "Loren Vanderbilt", hourlyWage: 28.50, hoursWorked: 2_000.0)
let manager = Manager(name: "Wendy Smith", annualSalary: 80_000.0)

manager.addDirectReport(employee: worker1)
manager.addDirectReport(employee: worker2)

employees.append(worker1)
employees.append(worker2)
employees.append(manager)

print("* List employees: ")
for employee in employees {
    print("  \(employee.name): \(employee.calcAnnualPay())")
    
    if let manager = employee as? Manager, let directReports = manager.directReports {
        print("   ** List direct reports of \(manager.name)")
        for directReport in directReports {
            print("      \(directReport.name): \(directReport.calcAnnualPay())")
        }
    }
}
