import SwiftUI
import FirebaseCore
import FirebaseAuth

struct RegisterationView: View {
    @StateObject private var viewModel = RegistarationViewModel()
    
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
                
                TextField("First name...",text: $viewModel.firstName)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onChange(of: viewModel.firstName) { oldValue,newValue in
                            viewModel.firstNameEdited = true
                        }

                if viewModel.firstNameEdited && !viewModel.isValidName(viewModel.firstName) {
                        Text("First Name should be more than 3 characters")
                            .foregroundStyle(.red)
                            .font(.system(size: 10, weight: .semibold))
                    }
                
                
                TextField("Last name...",text: $viewModel.lastName)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onChange(of: viewModel.lastName) { oldValue,newValue in
                            viewModel.lastNameEdited = true
                        }

                if viewModel.lastNameEdited && !viewModel.isValidName(viewModel.lastName) {
                        Text("Last Name should be more than 3 characters")
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
                
                
                TextField("Phone Number...",text:$viewModel.phoneNumber)
                    .keyboardType(.phonePad)
                    .textContentType(.telephoneNumber)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onChange(of: viewModel.phoneNumber) { oldValue,newValue in
                            viewModel.phoneEdited = true
                        }

                    if viewModel.phoneEdited && !viewModel.isValidPhoneNumber() {
                        Text("Number should start with +2 and be 11 digits long")
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
                        Text("Password should be minimum 8 characters, capital letter, small letter, and a number")
                            .foregroundStyle(.red)
                            .font(.system(size: 8, weight: .semibold))
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
                        
                        if viewModel.allValidation()
                            {
                            
                            viewModel.createUser()
                            
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
                Text("Or Sign Up with Google")
                HStack(spacing: 10){
                    
                    Button(action:{
                        viewModel.googleSignIn(rootController: getRootViewController())
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
                }
            }
            
            
            
            Spacer()
        }
        .alert("Verify Your Email", isPresented: $viewModel.showVerificationAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("We've sent a verification email to \(viewModel.email) . Please check your inbox, click the verification link and login.")
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
