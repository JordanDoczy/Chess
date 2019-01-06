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

        //let fen = "rnbqk2r/pppp1ppp/5n2/8/1Q2P3/2N5/PPP2PPP/R1B1KBNR b KQkq - 0 6"
        let fen = "rnbqk2r/pppp1pp1/5n1p/8/Q3P3/2N5/PPP2PPP/R1B1KBNR b KQkq - 1 7"
        guard let board = Fen.createBoard(from: fen) else {
            return
        }
        
        print(board.castleOptions)
        board.move(Move(from: .e8, to: .g8))
        print(board.castleOptions)
        board.move(Move(from: .c1, to: .e3))
        board.move(Move(from: .b8, to: .c6))
        board.move(Move(from: .e1, to: .c1))
        print(board.castleOptions)

//        let whiteQueenMoves = board.getValidMoves(for: .b4).map { $0.to }.sorted { $0.index < $1.index}
//        let blackKingMoves = board.getValidMoves(for: .e8).map { $0.to }.sorted { $0.index < $1.index}
//        let isInCheck = board.isInCheck(color: .black)
//        print("isInCheck", isInCheck)
//        print(blackKingMoves)
        
        //let blackKingMoves = board.getValidMoves(for: .e8).map { $0.to }.sorted { $0.index < $1.index}
        //print(blackKingMoves)
        
        
//        var moves = board.getValidMoves()
//        moves = moves.sorted { $0.from.rawValue < $1.from.rawValue }
//        moves.forEach { move in
//            if let piece = board.getPiece(at: move.from) {
//                print(piece.description, move)
//            }
//        }
        
        // TODO: work on api - need a way to try a move or confirm isValid in one call
        //board.move(Move(from: .d7, to: .d6))
        board.printBoard()
        
    }
    
}

