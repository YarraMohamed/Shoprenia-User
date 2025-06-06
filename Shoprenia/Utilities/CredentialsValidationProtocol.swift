import Foundation


protocol CredentialsValidationProtocol{
        
    func isValidName(_ name : String) -> Bool
    
    func isValidEmail(email : String) -> Bool
    
    func isValidPassword(password:String) -> Bool
    
    func isValidPhoneNumber(phoneNumber : String) -> Bool
    
    func allValidation(email : String,firstName:String,lastName:String,phoneNumber : String,password:String) -> Bool 
    
}
