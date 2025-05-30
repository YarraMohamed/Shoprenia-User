import SwiftUI
import FirebaseCore
import FirebaseAuth

struct RegisterationView: View {
    @StateObject private var viewModel = RegistarationViewModel()
    @StateObject private var authManager = FirebaseAuthenticationManager.shared
    
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
            
            VStack{
                
                Spacer()
                
                TextField("Name...",text: $viewModel.name)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onChange(of: viewModel.name) { oldValue,newValue in
                            viewModel.nameEdited = true
                        }

                    if viewModel.nameEdited && !viewModel.isValidName() {
                        Text("Name should be more than 3 characters")
                            .foregroundStyle(.red)
                            .font(.system(size: 10, weight: .semibold))
                    }
                
                TextField("Email...",text:$viewModel.email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onChange(of: viewModel.email) { oldValue,newValue in
                            viewModel.emailEdited = true
                        }

                    if viewModel.emailEdited && !viewModel.isValidEmail() {
                        Text("Email should be in a valid format")
                            .foregroundStyle(.red)
                            .font(.system(size: 10, weight: .semibold))
                    }
                
                
                SecureField("Password",text: $viewModel.password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onChange(of: viewModel.password) { oldValue,newValue in
                            viewModel.passwordEdited = true
                        }

                    if viewModel.passwordEdited && !viewModel.isValidPassword() {
                        Text("Password should be longer than 7 charachters")
                            .foregroundStyle(.red)
                            .font(.system(size: 10, weight: .semibold))
                    }
            }
            .padding()
            
            NavigationLink {
               Text("Login Page")
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
                
                HStack{
                    Button("Sign Up"){
                        
                        if viewModel.isValidEmail() && viewModel.isValidName() && viewModel.isValidPassword() {
                            
                            authManager.createUser(email: viewModel.email, password: viewModel.password, name: viewModel.name)
                            
                        }
                        
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 343, height: 48)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.blue)
                    }
                }
                .padding(.vertical)
            
            
            VStack{
                Spacer()
                Text("Or Sign up with social account")
                HStack(spacing: 10){
                    
                    Button(action:{
                        
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
