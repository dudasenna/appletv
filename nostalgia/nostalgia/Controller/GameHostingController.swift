//
//  GameHostingController.swift
//  nostalgia
//
//  Created by Evaldo Garcia de Souza Júnior on 31/05/21.
//

import Foundation
import UIKit
import SwiftUI

class GameHostingController: UIHostingController<GameViewUI> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: GameViewUI());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class PlayerController: UIHostingController<GameViewUI> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: GameViewUI());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
