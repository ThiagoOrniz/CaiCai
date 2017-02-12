//
//  CaiCaiViewController.swift
//  CaiCai
//
//  Created by Thiago Orniz Martin on 12/02/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class CaiCaiViewController: UIViewController {
  
    @IBOutlet weak var caicaiView: CaiCaiView! {
        didSet {
            caicaiView.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(addDrop(_:)))
            )
        }
    }
    
    func addDrop(_ recognizer: UITapGestureRecognizer){
        
        if recognizer.state == .ended {
            caicaiView.addDrop()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        caicaiView.animating = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        caicaiView.animating = false
        
    }
}
