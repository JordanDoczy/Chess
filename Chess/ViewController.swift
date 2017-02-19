//
//  ViewController.swift
//  Chess
//
//  Created by Jordan Doczy on 11/12/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var spaceIndex = 0 {
        didSet {
            if spaceIndex >= Board.spaces.count {
                spaceIndex = 0
                pieceIndex += 1
            }
        }
    }
    
    var pieceIndex = 2 {
        didSet{
            if pieceIndex > pieces.count {
                pieceIndex = 0
            }
        }
    }
    
    let pieces = [Piece.blackPawn, .whitePawn, .blackKnight, .whiteKnight, .blackBishop, .whiteBishop, .blackRook, .whiteRook, .blackQueen, .whiteQueen, .blackKing, .whiteKing]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test()
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        spaceIndex += 1
        test()
    }
    
    @IBAction func previousPressed(_ sender: UIButton) {
        spaceIndex -= 1
        test()
    }
    
    private func test() {
        let space = Board.spaces[spaceIndex]
        testPiece(pieces[pieceIndex], at: space).printBoard()
        print("\n")
    }
    
    private func testPiece(_ piece: Piece, at space: Space) -> Board {
        let board = Board()
        board.setSpace(space, to: getOppositePiece(piece))
        let spaces = Board.convertToSpaces(from: getMoves(piece, at: space))
        spaces.forEach { board.setSpace($0, to: piece) }
        return board
    }
    
    private func getMoves(_ piece: Piece, at space: Space) -> UInt64 {
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
    
    private func getOppositePiece(_ piece: Piece) -> Piece {
        if piece.description == piece.description.lowercased() {
            return Piece(rawValue: piece.description.uppercased())!
        } else {
            return Piece(rawValue: piece.description.lowercased())!
        }
    }
}
