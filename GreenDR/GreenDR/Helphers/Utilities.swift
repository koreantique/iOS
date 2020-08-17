import Foundation
import UIKit

class Utilities{
    static func isPasswordTest(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$" )
        return passwordTest.evaluate(with: password)
    }
    
    let lightGreenColor = UIColor(red: 232/255.0, green: 253/255.0, blue: 202/255.0, alpha: 1)
}
