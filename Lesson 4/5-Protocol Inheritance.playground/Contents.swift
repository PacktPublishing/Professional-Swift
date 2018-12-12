//
//  5-Protocol Inheritance.playground
//  Packt Progressional Swift Courseware
//
//  Created by robkerr@mobiletoolworks.com on 11/19/2018.
//
import UIKit

protocol Employee {
    var employeeName: String {get set}
}

struct HealthPlan {
    var healthPlanName: String
}

protocol SalariedEmployee {
    var hireDate: Date {get set}
    var healthPlanSelected: HealthPlan {get set}
}

protocol ManagerEmployee: Employee, SalariedEmployee {
    var directReports: [Employee]? {get set}
}

struct Manager: ManagerEmployee {
    var employeeName: String
    var hireDate: Date
    var healthPlanSelected: HealthPlan
    var directReports: [Employee]?
}

func printHealthPlan(employee: Employee & SalariedEmployee) {
    print("\(employee.employeeName) is enrolled in \(employee.healthPlanSelected.healthPlanName)")
}

let emp = Manager(
    employeeName: "Amy Smith",
    hireDate: Date.distantPast,
    healthPlanSelected: HealthPlan(healthPlanName: "Blue Cross"),
    directReports: [])

printHealthPlan(employee: emp)
