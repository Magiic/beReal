import DesignSystem
import SwiftUI

struct AppOnboardingUserInfoView<Validator: ValidationThrows>: View where Validator.T == String {
    
    @Binding var email: String
    let emailValidator: Validator
    
    @State private var isEmailValid = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                
                TextField("Email", text: $email)
                    .font(.title)
                    .accessibilityIdentifier("email_textfield")
                
                Text("To contact you if our terms change. Rest assured, we won't spam you but will only contact you when necessary.")
                    .footnoteTextStyle(color: .init(all: Color.secondary))
            }
            
            if #available(iOS 17.0, *) {
                Image(systemName: isEmailValid ? "checkmark.circle.fill" : "x.square.fill")
                    .foregroundStyle(isEmailValid ? Color.green : Color.red)
                    .contentTransition(.symbolEffect(.replace))
                    .accessibilityIdentifier(isEmailValid ? "checkmark_valid" : "checkmark_invalid")
            } else {
                Image(systemName: isEmailValid ? "checkmark.circle.fill" : "x.square.fill")
                    .foregroundStyle(isEmailValid ? Color.green : Color.red)
            }
        }
        .padding(.horizontal, 16)
        .onChange(of: email) { newValue in
            do {
                try emailValidator.validationThrow?(newValue)
                isEmailValid = true
            } catch {
                isEmailValid = false
            }
        }
    }
}

@available(iOS 18, *)
#Preview {
    @Previewable @State var email = ""
    AppOnboardingUserInfoView(email: $email, emailValidator: EmailValidator())
}
