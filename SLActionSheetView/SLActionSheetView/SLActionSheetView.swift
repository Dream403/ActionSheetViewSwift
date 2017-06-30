//
//  SLActionSheetView.swift
//  SLActionSheetView
//
//  Created by snowlu on 2017/6/29.
//  Copyright © 2017年 ZhunKuaiTechnology. All rights reserved.
//

import UIKit


@objc protocol SLActionSheetViewDelegate {
    
   @objc optional  func actionSheetCompleted( _ actionSheet:SLActionSheetView , _ selectIndex :NSInteger)
}

 class SLActionSheetView: UIView {

    fileprivate let  BtnHeight = 44

    fileprivate let titleTag = 10000
    
    fileprivate let cancelTag  = 9999
    
    fileprivate let  Margin  = 6
    
    fileprivate let highImageColor = 0xF2F2F2
    
    fileprivate let TextWhiteColor = 0xffffff
    
    fileprivate let TextLinkColor = 0xEDF0F2
    
    fileprivate let SeparatorColor = 0xF2F2F2
    
    fileprivate let BgGlobeColor = 0xEDF0F2
    
    fileprivate let  ListTitleFont  = UIFont.systemFont(ofSize: 14)
    
    weak open var delegate: SLActionSheetViewDelegate?
    
    public  typealias  actionSheetClickCompleted  = ((_ actionSheet:SLActionSheetView? , _ index:NSInteger?)->Void)
    
   
    fileprivate  var sheetView :UIView?
    

    fileprivate var actionSheetCompeted :actionSheetClickCompleted?
    
    fileprivate var actionSheet:SLActionSheetView?
    
    fileprivate var  btnTag :Int
    
    required init?(coder aDecoder: NSCoder) {
        
      fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
         self.btnTag = 1;
       super.init(frame: frame)
    }
    
    
    public convenience  init(_ _delelgate:SLActionSheetViewDelegate? ,_ title:String? , _ cancelButtonTitle:String? ,_ otherButtonTitles:String ... ){
        
       self.init()
        
        let actionSheet: SLActionSheetView = self
         actionSheet.delegate = _delelgate
        
         self.actionSheet = actionSheet
        

        actionSheet.frame           = UIScreen.main.bounds
        actionSheet.backgroundColor = UIColor.black
        
        UIApplication.shared.keyWindow?.addSubview(actionSheet)

        actionSheet.alpha           = 0.0;
        
        let  tap = UITapGestureRecognizer.init(target: self, action:
            #selector(coverClick))
         actionSheet.addGestureRecognizer(tap)
       
        
        let sheetView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 0))
        
        sheetView.backgroundColor = UIColor.ColorFromRGBValue(BgGlobeColor)
        
        sheetView.alpha = 0.8
        
        UIApplication.shared.keyWindow?.addSubview(sheetView)
        
        sheetView.isHidden = true
        
        self.sheetView = sheetView
        
        
        if !(title?.isEmpty)! {
           
            self.setupBtn(title, true)
        }
        
        for (_, value) in otherButtonTitles.enumerated()
        {
           self.setupBtn(value, false)
        }
        
        var   sheetViewF = sheetView.frame
        
        
        if !(cancelButtonTitle?.isEmpty)! {
            
         sheetViewF.size.height  = CGFloat(BtnHeight * self.btnTag + Margin)
            
        }else{
            
          sheetViewF.size.height  = CGFloat(BtnHeight * self.btnTag - 1)
        }
        
        sheetView.frame = sheetViewF
        
        if !(cancelButtonTitle?.isEmpty)!{
          
            let y:CGFloat = (sheetView.size.height) - CGFloat(BtnHeight)
        
            let btn = UIButton.init(frame: CGRect.init(x: 0, y: y, width: SCREENWIDTH, height: CGFloat(BtnHeight)))
            btn.adjustsImageWhenHighlighted  = false
            btn.setBackgroundImage(UIImage.createImageWithColor(UIColor.ColorFromRGBValue(TextWhiteColor)), for: .normal)
            btn.setBackgroundImage(UIImage.createImageWithColor(UIColor.ColorFromRGBValue(TextWhiteColor)), for: .highlighted)
            btn.setBackgroundImage(UIImage.createImageWithColor(UIColor.ColorFromRGBValue(TextWhiteColor)), for: .disabled)
            btn.setBackgroundImage(UIImage.createImageWithColor(UIColor.ColorFromRGBValue(TextWhiteColor)), for: .selected)
            btn.imageEdgeInsets  = UIEdgeInsetsMake(0, -20, 0, 0);
            btn.setTitleColor(UIColor.ColorFromRGBValue(0x777777), for: .normal)
            btn.setTitleColor(UIColor.ColorFromRGBValue(0x777777), for: .highlighted)
            btn.setTitleColor(UIColor.ColorFromRGBValue(0x777777), for: .disabled)
            btn.setTitleColor(UIColor.ColorFromRGBValue(0x777777), for: .selected)
            btn.tag = cancelTag
            btn.setTitle(cancelButtonTitle, for: .selected)
            btn.setTitle(cancelButtonTitle, for: .disabled)
            btn.setTitle(cancelButtonTitle, for: .highlighted)
            btn.setTitle(cancelButtonTitle, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.addTarget(self, action: #selector(sheetBtnClick(_ :)), for: .touchUpInside)
            
            sheetView .addSubview(btn)
            
        }
        
        
    }

    
    fileprivate func  setupBtn(_ title:String? , _ isTitle:Bool?){
    
      let btn = UIButton.init(frame: CGRect.init(x: 0, y:BtnHeight * (self.btnTag - 1) , width: Int(SCREENWIDTH), height: BtnHeight))
       btn.adjustsImageWhenHighlighted  = false
       btn.setBackgroundImage(UIImage.createImageWithColor(UIColor.ColorFromRGBValue(TextWhiteColor)), for: .normal)
       btn.setBackgroundImage(UIImage.createImageWithColor(UIColor.ColorFromRGBValue(TextWhiteColor)), for: .highlighted)
       btn.setBackgroundImage(UIImage.createImageWithColor(UIColor.ColorFromRGBValue(TextWhiteColor)), for: .disabled)
       btn.setBackgroundImage(UIImage.createImageWithColor(UIColor.ColorFromRGBValue(TextWhiteColor)), for: .selected)
       btn.setTitle(title, for: .normal)
        btn.setTitle(title, for: .highlighted)
         btn.setTitle(title, for: .disabled)
        btn.setTitle(title, for: .selected)
       btn.imageEdgeInsets  = UIEdgeInsetsMake(0, -20, 0, 0);
       btn.setTitleColor(UIColor.ColorFromRGBValue(0x777777), for: .normal)
        btn.setTitleColor(UIColor.ColorFromRGBValue(0x777777), for: .highlighted)
         btn.setTitleColor(UIColor.ColorFromRGBValue(0x777777), for: .disabled)
        btn.setTitleColor(UIColor.ColorFromRGBValue(0x777777), for: .selected)
        
        if isTitle! {
            
            btn.tag = titleTag
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            btn.isEnabled = false
        }else {
            
            btn.tag = titleTag
            btn.titleLabel?.font = ListTitleFont
        }
        
        let lineView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 0.5))
        lineView.backgroundColor = UIColor.ColorFromRGBValue(SeparatorColor)
        btn.addSubview(lineView)
        btn.addTarget(self, action: #selector(sheetBtnClick(_:)), for: .touchUpInside)
        self.btnTag += 1
         self.sheetView!.addSubview(btn)
    }
    
    @objc fileprivate func sheetBtnClick( _ sender:UIButton){
        
        switch sender.tag {
        case cancelTag: self.coverClick()

        default:
        
        self.delegate?.actionSheetCompleted!(self, sender.tag)
         
      

        if self.actionSheetCompeted != nil {
           
            self.actionSheetCompeted!(self,sender.tag)
            }
            
        }
            self.coverClick()
        
    }
    
    @objc fileprivate func coverClick(){
      
        var sheetViewF = self.sheetView?.frame
        
         sheetViewF?.origin.y = SCREENHEIGHT;
        
         UIView.animate(withDuration: 0.2, animations: {
            self.sheetView?.frame   = sheetViewF!
            self.actionSheet?.alpha = 0.0;
            
         }) { (finished) in
            self.actionSheet?.removeFromSuperview()
            self.sheetView?.removeFromSuperview()
        }

    }
    
    
    public func show() {
      
      self.sheetView?.isHidden = false
        
      var  sheetViewF = self.sheetView?.frame
        
       sheetViewF?.origin.y   = SCREENHEIGHT;
       
        self.sheetView?.frame = sheetViewF!
        
       var  newSheetViewF   = self.sheetView?.frame;
    
       newSheetViewF?.origin.y = SCREENHEIGHT - (self.sheetView?.frame.size.height)!;
        
        UIView.animate(withDuration: 0.3) {
            
            self.sheetView?.frame = newSheetViewF!;
            
            self.actionSheet?.alpha = 0.3;
        }
    }
    
    public func show(_ completed:@escaping actionSheetClickCompleted){
        
        self.actionSheetCompeted = completed
        
        show()
        
    }
    
   

}

extension UIImage {
    
   fileprivate class func createImageWithColor(_ color:UIColor) ->UIImage{
        
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        
        context!.fill(rect)
        
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    
        return theImage!
        
    
    }
    
    
}
