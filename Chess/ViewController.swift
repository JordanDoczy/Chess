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
        //testSpeed()
        //testNewModel()
        printIndicies()
    }
    
    @IBAction func onRunTestPressed(_ sender: UIButton) {
        testNewModel()
    }
    
    func printIndicies() {
        Space.allCases.forEach {
            print($0, $0.index)
        }
    }
    
    func testNewModel() {
        let start = Date()
        for _ in 0..<1000000 {
            let space = SpacesA.model[.b4]
            space.fileSpaces
            space.rankSpaces
            space.rank
            space.file
            
//            Spaces.getFileSpaces(at: .b4)
//            Spaces.getRankSpaces(at: .b4)
//            Spaces.getRank(at: .b4)
//            Spaces.getFile(at: .b4)
        }
        let end = Date()
        print(end.timeIntervalSince(start))
    }
    
    func testSpeed() {
        let start = Date()
        let fen = "rnbqk2r/pppp1ppp/5n2/8/1Q2P3/2N5/PPP2PPP/R1B1KBNR b KQkq - 0 6"
        let board = Fen.createBoard(from: fen)!
        
        for _ in 0..<1000 {
            board.getValidMoves(for: .b4) // todo finish testing speed 
            //board.isValidMove(Move(from: .b4, to: .e7))
        
        }
        
        let end = Date()
        print(end.timeIntervalSince(start))
    }
    
    func playGame() {
        let board = Fen.createBoard()
        var validMoves = board.getValidMoves()
        while validMoves.isEmpty == false {
            let start = Date()
            board.computerMove()
            let end = Date()
            print(end.timeIntervalSince(start))
            //board.printBoard()
            print("move:", board.fullMove, board.halfMove)
            validMoves = board.getValidMoves()
            
            guard board.fullMove < 2000 else {
                return
            }
        }
        
        print("isCheckmate?", board.isCheckmate())
        board.printBoard()
    }
    
}




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
//let fen = "rnbqk2r/pppp1pp1/5n1p/8/Q3P3/2N5/PPP2PPP/R1B1KBNR b KQkq - 1 7" // for castling
//        let fen = "r1bqk2r/ppp2pp1/2n2n1p/3pP3/1Q6/2N1B3/PPP2PPP/R3KBNR w KQkq d6 0 9" // for en passant
//        guard let board = Fen.createBoard(from: fen) else {
//            return
//        }

//        print(board.castleOptions)
//        board.move(Move(from: .e8, to: .g8))
//        print(board.castleOptions)
//        board.move(Move(from: .c1, to: .e3))
//        board.move(Move(from: .b8, to: .c6))
//        board.move(Move(from: .e1, to: .c1))
//        print(board.castleOptions)

//        let whiteQueenMoves = board.getValidMoves(for: .b4).map { $0.to }.sorted { $0.index < $1.index}
//        let blackKingMoves = board.getValidMoves(for: .e8).map { $0.to }.sorted { $0.index < $1.index}
//        let isInCheck = board.isInCheck(color: .black)
//        print("isInCheck", isInCheck)
//        print(blackKingMoves)

//let blackKingMoves = board.getValidMoves(for: .e8).map { $0.to }.sorted { $0.index < $1.index}
//print(blackKingMoves)

//        let c2 = board.getValidMoves(for: .c2).map { $0.to }.sorted { $0.index < $1.index}
//        print(c2)
//
//        let e5 = board.getValidMoves(for: .e5).map { $0.to }.sorted { $0.index < $1.index}
//        print(e5)
