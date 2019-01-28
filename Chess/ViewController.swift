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
    }
    
    @IBAction func onRunTestPressed(_ sender: UIButton) {

//        buildModel()
//        testSpeed()
        
        testBoard2()
        
//        let start = Date()
//        let fen = "rnbqk2r/pppp1ppp/5n2/8/1Q2P3/2N5/PPP2PPP/R1B1KBNR b KQkq - 0 6"
//        let board = Fen.createBoard(from: fen)!
//        let count = testRecursiveCall(board: board, remaingingCalls: 2)
//        let end = Date()
//        print(count, end.timeIntervalSince(start))
    }
    
    func testBoard2() {
        let start = Date()
        let fen = "rnbqk2r/pppp1ppp/5n2/8/1Q2P3/2N5/PPP2PPP/R1B1KBNR b KQkq - 0 6"
        let board = Fen.createBoard2(from: fen)!
        board.printBoard()
    }
    
    func testRecursiveCall(board: Board, remaingingCalls: Int) -> Int {
        let validMoves = board.getValidMoves()
        var count = validMoves.count
        
        guard remaingingCalls > 0 else {
            return count
        }
        
        for _ in validMoves {
            count += testRecursiveCall(board: board, remaingingCalls: remaingingCalls-1)
        }
        
        return count
    }
    
    func buildModel () {
        let squares = SquaresArray()
        
        squares.model.forEach { square in
            var square = square
            let rook = square.fileSpaces.union(square.rankSpaces)
            let queen = rook.union(square.diagonalSpaces)
            let whiteKing = square.adjacentSpaces.union(CastleMoves.getSpaces(for: .white).king)
            let blackKing = square.adjacentSpaces.union(CastleMoves.getSpaces(for: .black).king)
            square.rookSpaces = rook
            square.queenSpaces = queen
            square.whiteKingSpaces = whiteKing
            square.blackKingSpaces = blackKing
            printSquare(square: square)
        }
        
        func printSquare(square: Square) {
            let adjacentSpaces = square.adjacentSpaces.map { $0.rawValue }
            let diagonalSpaces = square.diagonalSpaces.map { $0.rawValue }
            let fileSpaces = square.fileSpaces.map { $0.rawValue }
            let rankSpaces = square.rankSpaces.map { $0.rawValue }
            let queenSpaces = square.queenSpaces.map { $0.rawValue }
            let whiteKingSpaces = square.whiteKingSpaces.map { $0.rawValue }
            let blackKingSpaces = square.blackKingSpaces.map { $0.rawValue }
            let rookSpaces = square.rookSpaces.map { $0.rawValue }
            let knightSpaces = square.knightSpaces.map { $0.rawValue }
            
            print("(index: \(square.index), adjacentSpaces: \(adjacentSpaces), file: File.\(square.file), fileSpaces: \(fileSpaces), rank: Rank.\(square.rank), rankSpaces: \(rankSpaces), diagonals: \(square.diagonals), diagonalSpaces: \(diagonalSpaces), knightSpaces: \(knightSpaces), queenSpaces: \(queenSpaces), whiteKingSpaces: \(whiteKingSpaces), blackKingSpaces: \(blackKingSpaces), rookSpaces: \(rookSpaces)),\r")
        }
    }
    
    func testSpeed() {
        let start = Date()
        let fen = "rnbqk2r/pppp1ppp/5n2/8/1Q2P3/2N5/PPP2PPP/R1B1KBNR b KQkq - 0 6"
        let board = Fen.createBoard(from: fen)!
        let iterations = 1000000 // 1 mil

//        board.printBoard()
        
        var count = 0
        for _ in 0 ..< iterations {
            //count += board.getValidMovesOptimized().count
//            let x = Board.getPossibleSpaces(for: .whiteQueen, at: .b4)
            let x = Board.getPossibleSpaces2(for: .whiteQueen, at: .b4)
        }
        
        let end = Date()
        print(count, end.timeIntervalSince(start))
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
