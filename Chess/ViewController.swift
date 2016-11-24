//
//  ViewController.swift
//  Chess
//
//  Created by Jordan Doczy on 11/12/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var board = Board()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //board.setUp()
        board.testMoves(space: .e4, piece: .blackBishop)
        board.printBoard()
    }



}

