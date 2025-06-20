import SwiftUI
import GoogleSignIn
import FirebaseCore
import FirebaseAuth
struct LoginView: View {
    @ObservedObject var viewModel : LoginViewModel
    @Binding var path : NavigationPath
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Login")
                    .font(.system(size: 32,weight: .semibold))
                    .foregroundStyle(.blue)
                    .padding(.vertical,40)
                    .padding(.leading,16)
                
                Spacer()
            }
            
            VStack{
                
                Spacer()
                
                TextField("Email...",text:$viewModel.email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                SecureField("Password",text: $viewModel.password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
            .padding()
            
               HStack{
                    Button("Login"){
                        
                        
                        if viewModel.isValidEmail() && viewModel.isValidPassword(){
                            
                            viewModel.createCustomerAccessToken(mail: viewModel.email,
                                pass: viewModel.password)
                            
                            viewModel.signFirebaseUserIn()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                if viewModel.isLoggedIn{
                                    print("\(viewModel.isLoggedIn)")
                                    //path.append(AppRouter.home)
                                    path.removeLast(1)
                                    viewModel.isLoggedIn = false
                                }else{
                                    viewModel.showAlert = true
                                }
                            }
                        }else{
                            viewModel.showAlert = true
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
                Text("Or Login with Google")
                HStack(spacing: 10) {
                    Button(action: {
                        viewModel.googleSignIn(rootController: getRootViewController())

                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                            if viewModel.isLoggedIn {
                                if !path.isEmpty {
                                    path.removeLast(1)
                                }
                                viewModel.isLoggedIn = false
                            }
                        }
                    }) {
                        Image("g")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                }
            }

            Spacer()
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                    VStack {
                        Text("Shoprenia")
                            .font(.system(size: 20,weight: .semibold))
                            .foregroundColor(.blue)
                    }
                }
        }
        .alert("Please insert valid credentials", isPresented: $viewModel.showAlert) {
            Button("Ok",role: .cancel){
                viewModel.showAlert = false
            }
        }
    }
}

#Preview {
   // LoginView()
}
