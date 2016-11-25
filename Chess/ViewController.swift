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
        
        //board.setBoard()
        board.testMoves(space: .e8, piece: .blackKing)
        board.printBoard()
    }



}

