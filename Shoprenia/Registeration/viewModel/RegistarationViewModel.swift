import Foundation


final class RegistarationViewModel : ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var nameEdited = false
    @Published var emailEdited = false
    @Published var passwordEdited = false

    func isValidName() -> Bool {
        return self.name.count > 3
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self.email)
    }
    
    func isValidPassword() -> Bool {
        return self.password.count > 7
    }
    
}
