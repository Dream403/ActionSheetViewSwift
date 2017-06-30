//
//  ExtensionTools.swift
//  SLActionSheetView
//
//  Created by snowlu on 2017/6/29.
//  Copyright © 2017年 ZhunKuaiTechnology. All rights reserved.
//

import UIKit
import Foundation


 public enum UILayoutCornerRadiusType {
    
    case UILayoutCornerRadiusTypeTop
    
    case UILayoutCornerRadiusLeft
    
    case UILayoutCornerRadiusBottom
    
    case UILayoutCornerRadiusRight
    
    case UILayoutCornerRadiusAll
}

let SCREENHEIGHT  = UIScreen.main.bounds.size.height

let  SCREENWIDTH  = UIScreen.main.bounds.size.width
// 理想线宽
let  LINE_WIDTH:Double   = 1.0
// 实际应该显示的线宽
let SINGLE_LINE_WIDTH =  floor((LINE_WIDTH / Double(UIScreen.main.scale)) * 100 )/100
//偏移的宽度
let SINGLE_LINE_ADJUST_OFFSET =  floor((LINE_WIDTH / Double(UIScreen.main.scale / 2)) * 100 )/100

extension UIColor {
    
    class func ColorRGB( _ r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor
    {
        return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
    }
    
    class func ColorRGBAlpha(r:CGFloat,_ g:CGFloat,_ b:CGFloat ,_ a:CGFloat) -> UIColor
    {
        return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a)
    }
    //十六进制
    class func ColorFromRGBValue( _ rgbValue:Int) ->UIColor {
        
