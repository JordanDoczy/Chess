//
//  ViewController.swift
//  Chess
//
//  Created by Jordan Doczy on 11/12/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let board = Fen.createBoard()
        print(Fen.getFen(from: board))
        board.move(Move(from: .e2, to: .e4))
        print(Fen.getFen(from: board))
        board.move(Move(from: .g8, to: .f6))
        print(Fen.getFen(from: board))
        board.move(Move(from: .b1, to: .c3))
        print(Fen.getFen(from: board))
        board.move(Move(from: .e7, to: .e5))
        print(Fen.getFen(from: board))

        print("")
        board.printBoard()

    }
    
}

