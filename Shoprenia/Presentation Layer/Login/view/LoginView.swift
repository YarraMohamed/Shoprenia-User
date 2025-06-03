import SwiftUI
import GoogleSignIn
import FirebaseCore
import FirebaseAuth
struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
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
                        
                        viewModel.createCustomerAccessToken(mail: viewModel.email,
                                                            pass: viewModel.password)
                        viewModel.signFirebaseUserIn()
                        
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
    LoginView()
}
