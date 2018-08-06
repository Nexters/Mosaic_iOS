import Foundation

extension NSObject {
    static var id: String {
        return String(describing: self)
    }
}

/*
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SignUpViewController.id)
 */
