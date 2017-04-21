//
//  Extensions.swift
//  nyk
//
//  Created by Elaine Chong on 6/25/15.
//  Copyright (c) 2015 BuzzElement. All rights reserved.
//

import BoltsSwift
import CoreData
import Foundation
import RealmSwift
import SDWebImage
import DateTools

extension Int {
    var toUIColor: UIColor {
        let r = (CGFloat)(((self & 0xFF0000) >> 16)) / 255.0
        let g = (CGFloat)(((self & 0x00FF00) >> 08)) / 255.0
        let b = (CGFloat)(((self & 0x0000FF) >> 00)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    var formatAsDuration: String {
        let seconds = self % 60
        let minutes = (self / 60) % 60
        let hours = self / 3600
        let secondsStringFormat = String(format: "%02d", seconds)
        let minutesStringFormat = String(format: "%02d", minutes)
        let hoursStringFormat = String(format: "%02d", hours)
        return "\(hoursStringFormat):\(minutesStringFormat):\(secondsStringFormat)"
    }
    var toTimeDate:Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
    var toRankString:String {
        if (self >= 11 && self <= 13) {
            return String(self) + "th"
        }
        switch (self % 10) {
        case 1:
            return String(self) + "st"
        case 2:
            return String(self) + "nd"
        case 3:
            return String(self) + "rd"
        default:
            return String(self) + "th"
        }
    }
}
extension Data {
    var contentTypeForImageData: String {

        var c: UInt8! = UInt8()
        (self as NSData).getBytes(&c, length: 1)

        switch c {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x49, 0x4D:
            return "image/tif"
        default: return ""
        }
    }
    
    var hexString: String {
        return map { String(format: "%02.2hhx", arguments: [$0]) }.joined()
    }

}

extension Date {
    var prettyTimeAgo: String {
        return (self as NSDate).timeAgoSinceNow()
    }

    var prettyDateTime: String {
        return self.prettyTime + ", " + self.prettyDate
    }

    var prettyDate: String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("ddMMyyyy")
        return formatter.string(from: self)
    }
    
    var prettyDate2: String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("ddMMMyyyy")
        return formatter.string(from: self)
    }

    var prettyTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        return formatter.string(from: self)
    }

    var toHeaderTime: String {
        if (self as NSDate).isToday() {
            return "c_today".localize
        } else if (self as NSDate).isYesterday() {
            return "c_yesterday".localize
        }
        return self.prettyDate
    }

    var toPrettyTimeAgoOrDateTime: String {
        let now : Date = Date()
        if self.compare(now) == ComparisonResult.orderedAscending {
            if (self as NSDate).isToday() == false {
                return self.prettyTime
            }
            return self.prettyTimeAgo
        }
        return self.prettyTime
    }

    func isSameDateWith(date: Date) -> Bool {
        let calendar = Calendar.current
        if (calendar as NSCalendar).compare(self, to: date, toUnitGranularity: .day) == ComparisonResult.orderedSame {
            return true
        }
        return false
    }

    var firstDayOfTheMonth: Date! {
        return  Calendar.current.date(from: (Calendar.current as NSCalendar).components([.year,.month], from: self))
    }

    var toMonthYearString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM YYYY"
        return dateFormatter.string(from: self)
    }

}

extension String {

    var pathExtension: String {
        return (self as NSString).pathExtension
    }

    var stringByDeletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    var isValidPhoneNumber: Bool {
        let regex = "^((\\+)|(00)|(\\*)|())[0-9]{3,14}((\\#)|())$"
        let predi = NSPredicate(format: "SELF MATCHES %@", regex)
        return predi.evaluate(with: self) as Bool
    }

    var isValidVerificationCode: Bool {
        return (self.characters.count == 4)
    }

    var halfwidth: String {
        let mutableString = NSMutableString(string: self) as CFMutableString
        CFStringTransform(mutableString, nil, kCFStringTransformFullwidthHalfwidth, false)
        return mutableString as String
    }

    var localize: String {
        return NSLocalizedString(self, comment: "")
    }

