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
        
//        let board = BoardHelper.getBoardWithValidMoves(at: .e4, piece: .whiteBishop)
//        board.printBoard()
        
        let board = Board()
        board.setBoard()
        board.setSpace(.a2, to: nil)
        board.printBoard()
        print(board.isPathClearBetween(from: .a8, to: .a1))
        
        
    }



}