        return UIColor(red:((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green:((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                       alpha: 1.0)
    }
    
    class func ColorFromRGBValueAlpha( _ rgbValue:Int , _ a:CGFloat) ->UIColor {
        
        return UIColor(red:((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green:((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                       alpha: a)
    }
}





//字符串
extension String {

func substring(s: Int, _ e: Int? = nil) -> String {
    
    let start = s >= 0 ? self.startIndex : self.endIndex
    
    let startIndex = index(start, offsetBy: s)
    
    var end: String.Index
    var endIndex: String.Index
    if(e == nil){
        end = self.endIndex
        endIndex = self.endIndex
    } else {
        end = e! >= 0 ? self.startIndex : self.endIndex
        
        endIndex = index(end, offsetBy: e!)
    }
    let range = Range<String.Index>(startIndex..<endIndex)
    
    return self.substring(with: range)
    
 }
    
}






extension UIView{
    
    var x :CGFloat  {
        
        get {
            
            return frame.origin.x
        }
        
        set(newValue){
            
            var tempFrame :CGRect = frame
            
            tempFrame.origin.x = newValue
            
            frame  = tempFrame
            
        }
        
    }
    
    var y:CGFloat {
        
        get{
            
            return  frame.origin.y
            
        }
        set(newValue){
            
            var tempFrame :CGRect = frame
            
            tempFrame.origin.y = newValue
            
            frame  = tempFrame
            
        }
        
    }
    
    var centerX :CGFloat  {
        
        get {
            
            return center.x
        }
        
        set(newValue){
            
            var tempCener :CGPoint = center
            
            tempCener.x = newValue
            
            center  = tempCener
            
        }
        
    }
    
    var centerY :CGFloat  {
        
        get {
            
            return center.y
        }
        
        set(newValue){
            
            var tempCener :CGPoint = center
            
            tempCener.y = newValue
            
            center  = tempCener
            
        }
        
    }
    
    var origin:CGPoint {
        
        get {
            
            return frame.origin
        }
        
        set(newValue){
            
            var tempFrame :CGRect = frame
            
            tempFrame.origin = newValue
            
            frame  = tempFrame
            
        }
        
    }
    
    var size:CGSize {
        
        get {
            
            return frame.size
        }
        
        set(newValue){
            
            var tempFrame:CGRect = frame
            
            tempFrame.size  = newValue
            
            frame = tempFrame
            
        }
    }
    
    var width :CGFloat  {
        
        get {
            
            return frame.size.width
        }
        
        set(newValue){
            
            var tempFrame :CGRect = frame
            
            tempFrame.size.width = newValue
            
            frame  = tempFrame
            
        }
        
    }
    
    var height :CGFloat  {
        
        get {
            
            return frame.size.height
        }
        
        set(newValue){
            
            var tempFrame :CGRect = frame
            
            tempFrame.size.height = newValue
            
            frame  = tempFrame
            
        }
        
    }
    
    var  cornerRadius:CGFloat {
        
        get {
            
           return  self.layer.cornerRadius
        }
        
        set(newValue){
            
            var tempCornerRadius :CGFloat = self.layer.cornerRadius
            
            tempCornerRadius = newValue
            
            self.layer.cornerRadius = tempCornerRadius
            
            self.layer.masksToBounds = true
            
        }
    }
    
    public  func addTopBorder (_ borderColor:UIColor , _ borderWidth :CGFloat ){
        
       var pixelAdjustOffset  =   0
        
        if Int((borderWidth * UIScreen.main.scale + 1)) % 2 == 0 {
          
            pixelAdjustOffset = Int(SINGLE_LINE_ADJUST_OFFSET)
            
        }
        
        let border  = CALayer ()
        
        border.backgroundColor = borderColor.cgColor
        
        border.frame  =  CGRect.init(x: CGFloat(pixelAdjustOffset), y: 0, width: self.width, height: borderWidth)
        
        self.layer .addSublayer(border)
        
    }
    
    public  func addTopBorderWithView (_ borderColor:UIColor , _ borderWidth :CGFloat ,_ viewWidth :CGFloat){
        
        var pixelAdjustOffset  =   0
        
        if Int((borderWidth * UIScreen.main.scale + 1)) % 2 == 0 {
            
            pixelAdjustOffset = Int(SINGLE_LINE_ADJUST_OFFSET)
            
        }
        let border  = CALayer ()
        border.backgroundColor = borderColor.cgColor
        border.frame  =  CGRect.init(x: CGFloat(pixelAdjustOffset), y: 0, width: viewWidth, height: borderWidth)
        
        self.layer .addSublayer(border)
        
    }
    
    public func addBottomBorder(_ borderColor:UIColor , _ borderWidth :CGFloat ){
       
        let border  = CALayer ()
        border.backgroundColor = borderColor.cgColor
        border.frame  =  CGRect.init(x: 0, y: self.height - borderWidth, width: self.width, height: borderWidth)
        border.name = "border";
        self.layer .addSublayer(border)
        
    }
    
    public func addBottomBorderWithView(_ borderColor:UIColor , _ borderWidth :CGFloat ,_ viewWidth :CGFloat){
        let border  = CALayer ()
        border.backgroundColor = borderColor.cgColor
        border.frame  =  CGRect.init(x: 0, y: self.height - borderWidth, width: viewWidth, height: borderWidth)
        border.name = "border";
        self.layer .addSublayer(border)
        
    }
    public func addLeftBorder(_ borderColor:UIColor , _ borderWidth :CGFloat ){
        let border  = CALayer ()
        border.backgroundColor = borderColor.cgColor
        border.frame  =  CGRect.init(x: 0, y: 0, width: borderWidth, height: self.height)
        self.layer .addSublayer(border)
        
    }
    
    public func addRigthBorder(_ borderColor:UIColor , _ borderWidth :CGFloat ){
        let border  = CALayer ()
        border.backgroundColor = borderColor.cgColor
        border.frame  =  CGRect.init(x: self.width - borderWidth, y: 0, width: borderWidth, height: self.height)
        self.layer .addSublayer(border)
        
    }
    
    public func cornerRadiusType(_ radiusType:UILayoutCornerRadiusType , _ cornerRadius:CGFloat){
        
        let  size :CGSize = CGSize.init(width: cornerRadius, height: cornerRadius)
        
        var  maskPath:UIBezierPath?
        
        switch radiusType {
        case .UILayoutCornerRadiusTypeTop:
            
            maskPath  = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: size)
        case .UILayoutCornerRadiusLeft:
            
            maskPath  = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: size)
        case .UILayoutCornerRadiusBottom:
            
            maskPath  = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: [.bottomRight, .bottomLeft], cornerRadii: size)
         
        case .UILayoutCornerRadiusRight:
            
            maskPath  = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: size)
        default:
           
           maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners:.allCorners , cornerRadii: size)
            
        }
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.frame = self.bounds
        
    
        maskLayer.path = maskPath?.cgPath
        
        self.layer.mask = maskLayer
        
        self.layer.masksToBounds  =  true
        
    }
    
}