    func localizeWithLang(_ lang: String) -> String {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        var bundle: Bundle?
        if path != nil {
            bundle = Bundle(path: path!)
        } else {
            bundle = Bundle.main
            print("Warning: No lproj for \(lang), system default set instead !")
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }

    var description: String {
        return NSLocalizedString(self, tableName: "Descriptions", comment: "")
    }
    
    var imageName: String {
        return NSLocalizedString(self, tableName: "ImageName", comment: "")
    }
    
    var infoPlistString: String {
        return NSLocalizedString(self, tableName: "InfoPlist", comment: "")
    }

    func sizeOfTextInView(widthOfView: CGFloat, font: UIFont) -> CGRect {
        let constraintRect = CGSize(width: widthOfView, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [NSFontAttributeName: font]
        return self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes:attributes, context: nil)
    }

    func replaceWithString(_ replacedString: String) -> String {
        if self.isEmpty {
            return ""
        }
        let objcString = self as NSString
        return objcString.replacingCharacters(in: NSMakeRange(0, replacedString.characters.count), with: replacedString)
    }

    subscript (i: Int) -> Character? {
        let count = self.characters.count
        if i < 0 || i >= count{
            return nil
        }else{
            return self[self.characters.index(self.startIndex, offsetBy: i)]
        }
    }

    subscript (i: Int) -> String {
        let character : Character? = self[i]
        if let ch = character{
            return String(ch)
        }else{
            return ""
        }
    }

    subscript (r: CountableClosedRange<Int>) -> String {
        let count = self.characters.count
        let firstIndex : Int = r.lowerBound
        let secondIndex : Int = r.upperBound
        if (firstIndex < 0) || (secondIndex >= count) {
            return ""
        } else {
            return substring(with: Range(characters.index(startIndex, offsetBy: firstIndex) ..< characters.index(startIndex, offsetBy: secondIndex)))
        }
    }

    func optimalHeight(_ sizeWidth: CGFloat, font: UIFont) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: sizeWidth, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self

        label.sizeToFit()

        return label.frame.height
    }
}

extension UIView {
    
    func roundCorner() {
        roundCorner(UIColor.clear, borderWidth: 0.0)
    }
    
    func roundCorner(_ borderColor: UIColor, borderWidth: Float) {
        self.roundCorner(borderColor, borderWidth: borderWidth, cornerRadius: self.bounds.size.height / 2)
    }
    
    func roundCornerAndDropshadow(_ borderColor: UIColor, borderWidth: Float) {
        self.roundCornerAndDropshadow(borderColor, borderWidth: borderWidth, cornerRadius: self.bounds.size.height / 2)
    }
    
    func roundCornerAndDropshadow(_ borderColor: UIColor, borderWidth: Float, cornerRadius: CGFloat) {
        self.layer.cornerRadius  = cornerRadius
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.borderColor = borderColor.cgColor
    }

