//
//  TOView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 02.12.2023.
//

import Foundation
import UIKit

class TOView: UIView, UITableViewDelegate {
    
    weak var delegate: ViewToViewController?
    
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
