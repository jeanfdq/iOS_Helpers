
import UIKit
import MapKit

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
    
    func isEmailValid() -> Bool {
        
        let regexEmail = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailText = NSPredicate(format: "SELF MATCHES[c] %@", regexEmail)
        
        return emailText.evaluate(with: self.trim())
        
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
        
        if hexa.count != 6 {
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
    
    func applyViewIntoSuperView(){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        leadingAnchor.constraint(equalTo: superview?.leadingAnchor ?? NSLayoutXAxisAnchor()).isActive = true
        topAnchor.constraint(equalTo: superview?.topAnchor ?? NSLayoutYAxisAnchor()).isActive = true
        trailingAnchor.constraint(equalTo: superview?.trailingAnchor ?? NSLayoutXAxisAnchor()).isActive = true
        bottomAnchor.constraint(equalTo: superview?.bottomAnchor ?? NSLayoutYAxisAnchor()).isActive = true
        
    }
    
    func applyViewConstraints(_ leading: NSLayoutXAxisAnchor?, _ top:NSLayoutYAxisAnchor?, _ trailing:NSLayoutXAxisAnchor?, _ bottom:NSLayoutYAxisAnchor?, size:CGSize = .zero, value:UIEdgeInsets = .zero ){
        
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

extension UIAlertAction {
    
    func setTitleColor(color:UIColor){
        
        self.setValue(color, forKey: "titleTextColor")
        
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

extension CLLocation {
    
    func getDistanceToString(_ locationDest:CLLocation) -> String {
        
        let distance = self.distance(from: locationDest) / 1000
        var distanceDecimal = distance.roundDecimal(3)
        var unidademedida = "Km"
        if distanceDecimal < 1{
            distanceDecimal *= 1000
            unidademedida = "M"
        }else{
            distanceDecimal = distanceDecimal.roundDecimal(0)
        }
        
        return "\(distanceDecimal) \(unidademedida)"
        
    }
    
    func getDistanceToMeter(_ locationDest:CLLocation) -> Double {
        
        let distance = self.distance(from: locationDest) / 1000
        return Double(distance).roundDecimal(3)
        
    }
    
}

extension UIImageView {
    
    func setNewHeightWidth(newW:CGFloat) -> CGSize {
        
        let nh = (frame.size.height * newW) / frame.size.width
        
        return CGSize(width: newW, height: nh)
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
