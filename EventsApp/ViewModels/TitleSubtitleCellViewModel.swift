//
//  TitleSubtitleCellViewModel.swift
//  EventsApp
//
//  Created by Rafael Ortiz on 20/02/22.
//

import Foundation
import UIKit

final class TitleSubtitleCellViewModel {
    
    enum CellType {
        case text
        case date
        case image
    }
    
    var title: String
    private(set) var subtitle: String
    let placeholder: String
    let type: CellType
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        return dateFormatter
    }()
    private(set) var image: UIImage?
    private(set) var onCellUpdate: (() -> Void)?
    
    init(title: String, subtitle: String, placeholder: String, type: CellType,
         onCellUpdate: (() -> Void)? ) {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.type = type
        self.onCellUpdate = onCellUpdate
    }
    
    func update(title: String) {
        self.title = title
    }
    
    func update(_ subtitle: String) {
        self.subtitle = subtitle
    }
    
    func update(_ date: Date) {
        let dateString = dateFormatter.string(from: date)
        self.subtitle = dateString
        // reload the cell
        onCellUpdate?()
    }
    
    func update(_ image: UIImage) {
        self.image = image
        onCellUpdate?()
    }
}
