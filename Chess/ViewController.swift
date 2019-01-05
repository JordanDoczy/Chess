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

//        let board = Fen.createBoard()
//        print(Fen.getFen(from: board))
//
//        board.move(Move(from: .e2, to: .e4))
//        print(Fen.getFen(from: board))
//        let board1 = board.copy() as! Board
//
//        board.move(Move(from: .g8, to: .f6))
//        print(Fen.getFen(from: board))
//        let board2 = board.copy() as! Board
//
//        board.move(Move(from: .b1, to: .c3))
//        print(Fen.getFen(from: board))
//        let board3 = board.copy() as! Board
//
//        board.move(Move(from: .e7, to: .e5))
//        print(Fen.getFen(from: board))
//        let board4 = board.copy() as! Board
//
//
//        let start = Date()
////        for _ in 0..<5000 {
////            _ = board.getValidMoves()
////        }
//
//        _ = board1.getValidMoves()
//        _ = board2.getValidMoves()
//        _ = board3.getValidMoves()
//        _ = board4.getValidMoves()
//        let end = Date()
//        print(end.timeIntervalSince(start))
//        print("")
//        board.printBoard()

        let fen = "rnbqk2r/ppppbppp/5n2/8/Q3P3/2N5/PPP2PPP/R1B1KBNR b KQkq - 2 5"
        guard let board = Fen.createBoard(from: fen) else {
            return
        }
        
        // TODO: work on api - need a way to try a move or confirm isValid in one call 
        board.move(Move(from: .d7, to: .d6))
        board.printBoard()
        
    }
    
}

