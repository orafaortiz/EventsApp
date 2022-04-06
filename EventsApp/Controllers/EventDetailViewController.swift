//
//  EventDetailViewController.swift
//  EventsApp
//
//  Created by Rafael Ortiz on 22/02/22.
//

import UIKit

final class EventDetailViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    var viewModel: EventDetailViewModel!
    @IBOutlet var timeRemainingStackView: TimeRemainingStackView! {
        didSet {
            timeRemainingStackView.setup()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onUpdate = { [weak self] in
            guard let self = self, let timeRemainingViewModel = self.viewModel.timeRemainingViewModel else { return }
            self.backgroundImageView.image = self.viewModel.image
            // time remaining labels, event name and date label
            self.timeRemainingStackView.update(with: timeRemainingViewModel)
        }
        
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "pencil"),
                                                  style: .plain, target: viewModel,
                                                  action: viewModel.editButtonTapped)
        viewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
}


