import SwiftUI
import FirebaseCore
import FirebaseAuth

struct RegisterationView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showNameErrorMsg = false
    @State private var showEmailErrorMsg = false
    @State private var showPasswordErrorMsg = false
    @StateObject private var validator = RegisterationValidator()

    var body: some View {
        VStack{
            HStack{
                Text("Sign Up")
                    .font(.system(size: 32,weight: .semibold))
                    .foregroundStyle(.blue)
                    .padding(.vertical,40)
                    .padding(.leading,16)
                
                Spacer()
            }
            
           
            HStack{
                TextField("Name",text: $name)
                    .autocorrectionDisabled()
                    .padding()
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            
            if showNameErrorMsg {
                Text("Name should be more than 3 charachters")
                    .foregroundStyle(.red)
                    .font(.system(size: 10,weight: .semibold))
            }
            
            HStack{
                TextField("Email",text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                    .padding()
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            
            if showEmailErrorMsg{
                Text("Invalid email address")
                    .foregroundStyle(.red)
                    .font(.system(size: 10,weight: .semibold))
            }
            
            HStack{
                SecureField("Password",text: $password)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                    .padding()
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            
            if showPasswordErrorMsg{
                Text("Password should be longer than 7 characters")
                    .foregroundStyle(.red)
                    .font(.system(size: 10,weight: .semibold))
            }
            
            NavigationLink {
               // LoginView() msln y3ne
            } label: {
                HStack {
                    Spacer()
                    
                    HStack {
                        Text("Already have an account? ")
                            .foregroundStyle(.black)
                            .font(.system(size: 14, weight: .semibold))
                        
                        Image(systemName: "arrow.right")
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, 16)
                }
            }
            
            NavigationLink{
                //HomeView() Msln lw 3ml registeration
            } label: {
                
                HStack{
                    Button("Sign Up"){
                        
                       showEmailErrorMsg =  validator.isValidEmail(email)
                        
                       showNameErrorMsg =  validator.isValidName(name)
                        
                       showPasswordErrorMsg =  validator.isValidPassword(password)
                        
                        if showNameErrorMsg == true && showEmailErrorMsg == true && showPasswordErrorMsg == true {
                            //register in firebase && navigate to home
                        }
                        
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 343, height: 48) // Fixed width & height
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.blue)
                    }
                }
                .padding(.vertical)
            }
            
            VStack{
                Spacer()
                Text("Or Sign up with social account")
                HStack(spacing: 10){
                    
                    Button(action:{
                        //logic firebase
                    }){
                        Image("g")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50,height: 50)
                            .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black,
                                            lineWidth: 1
                                        )
                                    )
                    }
                    
                    Button(action:{
                        //logic firebase
                    }){
                        Image("apple")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50,height: 50)
                            .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black,
                                            lineWidth: 1
                                        )
                                    )
                    }
                }
            }
            
            Spacer()
        }
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                    VStack {
                        Text("Shoprenia")
                            .font(.system(size: 20,weight: .semibold))
                            .foregroundColor(.blue)
                    }
                }
        }
    }
}

#Preview {
    NavigationStack{
        RegisterationView()
    }
    
}
