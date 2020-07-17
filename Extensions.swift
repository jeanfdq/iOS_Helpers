//
//  Extensions.swift
//  Bradesco
//
//  Created by Jean Paull on 27/06/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//


import UIKit
import MapKit
import SafariServices

extension UIFont {
    
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static func regular(name: String, ofSize size: CGFloat) -> UIFont {
        return customFont(name: name, size: size)
    }
    
    static func medium(name: String, ofSize size: CGFloat) -> UIFont {
        return customFont(name: name, size: size)
    }
    
    static func bold(name: String, ofSize size: CGFloat) -> UIFont {
        return customFont(name: name, size: size)
    }
 
}

extension Notification.Name {
    static let UNDidMakeReservation = Notification.Name("UNDidMakeReservation")
    static let UNDidPaidReservation = Notification.Name("UNDidPaidReservation")
    static let UNUserDidLogin = Notification.Name("UNUserDidLogin")
    static let UNUserDidLogout = Notification.Name("UNUserDidLogout")
    static let UNDidCanceledReservation = Notification.Name("UNDidCanceledReservation")
    static let UNDidUpdateCurrentUser = Notification.Name("UNDidUpdateCurrentUser")
    static let UNDidContractFinish = Notification.Name("UNDidContractFinish")
    static let UNDidChangeProfileImage = Notification.Name("UNDidChangeProfileImage")
    static let UNDidExtendReturn = Notification.Name("UNDidExtendReturn")
    static let UNDidUnreadMessage = Notification.Name("UNDidUnreadMessage")
    static let UNDidOpenContract = Notification.Name("UNDidOpenContract")
    static let UNDidCloseContract = Notification.Name("UNDidCloseContract")
    static let UNDidUpdateContract = Notification.Name("UNDidUpdateContract")
}

extension UIViewController {
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }

    func showAlertSingle(_ title:String, _ message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnOK = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(btnOK)
        present(alert, animated: true, completion: nil)
    }
}

extension UINavigationController {
    
    func pushViewController(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    func popViewController(animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func popToRootViewController(animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }
    
    func change(backgroundColor: UIColor = #colorLiteral(red: 0.0431372549, green: 0.2274509804, blue: 0.4784313725, alpha: 1)) {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = backgroundColor
            appearance.shadowImage = UIImage()
            appearance.shadowColor = UIColor.clear
            appearance.backgroundImage = nil
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBar.backgroundColor = backgroundColor
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance = appearance
            navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            navigationBar.tintColor = UIColor.white
        } else {
            navigationBar.barTintColor = backgroundColor
            navigationBar.shadowImage = UIImage()
            navigationBar.tintColor = UIColor.white
            navigationBar.setBackgroundImage(nil, for: .default)
            navigationBar.backgroundColor = backgroundColor
            navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
        navigationBar.isTranslucent = false
    }
}

extension NumberFormatter {
    static var currencyFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "pt-br")
        return numberFormatter
    }
    
    static var currencyFormatterWithouRounding: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.roundingMode = NumberFormatter.RoundingMode.down
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "pt-br")
        return numberFormatter
    }
    
    static var percentFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.locale = Locale(identifier: "pt-br")
        return numberFormatter
    }
    
    static var decimalNumberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }
    
    static var apiNumberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ""
        numberFormatter.decimalSeparator = "."
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }
    
    static let percentNumberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.minimumIntegerDigits = 1
        return numberFormatter
    }()
  
}

extension UINavigationBar {
    
    func shouldRemoveShadow(_ value: Bool) -> Void {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
}

extension Double {
    
    func round(to places: Int ) -> Double {
        
        let precisionNumber = pow(10, Double(places))
        var number = self
        number = number * precisionNumber
        number.round()
        number = number / precisionNumber
        return number
        
    }
    
}

extension Encodable {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

extension Data {
    
     func toModel<T:Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
    
    func toJSON() -> NSDictionary? {
        return try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? NSDictionary
    }
}

extension UIAlertAction {
    
    static func ok(_ handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        let title = NSLocalizedString("OK", comment: "OK alert action title")
        return UIAlertAction(title: title, style: .default, handler: handler)
    }
    
    static func dismiss(_ handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        let title = NSLocalizedString("Dismiss", comment: "Dismiss alert action title")
        return UIAlertAction(title: title, style: .default, handler: handler)
    }
    
    static func cancel(_ handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        let title = NSLocalizedString("Cancel", comment: "Cancel alert action title")
        return UIAlertAction(title: title, style: .cancel, handler: handler)
    }

