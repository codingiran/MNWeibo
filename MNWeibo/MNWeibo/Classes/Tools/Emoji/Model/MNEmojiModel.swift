//
//  MNEmojiModel.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/12.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

class MNEmojiModel: NSObject {
    ///图片表情，true = emoji，false = 图片表情
    @objc var type = false
    
    /// 表情字符串 - 提交给服务端
    @objc var chs:String?
    
    /// 表情图片，本地图文混排
    @objc var png:String?
    
    /// emoji - 16进制编码字符串
    @objc var code:String?
    
    /// 表情所在目录
    @objc var directory: String?
    
    /// 图片表情图片
    @objc var image: UIImage?{
        if type{
            //is emoji
            return nil
        }
        
        guard let path = Bundle.main.path(forResource: "MNEmoji.bundle", ofType: nil),
            let bundle = Bundle(path:path),
            let directory = directory,
            let png = png else{
                return nil
        }
        return UIImage(named: "\(directory)/\(png)",in: bundle, compatibleWith: nil)
    }
    
    /// 返回图文混排对应的文本字符串
    func imageText(font: UIFont) -> NSAttributedString{
        //判断是否有图像，没有的话就是纯文本
        guard let image = image else {
            return NSAttributedString(string: "")
        }
        
        let atta = NSTextAttachment()
        atta.image = image
        let height = font.lineHeight
        
        //topMargin = -4,防止图片被切割
        let topMargin:CGFloat = -MNLayout.Layout(4)
        atta.bounds = CGRect(x: 0, y: topMargin, width: height, height: height)
        
        return NSAttributedString(attachment: atta)
    }
    
    override var description: String{
        return yy_modelDescription()
    }
}
