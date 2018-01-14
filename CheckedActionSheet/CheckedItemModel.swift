//
//  CheckedItemModel.swift
//  CheckedActionSheet
//
//  Created by Tamas Bara on 13.01.18.
//  Copyright © 2018 Tamas Bara. All rights reserved.
//

import Foundation

struct CheckedItemModel {
    
    var faCode: String
    var faIcon: String?
    var text: String
    
    init(faCode: String, text: String) {
        self.faCode = faCode
        faIcon = String.fontAwesomeIcon(code: faCode)
        self.text = text
    }
}