    static func setTitleColor(color:UIColor){
        
        self.setValue(color, forKey: "titleTextColor")
        
    }
    
}

extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func execSubstring( _ startIndex:Int, _ endIndex:Int) -> String {
        
        let substr = self
        let start   = substr.index(substr.startIndex, offsetBy: startIndex)
        let end     = substr.index(substr.endIndex, offsetBy: (substr.count - endIndex) * (-1))
        let range   = start..<end
        
        return String(substr[range])
        
        
    }
    
    func getIndexOfChar(_ ch:String) -> Int {
        
        if let range = self.range(of: ch) {
            
            return self.distance(from: self.startIndex, to: range.lowerBound)
            
        }else{
            return 0
        }
    }
    
    func maskCNPJ() -> String {
        var characters = [Character](self)
        if self.count >= 2 {
            characters.insert(".", at: 2)
        }
        if self.count >= 6 {
            characters.insert(".", at: 6)
        }
        if self.count >= 10 {
            characters.insert("/", at: 10)
        }
        if self.count >= 15 {
            characters.insert("-", at: 15)
        }
        return String(characters)
    }

    func isEmailValid() -> Bool {
        
        let regexEmail = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailText = NSPredicate(format: "SELF MATCHES[c] %@", regexEmail)
        
        return emailText.evaluate(with: self.trim())
        
    }

    func isEmailValid2() -> Bool {
		let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try? NSRegularExpression(pattern: pattern)
		return regex?.firstMatch(in: self, options: [], range: range) != nil
    }

    func Base64ToImage() -> UIImage {
        
        let imageData = Data(base64Encoded: self, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }

    //Validaçao CPF e CNPJ
    var isValidCPF: Bool {
        let numbers = compactMap(\.wholeNumberValue)
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        return numbers.prefix(9).digitoCPF == numbers[9] &&
               numbers.prefix(10).digitoCPF == numbers[10]
    }
    
    var isValidCNPJ: Bool {
        let numbers = compactMap(\.wholeNumberValue)
        guard numbers.count == 14 && Set(numbers).count != 1 else { return false }
        return numbers.prefix(12).digitoCNPJ == numbers[12] &&
               numbers.prefix(13).digitoCNPJ == numbers[13]
    }
    
}

extension Collection where Element == Int {
    var digitoCPF: Int {
        var number = count + 2
        let digit = 11 - reduce(into: 0) {
            number -= 1
            $0 += $1 * number
        } % 11
        return digit > 9 ? 0 : digit
    }
    
    var digitoCNPJ: Int {
        var number = 1
        let digit = 11 - reversed().reduce(into: 0) {
            number += 1
            $0 += $1 * number
            if number == 9 { number = 1 }
        } % 11
        return digit > 9 ? 0 : digit
    }
}

extension UIColor {
    
    func FromHexaToColor(_ hexa:String) -> UIColor {
        
        var cString = hexa.trim().uppercased()
        
        if hexa.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            return .lightGray
        }
        
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return .init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: 1)
        
    }
    
    func FromRGBToColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}

extension NSNotification {
    
    func getKeyboardSize() -> CGRect? {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    }
    
    func getKeyboardDurationShow() -> Double? {
        return userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
    }
    
}

extension UIButton {
    
    func setShakeAnime() {
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.fillMode = .forwards
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            animation.repeatCount = 2
            animation.autoreverses = true
            animation.duration = 0.1
            animation.fromValue = CGPoint(x: self.center.x - 5, y: self.center.y)
            animation.toValue = CGPoint(x: self.center.x + 5, y: self.center.y)
            layer.add(animation, forKey: nil)
            
    }

    func setShakePulse(){
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.9
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1
        
        layer.add(pulse, forKey: nil)
        
    }

    func setShakeFlash(){
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.autoreverses = true
        flash.repeatCount = 3
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        layer.add(flash, forKey: nil)
        
    }

    
}

extension UILabel {
    
    func setUnderline() {
        
        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue])
        attributedText = underlineAttributedString
        
        
    }

    func addShadow(){
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowRadius  = 2
        layer.shadowOpacity = 0.8
        layer.shadowOffset  = CGSize(width: 1, height: 1)
        layer.masksToBounds = false
    }
    
}

extension UITextField {
    
    func setIconRight(_ image:UIImage, _ isAppear:Bool){
        
        let iconView = UIImageView(frame: CGRect(x: -5, y: 0, width: 22, height: 20))
        iconView.image = image
        
        let iconContainerView = UIView(frame: CGRect(x: -5, y: 0, width: 25, height: 20))
        iconContainerView.addSubview(iconView)
        
        rightView = iconContainerView
        rightViewMode = isAppear ? .always : .never
        
        tintColor = isAppear ? UIColor.red : UIColor.gray
        
    }
    
