//
//  ViewController.swift
//  Chess
//
//  Created by Jordan Doczy on 11/12/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    static let pieces = [Piece.blackPawn, .whitePawn, .whiteKnight, .whiteBishop, .whiteRook, .whiteQueen, .whiteKing]
    
    var spaceIndex = 0 {
        didSet {
            if spaceIndex >= Constants.spaces.count {
                spaceIndex = 0
                pieceIndex += 1
            } else if spaceIndex < 0 {
                spaceIndex = Constants.spaces.count - 1
                pieceIndex -= 1
            }
            
            ViewController.visualTest(spaceIndex: spaceIndex, pieceIndex: pieceIndex)
        }
    }
    
    var pieceIndex = 5 {
        didSet{
            if pieceIndex >= ViewController.pieces.count {
                pieceIndex = 0
            } else if pieceIndex < 0 {
                pieceIndex = ViewController.pieces.count - 1
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //performanceTest()
        
        ViewController.printSpaces()
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        spaceIndex += 1
    }
    
    @IBAction func previousPressed(_ sender: UIButton) {
        spaceIndex -= 1
    }
    
    private func performanceTest() {
        let start = Date()
        for _ in 0 ..< 1000000 {
            let space = Constants.spaces[spaceIndex]
            _ = ViewController.testPiece(ViewController.pieces[pieceIndex], at: space)
        }
        print(Date().timeIntervalSince(start))
    }
    
    private static func visualTest(spaceIndex: Int, pieceIndex: Int) {
        let space = Constants.spaces[spaceIndex]
        ViewController.testPiece(ViewController.pieces[pieceIndex], at: space).printBoard()
        print("\n")
    }
    
    private static func testPiece(_ piece: Piece, at space: Space) -> Board {
        let board = Fen.createBoard()
//        board.setSpace(space, to: ViewController.getOppositePiece(piece))
//        
//        let spaces = Board.convertToSpaces(from: ViewController.getMoves(piece, at: space))
////        spaces.forEach { board.setSpace($0, to: piece) }
//        
////        let spaces = space.queenMovesAsCollection
//        for index in 0 ..< spaces.count {
//            board.setSpace(spaces[index], to: piece)
//        }
//        
        
        return board
    }
    
    private static func getMoves(_ piece: Piece, at space: Space) -> UInt64 {
        switch (piece) {
        case .blackPawn: return space.blackPawnMoves
        case .whitePawn: return space.whitePawnMoves
        case .blackKnight, .whiteKnight: return space.knightMoves
        case .blackBishop, .whiteBishop: return space.bishopMoves
        case .blackRook, .whiteRook: return space.rookMoves
        case .blackQueen, .whiteQueen: return space.queenMoves
        case .blackKing, .whiteKing: return space.kingMoves
        }
    }
    
    private static func getOppositePiece(_ piece: Piece) -> Piece {
        if piece.description == piece.description.lowercased() {
            return Piece(rawValue: piece.description.uppercased())!
        } else {
            return Piece(rawValue: piece.description.lowercased())!
        }
    }
    
    private static func printSpaces() {
        let a = [Space.a1, .a2, .a3, .a4, .a5, .a6, .a7, .a8]
        let b = [Space.b1, .b2, .b3, .b4, .b5, .b6, .b7, .b8]
        let c = [Space.c1, .c2, .c3, .c4, .c5, .c6, .c7, .c8]
        let d = [Space.d1, .d2, .d3, .d4, .d5, .d6, .d7, .d8]
        let e = [Space.e1, .e2, .e3, .e4, .e5, .e6, .e7, .e8]
        let f = [Space.f1, .f2, .f3, .f4, .f5, .f6, .f7, .f8]
        let g = [Space.g1, .g2, .g3, .g4, .g5, .g6, .g7, .g8]
        let h = [Space.h1, .h2, .h3, .h4, .h5, .h6, .h7, .h8]
        
        print ("switch self {")
        a.forEach { printSpace(space: $0) }
        print("")
        b.forEach { printSpace(space: $0) }
        print("")
        c.forEach { printSpace(space: $0) }
        print("")
        d.forEach { printSpace(space: $0) }
        print("")
        e.forEach { printSpace(space: $0) }
        print("")
        f.forEach { printSpace(space: $0) }
        print("")
        g.forEach { printSpace(space: $0) }
        print("")
        h.forEach { printSpace(space: $0) }
        print ("}")
    }
    
    private static func printSpace(space: Space) {
        let name = String(describing: space)
        print("case .\(name): return \(space.computedAdjacentSpaces)")
    }
    
}
