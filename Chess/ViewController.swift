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
        
        test1()
    }
    
    func test1() {
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
        
        //        let validMoves1 = board.getValidMoves()
        //        for move1 in validMoves1 {
        //            let boardCopy = board.copy() as! Board
        //            boardCopy.move(move1)
        //            let validMoves2 = boardCopy.getValidMoves()
        //            for move2 in validMoves2 {
        //                let boardCopy = board.copy() as! Board
        //                boardCopy.move(move2)
        //                let validMoves3 = boardCopy.getValidMoves()
        //                for move3 in validMoves3 {
        //                    let boardCopy = board.copy() as! Board
        //                    boardCopy.move(move3)
        //                    let validMoves4 = boardCopy.getValidMoves()
        //                }
        //            }
        //        }
        
        let start = Date()
        for _ in 0..<1000000 {
            board.getValidMoves()
        }
        
        let end = Date()
        print(Board.count, end.timeIntervalSince(start))
        
        
        print("")
        board.printBoard()
    }
    
    func test2() {
        let a1: Int64 = 0b0000000000000000000000000000000000000000000000000000000000000001
        let b1: Int64 = 0b0000000000000000000000000000000000000000000000000000000000000010
        let c1: Int64 = 0b0000000000000000000000000000000000000000000000000000000000000100
        let d1: Int64 = 0b0000000000000000000000000000000000000000000000000000000000001000
        let e1: Int64 = 0b0000000000000000000000000000000000000000000000000000000000010000
        let f1: Int64 = 0b0000000000000000000000000000000000000000000000000000000000100000
        let g1: Int64 = 0b0000000000000000000000000000000000000000000000000000000001000000
        let h1: Int64 = 0b0000000000000000000000000000000000000000000000000000000010000000
        
        let a2: Int64 = 0b0000000000000000000000000000000000000000000000000000000100000000
        let b2: Int64 = 0b0000000000000000000000000000000000000000000000000000001000000000
        let c2: Int64 = 0b0000000000000000000000000000000000000000000000000000010000000000
        let d2: Int64 = 0b0000000000000000000000000000000000000000000000000000100000000000
        let e2: Int64 = 0b0000000000000000000000000000000000000000000000000001000000000000
        let f2: Int64 = 0b0000000000000000000000000000000000000000000000000010000000000000
        let g2: Int64 = 0b0000000000000000000000000000000000000000000000000100000000000000
        let h2: Int64 = 0b0000000000000000000000000000000000000000000000001000000000000000
        
        var whitePawns: Int64 = a2 + b2 + c2 + d2 + e2 + f2 + g2 + h2
        var whiteKnights: Int64 = b1 + g1
        
        func getPieceType(at: Int64) -> String? {
            if whitePawns & at > 0 {
                return "whitePawn"
            } else if whiteKnights & at > 0 {
                return "whiteKnight"
            }
            return nil
        }
        
        let start = Date()
        for _ in 0..<1000000 {
            getPieceType(at: a2)
        }
        let end = Date()
        print(end.timeIntervalSince(start))
    }
    
}

