import UIKit

extension UIColor {
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    public static let appBackgroundColor = UIColor.rgb(r: 24, g: 24, b: 28)
    public static let navigationBarColor = UIColor.rgb(r: 20, g: 20, b: 24)
    public static let shadedWhiteColor = UIColor.rgb(r: 210, g: 210, b: 210)
}