    func roundCorner(_ borderColor: UIColor, borderWidth: Float, cornerRadius: CGFloat) {
        self.layer.cornerRadius  = cornerRadius
        self.layer.borderWidth   = CGFloat(borderWidth)
        self.layer.borderColor   = borderColor.cgColor
        self.layer.masksToBounds = true
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    func roundCornerForWrapperView(_ borderColor: UIColor) {
        self.roundCorner(borderColor, borderWidth: 1.0, cornerRadius: 5.0)
    }
    
    func roundCornerForPanel(_ borderColor: UIColor = UIColor.clear) {
        self.roundCorner(borderColor, borderWidth: 1.0, cornerRadius: 10.0)
    }
    
    func cardUi() {
        self.layer.shadowOffset = CGSize(width: -0.2, height: 0.2)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    func dropShadowAtBottom() {
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func dropShadowAtTop() {
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 2.0, height: 0.0)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func cardBezzedUi() {
        self.layer.cornerRadius = 5.0
        self.layer.shadowOffset = CGSize(width: -0.7, height: 0.7)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func cardBezzedUi2() {
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize(width: -0.7, height: 0.7)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    func addMatchParentConstraintForSubview(_ subview: UIView) {
        self.addConstraint(NSLayoutConstraint(item: subview, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: subview, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: subview, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: subview, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
    }
    
    func addGradientLayer() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [0xF9E0E0.toUIColor.cgColor, 0x9FB4CE.toUIColor.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.1, y: 0.1)
        gradient.endPoint = CGPoint(x: 0.9, y: 0.9)
        gradient.frame = self.bounds
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                if layer.isKind(of: CAGradientLayer.self) {
                    layer.removeFromSuperlayer()
                }
            }
        }
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}

extension UILabel {
    func noTruncation() {
        self.setContentCompressionResistancePriority(250, for: .horizontal)
    }
    var optimalHeight : CGFloat {
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = self.lineBreakMode
            label.font = self.font
            label.text = self.text

            label.sizeToFit()

            return label.frame.height
        }
    }
}

extension UIImage {
    func applyBlurEffect() -> UIImage {
        let blurLevel: CGFloat = 8.0
        let context = CIContext(options: nil)
        let imageToBlur = CoreImage.CIImage(image: self)
        let blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter!.setValue(imageToBlur, forKey: "inputImage")
        blurfilter!.setValue(blurLevel, forKey: "inputRadius")
        let resultImage = blurfilter!.value(forKey: "outputImage") as! CoreImage.CIImage
        var originalRect: CGRect = resultImage.extent
        let deltaX = 0 - originalRect.origin.x
        let deltaY = 0 - originalRect.origin.y
        originalRect.origin.x = 0
        originalRect.origin.y = 0
        originalRect.size.height -= deltaY*2
        originalRect.size.width -= deltaX*2
        let cgImage = context.createCGImage(resultImage, from: originalRect)
        return UIImage(cgImage: cgImage!)
    }

    func imageScaledToFitSize(_ size: CGSize) -> UIImage {
        // calculate rect
        let aspect = self.size.width / self.size.height
        if size.width / aspect <= size.height {
            return self.imageScaledToSize(CGSize(width: size.width, height: size.width / aspect))
        } else {
            return self.imageScaledToSize(CGSize(width: size.height * aspect, height: size.height))
        }
    }

    func imageScaledToSize(_ size: CGSize) -> UIImage {
        // create drawing context
        UIGraphicsBeginImageContext(size)

        // draw
        self.draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))

        // capture resultant image
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()

        // return image
        return image!
    }

    func drawInRectAspectFill(_ viewSize: CGRect) {
        let hfactor = self.size.width / viewSize.width
        let vfactor = self.size.height / viewSize.height
        let factor = fmax(hfactor, vfactor)
        let newWidth = self.size.width / factor
        let newHeight = self.size.height / factor
        let xOffset = (viewSize.width - newWidth) / 2
        let yOffset = (viewSize.height - newHeight) / 2
        let newRect = CGRect(x: xOffset, y: yOffset, width: newWidth, height: newHeight)
        self.draw(in: newRect)
    }

    func rotateCameraImageToProperOrientation() -> UIImage {
        let imgRef = self.cgImage

        let width = CGFloat(imgRef!.width)
        let height = CGFloat(imgRef!.height)

        var bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let scaleRatio : CGFloat = 1

        var transform = CGAffineTransform.identity
        let orient = self.imageOrientation
        let imageSize = CGSize(width: CGFloat(imgRef!.width), height: CGFloat(imgRef!.height))

        switch self.imageOrientation {
        case .up :
            transform = CGAffineTransform.identity
        case .upMirrored :
            transform = CGAffineTransform(translationX: imageSize.width, y: 0.0)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
        case .down :
            transform = CGAffineTransform(translationX: imageSize.width, y: imageSize.height)
            transform = transform.rotated(by: CGFloat(M_PI))
        case .downMirrored :
            transform = CGAffineTransform(translationX: 0.0, y: imageSize.height)
            transform = transform.scaledBy(x: 1.0, y: -1.0)
        case .left :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = storedHeight
            transform = CGAffineTransform(translationX: 0.0, y: imageSize.width)
            transform = transform.rotated(by: 3.0 * CGFloat(M_PI) / 2.0)
        case .leftMirrored :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = storedHeight
            transform = CGAffineTransform(translationX: imageSize.height, y: imageSize.width)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
            transform = transform.rotated(by: 3.0 * CGFloat(M_PI) / 2.0)
        case .right :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = storedHeight
            transform = CGAffineTransform(translationX: imageSize.height, y: 0.0)
            transform = transform.rotated(by: CGFloat(M_PI) / 2.0)
        case .rightMirrored :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = storedHeight
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            transform = transform.rotated(by: CGFloat(M_PI) / 2.0)
        }

        UIGraphicsBeginImageContext(bounds.size)
        let context = UIGraphicsGetCurrentContext()

        if orient == .right || orient == .left {
            context!.scaleBy(x: -scaleRatio, y: scaleRatio)
            context!.translateBy(x: -height, y: 0)
        } else {
            context!.scaleBy(x: scaleRatio, y: -scaleRatio)
            context!.translateBy(x: 0, y: -height)
        }

        context!.concatenate(transform)
        UIGraphicsGetCurrentContext()!.draw(imgRef!, in: CGRect(x: 0, y: 0, width: width, height: height))

        let imageCopy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return imageCopy!
    }

    func cropImageInSquare() -> UIImage {
        var trimmed:UIImage!
        if self.size.width > self.size.height {
            trimmed = self.trim(CGRect(
                x: (self.size.width - self.size.height) / 2,
                y: 0,
                width: self.size.height,
                height: self.size.height))
        } else {
            trimmed = self.trim(CGRect(
                x: 0,
                y: (self.size.height - self.size.width) / 2,
                width: self.size.width,
                height: self.size.width))
        }
        return trimmed.resize(CGSize(width: 256, height: 256))
    }

    func trim(_ rect: CGRect) -> UIImage {
        let scaled_rect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: rect.size.height)
        let clip = self.cgImage!.cropping(to: scaled_rect)
        let trimed_image = UIImage(cgImage: clip!, scale: 1, orientation: UIImageOrientation.up)
        return trimed_image
    }

    func resize(_ size: CGSize) -> UIImage {
        let width_ratio  = CGFloat(size.width  / self.size.width)
        let height_ratio = CGFloat(size.height / self.size.height)
        _ = CGFloat((width_ratio < height_ratio) ? width_ratio : height_ratio)
        let resized_size = CGSize(width: self.size.width * width_ratio, height: self.size.height * height_ratio)
        UIGraphicsBeginImageContext(resized_size)
        self.draw(in: CGRect(x: 0, y: 0, width: resized_size.width, height: resized_size.height))
        let resized_image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resized_image!
    }

}

extension UIImageView {
    func loadImageFromUrl(_ url: String) {
        self.sd_setImage(with: URL(string: url))
    }

