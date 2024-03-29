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
import Loaf

extension Bundle {
    var appName: String {
        return infoDictionary?["CFBundleName"] as! String
    }

    var appVersion: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }

    var appBuild: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }

    func loadFile(filename fileName: String) -> Data? {
        let parts = fileName.components(separatedBy: ".")
        if let url = Bundle.main.url(forResource: parts[0], withExtension: parts[1]), let data = try? Data(contentsOf: url) {
            return data
        } else {
            return nil
        }
    }
}

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

    func setupNavigationBar(isHidden: Bool? = false, isTranslucent: Bool? = false, title: String? = "", backButtonTitle: String? = "", backgroungColor: UIColor? = UIColor.clear, backButtonImage: UIImage? = UIImage(named: "icon-back"), animated: Bool) {
        navigationController?.navigationItem.title = title
        
        navigationController?.setNavigationBarHidden(isHidden!, animated: animated)//navigationBar.isHidden = isHidden!
        navigationController?.view.backgroundColor = backgroungColor
        navigationController?.navigationBar.isTranslucent = isTranslucent!
        
        if isTranslucent! {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.view.backgroundColor = backgroungColor
        }
        
        let backButtonImageView = UIImageView(image: backButtonImage)
        
        let templateImage = backButtonImageView.image?.withRenderingMode(.alwaysTemplate)
        backButtonImageView.image = templateImage
        backButtonImageView.tintColor = CoreColor.brandHeavier.asCoreColors
        
        self.navigationController?.navigationBar.backIndicatorImage = backButtonImageView.image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImageView.image
        self.navigationController?.navigationBar.backItem?.title = backButtonTitle
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: backButtonTitle, style: .plain, target: nil, action: nil)
    }

    func showAlertSingle(_ title:String, _ message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnOK = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(btnOK)
        present(alert, animated: true, completion: nil)
    }

    func dismissToRoot(){
        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
    }

    func showLoaf(message: String, state: Loaf.State, duration:Double = 1.0 ){
        Loaf(message, state: state, location: .top, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show(.custom(duration))
    }
    
    func showLoafError(message: String ){
        Loaf(message, state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
    }

    func insertBlurBackground(style: UIBlurEffect.Style) {
        
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
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
    
    func change(backgroundColor: UIColor = .white, shadowColor: UIColor = .clear ) {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = backgroundColor
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .clear
            appearance.backgroundImage = nil
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBar.backgroundColor = backgroundColor
            
            navigationBar.layer.shadowColor = shadowColor.cgColor
            navigationBar.layer.shadowOffset = .init(width: 1, height: 0.3)
            navigationBar.layer.shadowRadius = 1.0
            navigationBar.layer.shadowOpacity = 0.5
            
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance = appearance

            navigationBar.tintColor = UIColor.white
        } else {
            navigationBar.barTintColor = backgroundColor
            navigationBar.shadowImage = UIImage()
            navigationBar.tintColor = shadowColor
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

extension UINavigationItem {
    func setBackButtonTitle(title: String) {
        let backItem = UIBarButtonItem()
        backItem.title = title
        backBarButtonItem = backItem
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.backBarButtonItem = UIBarButtonItem()
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
    
    var toImage: UIImage? { UIImage(data: self) }

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
    
    func replace(string:String, replacement:String) ->String {
        return self.replacingOccurrences(of: string, with: replacement, options: .literal)
    }
    
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

    mutating func capitalizedFirstLetter() {
        self.replaceSubrange(self.startIndex...self.startIndex, with: String(self[self.startIndex]).capitalized)
    }
    
    // exemple:  string.applyPatternOnNumbers(pattern: "(##) # ####-####", replacmentCharacter: "#")
    func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
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

    var isURLValid: Bool {

        let siteRegex = "^(http:\\/\\/www\\.|https:\\/\\/www\\.|http:\\/\\/|https:\\/\\/)?[a-z0-9]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,5}(:[0-9]{1,5})?(\\/.*)?$"
        
        let siteText = NSPredicate(format: "SELF MATCHES[c] %@", siteRegex)
        
        return siteText.evaluate(with: self.trim())

    }

    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: self)
    }

    var isValidPhoneNumber: Bool {
        let phoneNumberKit = PhoneNumberKit()
        let phoneNumber = try? phoneNumberKit.parse("+55\(self)")
        return phoneNumber != nil
    }

    var areaCode: Int? {
        let validPhoneStr = self.removePhoneCharacters
        guard (10...11).contains(validPhoneStr.count) else { return nil }
        let areaCodeEndingIndex = validPhoneStr.index(validPhoneStr.startIndex, offsetBy: 2)
        return Int(validPhoneStr[..<areaCodeEndingIndex])!
    }
    
    var phoneNumber: Int? {
        let validPhoneStr = self.removePhoneCharacters
        guard (10...11).contains(validPhoneStr.count) else { return nil }
        let areaCodeEndingIndex = validPhoneStr.index(validPhoneStr.startIndex, offsetBy: 2)
        return Int(validPhoneStr[areaCodeEndingIndex..<validPhoneStr.endIndex])!
    }
    
    var removeSpecialChars: String {
        let removeAccents = self.folding(options: .diacriticInsensitive, locale: .current)
        let badchar = CharacterSet(charactersIn: "\"[]()$,")
        return removeAccents.components(separatedBy: badchar).joined()
    }

    var eventParameter: String {
        let normalized = removeSpecialChars
        return normalized.replacingOccurrences(of: " ", with: "").lowercased()
    }
    
    var removePhoneCharacters: String {
        var returnValue = self.replacingOccurrences(of: " ", with: "")
        returnValue = returnValue.replacingOccurrences(of: "(", with: "")
        returnValue = returnValue.replacingOccurrences(of: ")", with: "")
        returnValue = returnValue.replacingOccurrences(of: "-", with: "")
        return returnValue
    }
    
    var removeZipcodeCharacters: String {
        let returnValue = self.replacingOccurrences(of: "-", with: "")
        return returnValue
    }
    
    var removeDocumentNumberCharacters: String {
        var returnValue = self.replacingOccurrences(of: ".", with: "")
        returnValue = returnValue.replacingOccurrences(of: "-", with: "")
        
        return returnValue
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    func formattedResidencePhoneNumber() -> String {
        guard let mask = try? Mask(format: "([00]) [00000]-[0000]") else { return self }
        let toText = CaretString(string: self, caretPosition: self.endIndex, caretGravity: .forward)
        return mask.apply(toText: toText).formattedText.string
    }
    
    func formattedMobilePhoneMaskNumber() -> String {
        let mobilePhoneFormatted = self.formattedResidencePhoneNumber()
        let mobilePhoneFirst = String(mobilePhoneFormatted.prefix(7))
        let mobilePhoneLast  = String(mobilePhoneFormatted.suffix(2))
        return "\(mobilePhoneFirst)*****\(mobilePhoneLast)"
    }
    
    func formattedEmailMaskNumber() -> String {
        let components = self.lowercased().components(separatedBy: "@")
        return hideMidChars(components.first!) + "@" + components.last!
    }
    
    private func hideMidChars(_ value: String) -> String {
        return String(value.enumerated().map { index, char in
            return [0, 1, value.count - 1, value.count - 2].contains(index) ? char : "*"
        })
    }
    
    var nsRange : NSRange {
        return NSRange(self.startIndex..., in: self)
    }
    
    func lowerCapitalize() -> String {
        return self.lowercased().capitalizingFirstLetter()
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
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return String(format:"#%06x", rgb)
    }
    
    static func FromHexaToColor(_ hexa:String) -> UIColor {
        
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
    
    static func FromRGBToColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
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

    func loading(_ show: Bool, activityIndicatorViewStyle: UIActivityIndicatorView.Style = .white) {
        let tag = 808404
        isEnabled = !show
        if show {
            self.alpha = 0.5
            let indicator = UIActivityIndicatorView(style: activityIndicatorViewStyle)
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth - 30, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }

    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi)
        rotation.duration = 0.5
        rotation.isCumulative = true
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}

extension UILabel {
    
    func setTitleAttributeswith(firstTitle:String, firstColor:UIColor, sizeFirstFont:CGFloat, isfirsBold:Bool, secondTitle:String, secondColor:UIColor, sizeSecondFont:CGFloat, isSecondBold:Bool){
        
        numberOfLines = 2

        let attributeText = NSMutableAttributedString(string: firstTitle, attributes: [NSAttributedString.Key.foregroundColor : firstColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: sizeFirstFont, weight: isfirsBold ? .semibold : .regular)])
        attributeText.append(NSAttributedString(string: secondTitle, attributes: [NSAttributedString.Key.foregroundColor : secondColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: sizeSecondFont, weight: isSecondBold ? .semibold : .regular)]))
        attributedText = attributeText
        
    }

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
    
    public func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
    
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

    func changeColorBorder(isOn: Bool) {
        if isOn {
            self.layer.cornerRadius = 4
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.masksToBounds = true
        }else{
            self.layer.borderWidth = 0
        }
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
   
	func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        var cornerMask = UIRectCorner()
        if(corners.contains(.topLeft)){
            cornerMask.insert(.topLeft)
        }
        if(corners.contains(.topRight)){
            cornerMask.insert(.topRight)
        }
        if(corners.contains(.bottomLeft)){
            cornerMask.insert(.bottomLeft)
        }
        if(corners.contains(.bottomRight)){
            cornerMask.insert(.bottomRight)
        }
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
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

    func toImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    func setBackgroudGradient(topColor: UIColor, bottomColor:UIColor){
        
        let gradient = CAGradientLayer()
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0,1]
        gradient.frame = frame
        layer.insertSublayer(gradient, at: 0)
        
    }

    func addSubViews(_ views: UIView...){
        for view in views {
            addSubview(view)
        }
    }
    
    func dismissKeyboard(){
        endEditing(true)
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
            trailingAnchor.constraint(equalTo: trailing, constant: value.right * (-1)).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: value.bottom * (-1)).isActive = true
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

    func  addTapGesture(action : @escaping ()->Void ){
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    @objc func handleTap(_ sender: MyTapGestureRecognizer) {
        sender.action!()
    }
    
}

class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action : (()->Void)? = nil
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

    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
        
        return localDate
    }
    
    func getDateToString(_ pattern:String) -> String {
        
        let datePattern = DateFormatter()
        datePattern.dateFormat = pattern
        return datePattern.string(from: self)
        
    }
    
    func toRelativeString() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let today = Date()
        return formatter.localizedString(for: self, relativeTo: today)
    }

    func nameOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "pt-BR") as Locale
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: self)
        return dayInWeek
    }
    
    func nextDayUtil() -> Date {
        
        var dateUtil = self
        let calendar = Calendar(identifier: .gregorian)
        while calendar.isDateInWeekend(self) {
            dateUtil = calendar.date(byAdding: .day, value: 1, to: self)!
        }
        return dateUtil
        
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

    func setImageAvatar(withURL url: URL?,  borderColor: UIColor, borderWidth: Int = 2) {
        self.layer.cornerRadius = (self.frame.size.width) / 2
        self.clipsToBounds = true
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = borderColor.cgColor
        
        guard let url = url else { return }
        self.af_setImage(withURL: url)
    }
    
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 2
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
}

extension UIImage {
    
    var jpegData: Data? { jpegData(compressionQuality: 1) }  // QUALITY min = 0 / max = 1
    var pngData: Data? { pngData() } 

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

extension URLRequest {
    public var description: String{
        get{
            return "HEADER: \n \(String(describing: allHTTPHeaderFields)) \n BODY: \n \(String(decoding: httpBody ?? Data(), as: UTF8.self))"
        }
    }
}

extension UIAlertController {
    
    var messageTitleTextColor: UIColor? {
        set{
            self.setValue(NSAttributedString(string: self.title ?? "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
        } get {
            return self.value(forKey: "attributedTitle") as? UIColor
        }
    }
    
    var messageTextColor: UIColor? {
        set{
            self.setValue(NSAttributedString(string: self.message ?? "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedMessage")
        } get {
            return self.value(forKey: "attributedMessage") as? UIColor
        }
    }
    
}