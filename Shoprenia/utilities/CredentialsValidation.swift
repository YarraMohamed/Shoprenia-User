import Foundation


class CredentialsValidation : CredentialsValidationProtocol{
    
    func isValidName(_ name : String) -> Bool {
        return name.count > 3
    }
    
    func isValidEmail(email : String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(password:String) -> Bool {
       
        guard password.count >= 8 else { return false }
        
      
        let uppercaseCheck = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
        guard uppercaseCheck.evaluate(with: password) else { return false }
        
   
        let lowercaseCheck = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*")
        guard lowercaseCheck.evaluate(with: password) else { return false }
        
    
        let digitCheck = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
        guard digitCheck.evaluate(with: password) else { return false }
        
        return true
    }
    
    func isValidPhoneNumber(phoneNumber : String) -> Bool {
        let phoneRegex = "^\\+2\\d{11}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: phoneNumber)
    }
    
    func allValidation(email : String,firstName:String,lastName:String,phoneNumber : String,password:String) -> Bool {
        return isValidEmail(email: email) && isValidName(firstName) && isValidName(lastName) && isValidPassword(password: password) && isValidPhoneNumber(phoneNumber: phoneNumber)
    }
    
}