    func paddingLeft(value:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    func paddingRight(value:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: frame.height))
        rightView = paddingView
        rightViewMode = .always
    }
}

extension UIView {
    
	// Corner separados-----------------------------------------
	enum Corner:Int {
	   case bottomRight = 0,
	   topRight,
	   bottomLeft,
	   topLeft
	}
   
	func roundCorners(corners: [Corner], amount: CGFloat = 5) {
	   layer.cornerRadius = amount
	   let maskedCorners: CACornerMask = CACornerMask(rawValue: createMask(corners: corners))
	   layer.maskedCorners = maskedCorners
	}
	private func createMask(corners: [Corner]) -> UInt {
	   return corners.reduce(0, { (a, b) -> UInt in
		   return a + parseCorner(corner: b).rawValue
	   })
	}
	private func parseCorner(corner: Corner) -> CACornerMask.Element {
	   let corners: [CACornerMask.Element] = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
	   return corners[corner.rawValue]
	}
	//--------------------------------------------------------------
	
	func setCorner(radius:CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func setBorder(_ color:UIColor, _ width:CGFloat) {
        layer.borderColor   = color.cgColor
        layer.borderWidth   = width
    }
	
	func setShadow(color:UIColor = .black ,radius: CGFloat, opacity:Float, offSet: CGSize = .init(width: 1, height: 1)){
        layer.shadowColor   = color.cgColor
        layer.shadowRadius  = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset  = offSet
        layer.masksToBounds = false
    }
	
    func setRightTriangle(){
        let heightWidth = frame.size.width //you can use triangleView.frame.size.height
        let path = CGMutablePath()

        path.move(to: CGPoint(x: heightWidth/2, y: 0))
        path.addLine(to: CGPoint(x:heightWidth, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth/2, y:heightWidth))
        path.addLine(to: CGPoint(x:heightWidth/2, y:0))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.blue.cgColor

        
        layer.insertSublayer(shape, at: 0)
    }

    func setLeftTriangle(targetView:UIView?){
        let heightWidth = targetView!.frame.size.width
        let path = CGMutablePath()

        path.move(to: CGPoint(x: heightWidth/2, y: 0))
        path.addLine(to: CGPoint(x:0, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth/2, y:heightWidth))
        path.addLine(to: CGPoint(x:heightWidth/2, y:0))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.blue.cgColor

        targetView!.layer.insertSublayer(shape, at: 0)
    }

    func setUpTriangle(targetView:UIView?){
     let heightWidth = targetView!.frame.size.width
        let path = CGMutablePath()

        path.move(to: CGPoint(x: 0, y: heightWidth))
        path.addLine(to: CGPoint(x:heightWidth/2, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth, y:heightWidth))
        path.addLine(to: CGPoint(x:0, y:heightWidth))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.blue.cgColor

        targetView!.layer.insertSublayer(shape, at: 0)
    }

    func setDownTriangle(targetView:UIView?){
        let heightWidth = targetView!.frame.size.width
        let path = CGMutablePath()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x:heightWidth/2, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth, y:0))
        path.addLine(to: CGPoint(x:0, y:0))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.blue.cgColor

        targetView!.layer.insertSublayer(shape, at: 0)
    }
    
	func applyViewIntoSuperView(value:UIEdgeInsets = .zero){
        
        translatesAutoresizingMaskIntoConstraints = false
        
		leadingAnchor.constraint(equalTo: superview?.leadingAnchor ?? NSLayoutXAxisAnchor(), constant: value.left).isActive = true
        topAnchor.constraint(equalTo: superview?.topAnchor ?? NSLayoutYAxisAnchor(), constant: value.top).isActive = true
        trailingAnchor.constraint(equalTo: superview?.trailingAnchor ?? NSLayoutXAxisAnchor(), constant: value.right).isActive = true
        bottomAnchor.constraint(equalTo: superview?.bottomAnchor ?? NSLayoutYAxisAnchor(), constant: value.bottom).isActive = true
        
    }
    
	func applyViewConstraints( leading: NSLayoutXAxisAnchor? = nil,  top:NSLayoutYAxisAnchor? = nil,  trailing:NSLayoutXAxisAnchor? = nil,  bottom:NSLayoutYAxisAnchor? = nil, centerX:NSLayoutXAxisAnchor? = nil, centerY:NSLayoutYAxisAnchor? = nil, size:CGSize = .zero, value:UIEdgeInsets = .zero ){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: value.left).isActive = true
        }
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: value.top).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: value.right).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: value.bottom).isActive = true
        }
		
		if let centerYSuperView = centerY {
            centerYAnchor.constraint(equalTo: centerYSuperView).isActive = true
        }
        
        if let centerXSuperView = centerX {
            centerXAnchor.constraint(equalTo: centerXSuperView).isActive = true
        }
        
        if size.width != .zero {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != .zero {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    func applyCenterIntoSuperView(size:CGSize = .zero){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerYSuperView = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerYSuperView).isActive = true
        }
        
        if let centerXSuperView = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: centerXSuperView).isActive = true
        }
        
        if size.height != .zero {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
        if size.width != .zero {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    }
    
    func applyJustSize(size:CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if size.width != .zero {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != .zero {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
}

extension Date {
    
    func timeAgoDisplay() -> String {
        
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        let quotient:Int
        let unit:String
        
        if secondsAgo < minute {
            quotient = secondsAgo / minute
            unit = "second"
        }else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "min"
        }else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "hour"
        }else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "day"
        }else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "week"
        }else {
            quotient = secondsAgo / month
            unit = "month"
        }
        
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
        
    }
    
    func getDateToString(_ pattern:String) -> String {
        
        let datePattern = DateFormatter()
        datePattern.dateFormat = pattern
        return datePattern.string(from: self)
        
    }
    
}

