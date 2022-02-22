//
//  EventsCellBuilder.swift
//  EventsApp
//
//  Created by Rafael Ortiz on 21/02/22.
//

import Foundation

struct EventsCellBuilder {
    
    func makeTitleSubtitleCellViewModel(
        _ type: TitleSubtitleCellViewModel.CellType,
        onCellUpdate: (() -> Void)? = nil
    ) -> TitleSubtitleCellViewModel
    {
        
        switch type {
        case .text:
            return TitleSubtitleCellViewModel(
                title: "Name",
                subtitle: "",
                placeholder: "Add an Name",
                type: .text, onCellUpdate: onCellUpdate
            )
        case .date:
            return TitleSubtitleCellViewModel(
                title: "Date",
                subtitle: "",
                placeholder: "Select a Date",
                type: .date,
                onCellUpdate: onCellUpdate
            )
        case .image:
            return TitleSubtitleCellViewModel(
                title: "Background",
                subtitle: "", placeholder: "",
                type: .image,
                onCellUpdate: onCellUpdate
            )
        }
    }
}