    func loadImageFromUrl(_ url: String, placeholderImage placeholder: UIImage!) {
        self.sd_setImage(with: URL(string: url), placeholderImage: placeholder)
    }
    
    func loadImageWithIndicatorFromUrl(_ url: String, placeholderImage: UIImage? = nil, completion: ((_ image: UIImage?, _ success: Bool) -> Void)? = nil) {
        self.setShowActivityIndicator(true)
        self.setIndicatorStyle(UIActivityIndicatorViewStyle.gray)
        if completion != nil {
            let completedHandler: SDWebImageCompletionBlock = { (image: UIImage?, error: Error?, cacheType: SDImageCacheType, requestURL: URL?) in
                SDImageCache.shared().store(self.image, forKey: url)
                if completion != nil {
                    completion!(image, error == nil)
                }
            }
            if placeholderImage != nil {
                self.sd_setImage(with: URL(string: url), placeholderImage: placeholderImage!, options: [], completed: completedHandler)
            } else {
                self.sd_setImage(with: URL(string: url), completed: completedHandler)
            }
        } else {
            if placeholderImage != nil {
                self.loadImageFromUrl(url, placeholderImage: placeholderImage!)
            } else {
                self.loadImageFromUrl(url)
            }
        }
    }

    func applyBlurEffect() {
        if let image = self.image {
            self.image = image.applyBlurEffect()
        }
    }

    func loadImageWithIndicatorFromUrlAndApplyBlurEffect(_ url: String, completed: (()->())?) {
        if let imageCache: UIImage = SDImageCache.shared().imageFromDiskCache(forKey: url) {
            self.image = imageCache
            if completed != nil {
                completed!()
            }
        } else {
            self.setShowActivityIndicator(true)
            self.setIndicatorStyle(UIActivityIndicatorViewStyle.gray)
            self.sd_setImage(with: URL(string: url), completed: {
                (image, error, cacheType, url1) in
                self.applyBlurEffect()
                SDImageCache.shared().store(self.image, forKey: url)
                if completed != nil {
                    completed!()
                }
            })
        }
    }

    func applyBlurEffectAndCacheImage(_ image: UIImage!, imageId: String!) {
        if image != nil {
            if let imageCache: UIImage = CacheManager.getCachedImage(imageId: imageId) {
                self.image = imageCache
            } else {
                self.image = image.applyBlurEffect()
                CacheManager.cacheImage(self.image, imageId: imageId)
            }
        }
    }

