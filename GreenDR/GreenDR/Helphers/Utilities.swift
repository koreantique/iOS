import Foundation
import UIKit

class Utilities{
    static func isPasswordTest(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$" )
        return passwordTest.evaluate(with: password)
    }
    
    
}