extension CLLocationCoordinate2D {
    
    func validateGoogleMaps() -> URL? {
        if let googleMaps = URL(string:"comgooglemaps://") {
            if (UIApplication.shared.canOpenURL(googleMaps)) {
                if let saveGoogleMapsUrl = URL(string:"comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)") {
                    return saveGoogleMapsUrl
                }
            }
        }
        return nil
    }
    
    func validateWaze() -> URL? {
        if let waze = URL(string:"waze://") {
            if (UIApplication.shared.canOpenURL(waze)) {
                let wazeUrl = URL(string: "waze://?ll=\(latitude),\(longitude)&navigate=yes")
                return wazeUrl
            }
        }
        return nil
    }
    
}

extension CLLocation {
    
    func getDistanceToString(_ locationDest:CLLocation) -> String {
        
        let distance = self.distance(from: locationDest) / 1000
		var distanceDecimal = distance.round(to: 3)
        var unidademedida = "Km"
        if distanceDecimal < 1{
            distanceDecimal *= 1000
            unidademedida = "M"
        }else{
			distanceDecimal = distanceDecimal.round(to: 0)
        }
        
        return "\(distanceDecimal) \(unidademedida)"
        
    }
    
    func getDistanceToMeter(_ locationDest:CLLocation) -> Double {
        
        let distance = self.distance(from: locationDest) / 1000
        return Double(distance).round(to: 3)
        
    }
    
}

extension UIImageView {
    
    func setNewHeightWidth(newW:CGFloat) -> CGSize {
        
        let nh = (frame.size.height * newW) / frame.size.width
        
        return CGSize(width: newW, height: nh)
    }

    func toImage(fromView view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
            
        }
        return nil
    }
    
}

extension UIImage {
    
    func ToBase64() -> String? {
        
        guard let imageData = self.pngData() else {return nil}
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        
    }
    
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }

    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    func getLoadImageFromURL(from urlString:String, completion:@escaping(_ img:UIImage?)->Void) {
        
        let imageCache = NSCache<NSString, AnyObject>()
        let keyCache = urlString as NSString
        
        if let imgFromCache = imageCache.object(forKey: keyCache) as? UIImage {
            completion(imgFromCache)
        }else{
            
            if  let imgURL = URL(string: urlString){
                
                URLSession.shared.dataTask(with: imgURL) { (data, response, error) in
                    
                    let httpResponseCode = response as! HTTPURLResponse
                    
                    if httpResponseCode.statusCode == 200 {
                        
                        DispatchQueue.main.async {
                            
                            let imgToCache = UIImage(data: data!)
                            
                            imageCache.setObject(imgToCache!, forKey: keyCache)
                            
                            completion(imgToCache)
                        }
                        
                    }else{
                        print("Error: \(error!.localizedDescription)")
                        completion(nil)
                    }
                    
                }.resume()
                
            }
            
        }
        
        
    }

}

extension Int {
    
    func toString() -> String {
        return String(describing: self)
    }
    
}

extension SFSafariViewController {
    func clearCache(){
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                let calendar = Calendar.current
                if let oneYearAgo = calendar.date(byAdding: .year, value: 1, to: Date()){
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                    HTTPCookieStorage.shared.removeCookies(since:oneYearAgo)
                }
            }
        }
    }
}
