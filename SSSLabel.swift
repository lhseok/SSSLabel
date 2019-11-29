//
//  SSSLabel.swift
//  SSSLabel
//
//  Created by leehoseok on 2019/11/29.
//  Copyright © 2019 SSS. All rights reserved.
//

import UIKit

class SSSLabel: UILabel {

    override var text: String? {
        didSet {
            bindView()
        }
    }
    
    override var lineBreakMode: NSLineBreakMode {
        didSet {
            bindView()
        }
    }
    
    override var numberOfLines: Int {
        didSet {
            bindView()
        }
    }

    func bindView() {
        
        // do not run if exist not space between word and word, or lineBreakMode is not byWordWrapp, or not multiline
        guard let array = self.text?.components(separatedBy: " "),
            array.count > 1,
            lineBreakMode == .byWordWrapping,
            numberOfLines != 1 else {
            return
        }
        
        let width = self.frame.size.width // width of label
        var widthForRow: CGFloat = 0 // width of one row
        let space = " " // space string
        var result = "" // string to return
        let fontAttributes = [NSAttributedString.Key.font: font] // attributes of label font
        let widthForSpace = (space as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any]).width // width of space string
        
        for (idx, word) in array.enumerated() {
            
            let size = (word as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
            
            // newline if over max width of label
            if widthForRow + size.width > width {
                result.append("\n")
                widthForRow = 0
            }
            
            result.append(word)
            widthForRow += size.width
            
            // break loop if word string is last element of array
            if idx == array.endIndex {
                break
            }
            
            // newline if over max width of label
            if widthForRow + widthForSpace > width {
//                result.append("\n")  // if you want that include space at first string on newline
                widthForRow = 0
            }
            
            result.append(space)
            widthForRow += widthForSpace
        }
        
        // setting new text include new line for word wrapping
        super.text = result
    }
}
