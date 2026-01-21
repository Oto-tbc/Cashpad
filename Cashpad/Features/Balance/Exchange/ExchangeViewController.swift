//
//  ExchangeViewController.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 21.01.26.
//

import UIKit

final class ExchangeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        view.backgroundColor = UIColor(named: "Background")
        title = "Exchange"
        
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(handleBack)
        )
        navigationItem.leftBarButtonItem = backButton
        
    }
    
    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
}
