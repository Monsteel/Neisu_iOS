//
//  String.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 08/08/2020.
//

import Foundation

extension String
{
    func isValidEmail() -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidId() -> Bool {

        let idRegEx = "[a-zA-Z0-9]{5,20}"
        
        let idTest = NSPredicate(format:"SELF MATCHES %@", idRegEx)
        return idTest.evaluate(with: self)
    }
    
    func isValidPw() -> Bool {

        let pwRegEx = "[a-zA-Z0-9!@#$%^*+=-]{7,20}"
        
        let pwTest = NSPredicate(format:"SELF MATCHES %@", pwRegEx)
        return pwTest.evaluate(with: self)
    }
    
    
    func isValidName() -> Bool {
        let nameRegEx = "[a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ]{2,12}"
        
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
    }
    
    func isValidGrade() -> Bool {
        let gradeRegEx = "[1-3]{1}"
        
        let gradeTest = NSPredicate(format:"SELF MATCHES %@", gradeRegEx)
        return gradeTest.evaluate(with: self)
    }
    
    func isValidClass() -> Bool {
        let classRegEx = "[1-3]{1}"
        
        let classTest = NSPredicate(format:"SELF MATCHES %@", classRegEx)
        return classTest.evaluate(with: self)
    }
    
    func isValidPhone() -> Bool {
        let phoneRegEx = "[0-9]{10,11}"
        
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }
    
    
}