    func applyBlurEffectAndCacheDefaultBackGroundImage(_ image: UIImage!) {
        if image != nil {
            if let imageCache: UIImage = CacheManager.getCachedBackGroundImage() {
                self.image = imageCache
            } else {
                self.image = image.applyBlurEffect()
                CacheManager.cacheBackGroundImage(self.image)
            }
        }
    }
}

extension UIColor {
    var toUIImage: UIImage {
        let size = CGSize(width: 10, height: 10)
        UIGraphicsBeginImageContext(size)

        let rect = CGRect(origin: CGPoint.zero, size: size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image!
    }
}

extension Results {
    func toArray<T>(_ ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}

extension UINavigationController {
    open override var shouldAutorotate : Bool {
        var shouldAutorotate = false
        if visibleViewController != nil && !(visibleViewController?.isKind(of: UIAlertController.self))!{
            shouldAutorotate = visibleViewController!.shouldAutorotate
        }
        return shouldAutorotate
    }
    
    open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if visibleViewController != nil {
            return visibleViewController!.supportedInterfaceOrientations
        }
        return super.supportedInterfaceOrientations
    }
}

extension UIAlertController {

    open override var shouldAutorotate : Bool {
        return false
    }

    open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
}

extension NSObject {
    
    func parseDoubleFrom(_ data: AnyObject?, defaultValue: Double = 0) -> Double {
        return (data as? Double) ?? (data as? NSString)?.doubleValue ?? defaultValue
    }
    
    func parseIntFrom(_ data: AnyObject?, defaultValue: Int = 0) -> Int {
        if let value = data as? Int {
            return value
        } else {
            return defaultValue
        }
    }
    
    func parseStringFrom(_ data: AnyObject?, defaultValue: String = "") -> String {
        if let value = data as? String, value != "" {
            return value
        } else {
            return defaultValue
        }
    }
    
    func parseFloatFrom(_ data: AnyObject?, defaultValue: Float = 0) -> Float {
        if let value = data as? Float {
            return value
        } else {
            return defaultValue
        }
    }
    
    func parseBoolFrom(_ data: AnyObject?, defaultValue: Bool = false) -> Bool {
        if let value = data as? Bool {
            return value
        } else {
            return defaultValue
        }
    }
    
    func parseDictFrom(_ data: AnyObject? , defaultValue: Dictionary<String, AnyObject>? = nil) -> Dictionary<String, AnyObject>? {
        if let value = data as? Dictionary<String, AnyObject> {
            return value
        } else {
            return defaultValue
        }
    }
    
    func parseDictArrayFrom(_ data: AnyObject? , defaultValue: [Dictionary<String, AnyObject>]? = nil) -> [Dictionary<String, AnyObject>]? {
        if let value = data as? [Dictionary<String, AnyObject>] {
            return value
        } else {
            return defaultValue
        }
    }
    
    func getLocalizedMessageAndTitleFromObject(_ data: Dictionary<NSObject, AnyObject>) -> [String?] {
        let localizedCode = self.getLanguageCode()
        var message = data["message_\(localizedCode)" as NSObject] as? String
        var title = data["title_\(localizedCode)" as NSObject] as? String
        if message == nil {
            message = data["message" as NSObject] as? String
        }
        if title == nil {
            title = data["title" as NSObject] as? String
        }
        return [message, title]
    }
    
    func getLocalizedMessageFromObject(_ data: Dictionary<NSObject, AnyObject>) -> String? {
        return data["message_\(self.getLanguageCode())" as NSObject] as? String
    }
    
    func getLanguageCode() -> String {
        if let languageCode = (Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode) as? String {
            return languageCode.lowercased()
        }
        return "en"
    }
    
    func getLanguageCodeDisplayName() -> String {
        if let displayName = (Locale.current as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: self.getLanguageCode()) {
            return displayName
        }
        return "N/A"
    }
    
    func getRegionCode() -> String {
        if let regionCode = (Locale.current as NSLocale).object(forKey: NSLocale.Key.identifier) as? String {
            return regionCode
        }
        return "N/A"
    }
    
    func callNumber(_ phoneNumber:String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber.replacingOccurrences(of: " ", with: ""))") {
            let application = UIApplication.shared
            if application.canOpenURL(phoneCallURL) {
                application.openURL(phoneCallURL)
            }
        }
    }
    
}
