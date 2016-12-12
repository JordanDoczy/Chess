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
        let board1 = board.copy() as! Board

        board.move(Move(from: .g8, to: .f6))
        print(Fen.getFen(from: board))
        let board2 = board.copy() as! Board
        
        board.move(Move(from: .b1, to: .c3))
        print(Fen.getFen(from: board))
        let board3 = board.copy() as! Board
        
        board.move(Move(from: .e7, to: .e5))
        print(Fen.getFen(from: board))
        let board4 = board.copy() as! Board

        
        var start = Date()
        for index in 0..<500 {
            _ = board.getValidMoves()
        }
//        _ = board1.getValidMoves()
//        _ = board2.getValidMoves()
//        _ = board3.getValidMoves()
//        _ = board4.getValidMoves()
        var end = Date()
        print(end.timeIntervalSince(start))

        
//        start = Date()
//        _ = board.getValidMoves()
//        _ = board1.getValidMoves()
//        _ = board2.getValidMoves()
//        _ = board3.getValidMoves()
//        _ = board4.getValidMoves()
//        end = Date()
//        print(end.timeIntervalSince(start))
//


        print("")
        board.printBoard()

        
        
    }
    
}

