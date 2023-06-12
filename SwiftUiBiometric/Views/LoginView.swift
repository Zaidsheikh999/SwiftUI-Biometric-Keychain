//
//  LoginView.swift
//  SwiftUiBiometric
//
//  Created by Zaid Sheikh on 12/06/2023.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var loginVM = LoginViewModel()
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        VStack(spacing: 15) {
            
            Spacer()
            
            Image(systemName: "lock.rectangle.stack.fill")
               .font(.system(size: 70))
               .foregroundColor(.black)
               .padding(.bottom, 10)
            
            TextField("Email Address", text: $loginVM.credentials.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.system(size: 25))
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $loginVM.credentials.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.system(size: 25))
                .padding(.bottom, 10)
            
            if loginVM.showProgressView {
                ProgressView()
            }
            Button(action: {
                // Perform login authentication
                loginVM.login { success in
                    authentication.updateValidation(success: success)
                }
                
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .cornerRadius(10)
            }
            .disabled(loginVM.loginDisabled)
            .padding()
            .padding(.bottom,20)
            
            if authentication.biometricType() != .none {
                Button {
                    authentication.requestBiometricUnlock { (result:Result<Credentials, Authentication.AuthenticationError>) in
                        switch result {
                        case .success(let credentials):
                            loginVM.credentials = credentials
                            loginVM.login { success in
                                authentication.updateValidation(success: success)
                            }
                        case .failure(let error):
                            loginVM.error = error
                        }
                    }
                } label: {
                    Image(systemName: authentication.biometricType() == .face ? "faceid" : "touchid")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.black)
                }
            }
            Image("")
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
            Spacer()
            Spacer()
        }
        .autocapitalization(.none)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .disabled(loginVM.showProgressView)
        .alert(item: $loginVM.error) { error in
            if error == .credentialsNotSaved {
                return Alert(title: Text("Credentials Not Saved"),
                             message: Text(error.localizedDescription),
                             primaryButton: .default(Text("OK"), action: {
                                loginVM.storeCredentialsNext = true
                             }),
                             secondaryButton: .cancel())
            } else {
                return Alert(title: Text("Invalid Login"), message: Text(error.localizedDescription))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(Authentication())
    }
}
