//
//  ViewController.swift
//  Note
//
//  Created by Alex K on 7/2/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var centerLabel: UILabel!
    var block: () -> Void
    
    required init?(coder aDecoder: NSCoder) {
        self.block = {}
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let view = view else {
            return
        }
        for view in view.subviews {
            guard let label = view as? UILabel else {
                return
            }
            guard let prevText = label.text else {
                return
            }
            #if DEBUG
            label.text = prevText + " Debug"
            #else
            label.text = prevText + " Release"
            #endif
        }
        self.block = {
            NSLog("%@", self)
        }
        print("View loaded")
    }


}

