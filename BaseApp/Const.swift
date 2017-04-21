/**
 Const.swift
 created by D.ace on 21/04/2017
 */
import CoreGraphics
import UIKit

class Const: NSObject {

    // width and height of screen
    static var widthScreen: CGFloat = UIScreen.main.bounds.size.width
    static var heighScreen: CGFloat = UIScreen.main.bounds.size.height

    class var colorBlack: UIColor {
        return 0x030303.toUIColor
    }
    class var colorTextBlack: UIColor {
        return 0x252525.toUIColor
    }
    class var colorTextGray: UIColor {
        return 0x525252.toUIColor
    }
    class var colorWhite: UIColor {
        return 0xffffff.toUIColor
    }
    class var colorGrey: UIColor {
        return 0x878787.toUIColor
    }
    class var colorLightGrey: UIColor {
        return 0xEAEAEA.toUIColor
    }
    class var colorLightGrey2: UIColor {
        return 0xCACACA.toUIColor
    }
    class var colorBlue: UIColor {
        return 0x00A2F7.toUIColor
    }
    class var colorLightBlue: UIColor {
        return 0x8ECDFF.toUIColor
    }
    class var colorRed: UIColor {
        return 0xFF0044.toUIColor
    }
    class var colorRedDark: UIColor {
        return 0xBD1942.toUIColor
    }
    class var colorGreen: UIColor {
        return 0x04AA5C.toUIColor
    }
    class var colorGreenDark: UIColor {
        return 0x00BB3A.toUIColor
    }
    class var colorYellow: UIColor {
        return 0xF1C40F.toUIColor
    }
    class var colorYellowDark: UIColor {
        return 0xB3A500.toUIColor
    }
    class var colorBlueDark: UIColor {
        return 0x0077B3.toUIColor
    }
    class var colorAssignmentBlue: UIColor {
        return 0x3EAFFF.toUIColor
    }
    class var colorDisabledButton: UIColor {
        return 0xCACACA.toUIColor
    }
    class var colorOrange: UIColor {
        return 0xFF8000.toUIColor
    }
    class var colorFinishBackground: UIColor {
        return 0xE7E7E7.toUIColor
    }
    class var colorGreenFinish: UIColor {
        return 0x04AA5C.toUIColor
    }
    class var colorTextLight: UIColor {
        return 0x979797.toUIColor
    }
    class var colorGreenOdoMeter: UIColor {
        return 0x02C067.toUIColor
    }
    class var colorGreenOdoMeter00D873: UIColor {
        return 0x00D873.toUIColor
    }
    class var colorYellowOdoMeterFBD640: UIColor {
        return 0xFBD640.toUIColor
    }
    class var colorRedOdoMeter: UIColor {
        return 0xFF0044.toUIColor
    }
    class var colorBackgroundLightGray: UIColor {
        return 0xF3F3F3.toUIColor
    }
    class var colorBackgroundChartView: UIColor {
        return 0x424243.toUIColor
    }
    class var colorTextChartView: UIColor {
        return 0xB6B6B6.toUIColor
    }
    class var color1stRank: UIColor {
        return 0xFFBA25.toUIColor
    }
    class var color2ndRank: UIColor {
        return 0x16D3ED.toUIColor
    }
    class var color3rdRank: UIColor {
        return 0x22E69F.toUIColor
    }
    class var colorGreenGenderSelected: UIColor {
        return 0x4CD964.toUIColor
    }
    class var colorGreyGenderUnSelect: UIColor {
        return 0xAAAAAA.toUIColor
    }
    class var colorGreyB3B3B3: UIColor {
        return 0xB3B3B3.toUIColor
    }
    class var colorIndicatorTint1: UIColor {
        return 0xE0E0E0.toUIColor
    }
    class var colorIndicatorCurrentPageTint1: UIColor {
        return 0x9E9E9E.toUIColor
    }
    class var colorIndicatorTint2: UIColor {
        return 0xBDBDBD.toUIColor
    }
    class var colorIndicatorCurrentPageTint2: UIColor {
        return 0xFFFFFF.toUIColor
    }
    // MARK:- Grey
    class var colorGrey50: UIColor {
        return 0xFAFAFA.toUIColor
    }
    class var colorGrey100: UIColor {
        return 0xF5F5F5.toUIColor
    }
    class var colorGrey200: UIColor {
        return 0xEEEEEE.toUIColor
    }
    class var colorGrey300: UIColor {
        return 0xE0E0E0.toUIColor
    }
    class var colorGrey400: UIColor {
        return 0xBDBDBD.toUIColor
    }
    class var colorGrey500: UIColor {
        return 0x9E9E9E.toUIColor
    }
    class var colorGrey600: UIColor {
        return 0x757575.toUIColor
    }
    class var colorGrey700: UIColor {
        return 0x616161.toUIColor
    }
    class var colorGrey800: UIColor {
        return 0x424242.toUIColor
    }
    class var colorGrey900: UIColor {
        return 0x212121.toUIColor
    }
    // MARK:- Yellow
    class var colorYellow50: UIColor {
        return 0xFFFDE7.toUIColor
    }
    class var colorYellow100: UIColor {
        return 0xFFF9C4.toUIColor
    }
    class var colorYellow200: UIColor {
        return 0xFFF59D.toUIColor
    }
    class var colorYellow300: UIColor {
        return 0xFFF176.toUIColor
    }
    class var colorYellow400: UIColor {
        return 0xFFEE58.toUIColor
    }
    class var colorYellow500: UIColor {
        return 0xFFEB3B.toUIColor
    }
    class var colorYellow600: UIColor {
        return 0xFDD835.toUIColor
    }
    class var colorYellow700: UIColor {
        return 0xFBC02D.toUIColor
    }
    class var colorYellow800: UIColor {
        return 0xF9A825.toUIColor
    }
    class var colorYellow900: UIColor {
        return 0xF57F17.toUIColor
    }
    // MARK:- Teal
    class var colorTeal50: UIColor {
        return 0xE0F2F1.toUIColor
    }
    class var colorTeal100: UIColor {
        return 0xB2DFDB.toUIColor
    }
    class var colorTeal200: UIColor {
        return 0x80CBC4.toUIColor
    }
    class var colorTeal300: UIColor {
        return 0x4DB6AC.toUIColor
    }
    class var colorTeal400: UIColor {
        return 0x26A69A.toUIColor
    }
    class var colorTeal500: UIColor {
        return 0x009688.toUIColor
    }
    class var colorTeal600: UIColor {
        return 0x00897B.toUIColor
    }
    class var colorTeal700: UIColor {
        return 0x00796B.toUIColor
    }
    class var colorTeal800: UIColor {
        return 0x00695C.toUIColor
    }
    class var colorTeal900: UIColor {
        return 0x004D40.toUIColor
    }
    // MARK:- Deep Purple
    class var colorDeepPurple50: UIColor {
        return 0xEDE7F6.toUIColor
    }
    class var colorDeepPurple100: UIColor {
        return 0xD1C4E9.toUIColor
    }
    class var colorDeepPurple200: UIColor {
        return 0xB39DDB.toUIColor
    }
    class var colorDeepPurple300: UIColor {
        return 0x9575CD.toUIColor
    }
    class var colorDeepPurple400: UIColor {
        return 0x7E57C2.toUIColor
    }
    class var colorDeepPurple500: UIColor {
        return 0x673AB7.toUIColor
    }
    class var colorDeepPurple600: UIColor {
        return 0x5E35B1.toUIColor
    }
    class var colorDeepPurple700: UIColor {
        return 0x512DA8.toUIColor
    }
    class var colorDeepPurple800: UIColor {
        return 0x4527A0.toUIColor
    }
    class var colorDeepPurple900: UIColor {
        return 0x311B92.toUIColor
    }
    class var colorPurple500: UIColor {
        return 0x9C27B0.toUIColor
    }
    // MARK:- Light Blue
    class var colorLightBlue50: UIColor {
        return 0xE1F5FE.toUIColor
    }
    class var colorLightBlue100: UIColor {
        return 0xB3E5FC.toUIColor
    }
    class var colorLightBlue200: UIColor {
        return 0x81D4FA.toUIColor
    }
    class var colorLightBlue300: UIColor {
        return 0x4FC3F7.toUIColor
    }
    class var colorLightBlue400: UIColor {
        return 0x29B6F6.toUIColor
    }
    class var colorLightBlue500: UIColor {
        return 0x03A9F4.toUIColor
    }
    class var colorLightBlue600: UIColor {
        return 0x039BE5.toUIColor
    }
    class var colorLightBlue700: UIColor {
        return 0x0288D1.toUIColor
    }
    class var colorLightBlue800: UIColor {
        return 0x0277BD.toUIColor
    }
    class var colorLightBlue900: UIColor {
        return 0x01579B.toUIColor
    }
    // MARK:- Amber
    class var colorAmber50: UIColor {
        return 0xFFF8E1.toUIColor
    }
    class var colorAmber100: UIColor {
        return 0xFFECB3.toUIColor
    }
    class var colorAmber200: UIColor {
        return 0xFFE082.toUIColor
    }
    class var colorAmber300: UIColor {
        return 0xFFD54F.toUIColor
    }
    class var colorAmber400: UIColor {
        return 0xFFCA28.toUIColor
    }
    class var colorAmber500: UIColor {
        return 0xFFC107.toUIColor
    }
    class var colorAmber600: UIColor {
        return 0xFFB300.toUIColor
    }
    class var colorAmber700: UIColor {
        return 0xFFCA28.toUIColor
    }
    class var colorAmber800: UIColor {
        return 0xFFA000.toUIColor
    }
    class var colorAmber900: UIColor {
        return 0xFF6F00.toUIColor
    }
    class var colorAmberA100: UIColor {
        return 0xFFE57F.toUIColor
    }
    class var colorAmberA200: UIColor {
        return 0xFFCA28.toUIColor
    }
    class var colorAmberA400: UIColor {
        return 0xFFD740.toUIColor
    }
    class var colorAmberA700: UIColor {
        return 0xFFAB00.toUIColor
    }
    // MARK:- Green
    class var colorGreen50: UIColor {
        return 0xE8F5E9.toUIColor
    }
    class var colorGreen100: UIColor {
        return 0xC8E6C9.toUIColor
    }
    class var colorGreen200: UIColor {
        return 0xA5D6A7.toUIColor
    }
    class var colorGreen300: UIColor {
        return 0x81C784.toUIColor
    }
    class var colorGreen400: UIColor {
        return 0x66BB6A.toUIColor
    }
    class var colorGreen500: UIColor {
        return 0x4CAF50.toUIColor
    }
    class var colorGreen600: UIColor {
        return 0x43A047.toUIColor
    }
    class var colorGreen700: UIColor {
        return 0x388E3C.toUIColor
    }
    class var colorGreen800: UIColor {
        return 0x2E7D32.toUIColor
    }
    class var colorGreen900: UIColor {
        return 0x1B5E20.toUIColor
    }
    // MARK:- Cyan
    class var colorCyan50: UIColor {
        return 0xE0F7FA.toUIColor
    }
    class var colorCyan100: UIColor {
        return 0xB2EBF2.toUIColor
    }
    class var colorCyan200: UIColor {
        return 0x80DEEA.toUIColor
    }
    class var colorCyan300: UIColor {
        return 0x4DD0E1.toUIColor
    }
    class var colorCyan400: UIColor {
        return 0x26C6DA.toUIColor
    }
    class var colorCyan500: UIColor {
        return 0x00BCD4.toUIColor
    }
    class var colorCyan600: UIColor {
        return 0x00ACC1.toUIColor
    }
    class var colorCyan700: UIColor {
        return 0x0097A7.toUIColor
    }
    class var colorCyan800: UIColor {
        return 0x00838F.toUIColor
    }
    class var colorCyan900: UIColor {
        return 0x006064.toUIColor
    }
    class var colorCyanA100: UIColor {
        return 0x84FFFF.toUIColor
    }
    class var colorCyanA200: UIColor {
        return 0x18FFFF.toUIColor
    }
    class var colorCyanA300: UIColor {
        return 0x00BCD4.toUIColor
    }
    class var colorCyanA400: UIColor {
        return 0x00E5FF.toUIColor
    }
    class var colorCyanA700: UIColor {
        return 0x00B8D4.toUIColor
    }
    // MARK:- Pink
    class var colorPink50: UIColor {
        return 0xFCE4EC.toUIColor
    }
    class var colorPink100: UIColor {
        return 0xF8BBD0.toUIColor
    }
    class var colorPink200: UIColor {
        return 0xF48FB1.toUIColor
    }
    class var colorPink300: UIColor {
        return 0xF06292.toUIColor
    }
    class var colorPink400: UIColor {
        return 0xEC407A.toUIColor
    }
    class var colorPink500: UIColor {
        return 0xE91E63.toUIColor
    }
    class var colorPink600: UIColor {
        return 0xD81B60.toUIColor
    }
    class var colorPink700: UIColor {
        return 0xC2185B.toUIColor
    }
    class var colorPink800: UIColor {
        return 0xAD1457.toUIColor
    }
    class var colorPink900: UIColor {
        return 0x880E4F.toUIColor
    }
    class var colorPinkA100: UIColor {
        return 0xFF80AB.toUIColor
    }
    class var colorPinkA200: UIColor {
        return 0xFF4081.toUIColor
    }
    class var colorPinkA400: UIColor {
        return 0xF50057.toUIColor
    }
    class var colorPinkA700: UIColor {
        return 0xC51162.toUIColor
    }
    // MARK:- Light Green
    class var colorLightGreen50: UIColor {
        return 0xF1F8E9.toUIColor
    }
    class var colorLightGreen100: UIColor {
        return 0xDCEDC8.toUIColor
    }
    class var colorLightGreen200: UIColor {
        return 0xC5E1A5.toUIColor
    }
    class var colorLightGreen300: UIColor {
        return 0xAED581.toUIColor
    }
    class var colorLightGreen400: UIColor {
        return 0x9CCC65.toUIColor
    }
    class var colorLightGreen500: UIColor {
        return 0x8BC34A.toUIColor
    }
    class var colorLightGreen600: UIColor {
        return 0x7CB342.toUIColor
    }
    class var colorLightGreen700: UIColor {
        return 0x689F38.toUIColor
    }
    class var colorLightGreen800: UIColor {
        return 0x558B2F.toUIColor
    }
    class var colorLightGreen900: UIColor {
        return 0x33691E.toUIColor
    }
    // MARK:- Lime
    class var colorLime50: UIColor {
        return 0xF9FBE7.toUIColor
    }
    class var colorLime100: UIColor {
        return 0xF0F4C3.toUIColor
    }
    class var colorLime200: UIColor {
        return 0xE6EE9C.toUIColor
    }
    class var colorLime300: UIColor {
        return 0xDCE775.toUIColor
    }
    class var colorLime400: UIColor {
        return 0xD4E157.toUIColor
    }
    class var colorLime500: UIColor {
        return 0xCDDC39.toUIColor
    }
    class var colorLime600: UIColor {
        return 0xC0CA33.toUIColor
    }
    class var colorLime700: UIColor {
        return 0xAFB42B.toUIColor
    }
    class var colorLime800: UIColor {
        return 0x9E9D24.toUIColor
    }
    class var colorLime900: UIColor {
        return 0x827717.toUIColor
    }
    // MARK:- Blue
    class var colorBlue50: UIColor {
        return 0xE3F2FD.toUIColor
    }
    class var colorBlue100: UIColor {
        return 0xBBDEFB.toUIColor
    }
    class var colorBlue200: UIColor {
        return 0x90CAF9.toUIColor
    }
    class var colorBlue300: UIColor {
        return 0x64B5F6.toUIColor
    }
    class var colorBlue400: UIColor {
        return 0x42A5F5.toUIColor
    }
    class var colorBlue500: UIColor {
        return 0x2196F3.toUIColor
    }
    class var colorBlue600: UIColor {
        return 0x1E88E5.toUIColor
    }
    class var colorBlue700: UIColor {
        return 0x1976D2.toUIColor
    }
    class var colorBlue800: UIColor {
        return 0x1565C0.toUIColor
    }
    class var colorBlue900: UIColor {
        return 0x0D47A1.toUIColor
    }
}
