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
    var history = [Board]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let board = Board(fen: "rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1")
        board.printBoard()
        print("")
        print(board.getFen())
    }
    
}

