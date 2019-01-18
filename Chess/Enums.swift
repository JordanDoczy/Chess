//
//  Enums.swift
//  Chess
//
//  Created by Jordan Doczy on 11/24/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import Foundation

enum File: Int, CaseIterable {
    case a = 1
    case b
    case c
    case d
    case e
    case f
    case g
    case h
    
    var description: String {
        switch self {
        case .a: return "a"
        case .b: return "b"
        case .c: return "c"
        case .d: return "d"
        case .e: return "e"
        case .f: return "f"
        case .g: return "g"
        case .h: return "h"
        }
    }

    var nextFile: File {
        switch self {
        case .a: return .b
        case .b: return .c
        case .c: return .d
        case .d: return .e
        case .e: return .f
        case .f: return .g
        case .g: return .h
        case .h: return .a
        }
    }
    
    var previousFile: File {
        switch self {
        case .a: return .h
        case .b: return .a
        case .c: return .b
        case .d: return .c
        case .e: return .d
        case .f: return .e
        case .g: return .f
        case .h: return .g
        }
    }

}

enum Rank: Int, CaseIterable {
    case _1 = 1
    case _2
    case _3
    case _4
    case _5
    case _6
    case _7
    case _8
    
    var description: String {
        return "\(rawValue)"
    }

    var nextRank: Rank {
        switch self {
        case ._1: return ._2
        case ._2: return ._3
        case ._3: return ._4
        case ._4: return ._5
        case ._5: return ._6
        case ._6: return ._7
        case ._7: return ._8
        case ._8: return ._1
        }
    }
    
    var previousRank: Rank {
        switch self {
        case ._1: return ._8
        case ._2: return ._1
        case ._3: return ._2
        case ._4: return ._3
        case ._5: return ._4
        case ._6: return ._5
        case ._7: return ._6
        case ._8: return ._7
        }
    }

}

enum Diagonal: CaseIterable {
    case a1h8
    case b1h7
    case b1a2
    case b8a7
    case b8h2
    case c1h6
    case c1a3
    case c8a6
    case c8h3
    case d1h5
    case d1a4
    case d8a5
    case d8h4
    case e1h4
    case e1a5
    case e8a4
    case e8h5
    case f1h3
    case f1a6
    case f8a3
    case f8h6
    case g1h2
    case g1a7
    case g8a2
    case g8h7
    case h1a8
}

enum Space: String, Equatable, CaseIterable {
    case a1 = "a1"
    case a2 = "a2"
    case a3 = "a3"
    case a4 = "a4"
    case a5 = "a5"
    case a6 = "a6"
    case a7 = "a7"
    case a8 = "a8"
    case b1 = "b1"
    case b2 = "b2"
    case b3 = "b3"
    case b4 = "b4"
    case b5 = "b5"
    case b6 = "b6"
    case b7 = "b7"
    case b8 = "b8"
    case c1 = "c1"
    case c2 = "c2"
    case c3 = "c3"
    case c4 = "c4"
    case c5 = "c5"
    case c6 = "c6"
    case c7 = "c7"
    case c8 = "c8"
    case d1 = "d1"
    case d2 = "d2"
    case d3 = "d3"
    case d4 = "d4"
    case d5 = "d5"
    case d6 = "d6"
    case d7 = "d7"
    case d8 = "d8"
    case e1 = "e1"
    case e2 = "e2"
    case e3 = "e3"
    case e4 = "e4"
    case e5 = "e5"
    case e6 = "e6"
    case e7 = "e7"
    case e8 = "e8"
    case f1 = "f1"
    case f2 = "f2"
    case f3 = "f3"
    case f4 = "f4"
    case f5 = "f5"
    case f6 = "f6"
    case f7 = "f7"
    case f8 = "f8"
    case g1 = "g1"
    case g2 = "g2"
    case g3 = "g3"
    case g4 = "g4"
    case g5 = "g5"
    case g6 = "g6"
    case g7 = "g7"
    case g8 = "g8"
    case h1 = "h1"
    case h2 = "h2"
    case h3 = "h3"
    case h4 = "h4"
    case h5 = "h5"
    case h6 = "h6"
    case h7 = "h7"
    case h8 = "h8"
    
    init(rank: Rank, file: File) {
        self = Space(rawValue: file.description + rank.description)!
    }
}

enum CastleMoves: String {
    case blackKingSide =  "k"
    case blackQueenSide = "q"
    case whiteKingSide =  "K"
    case whiteQueenSide = "Q"

    static func getSpaces(for color: Color) -> (king: Set<Space>, rook: Set<Space>) {
        switch color {
        case .white:
            return (king: [.c1, .g1], rook: [.f1, .d1])
        case .black:
            return (king: [.c8, .g8], rook: [.f8, .d8])
        }
    }

    var king: Move {
        switch self {
        case .blackKingSide:  return Move(from: .e8, to: .g8)
        case .blackQueenSide: return Move(from: .e8, to: .c8)
        case .whiteKingSide:  return Move(from: .e1, to: .g1)
        case .whiteQueenSide: return Move(from: .e1, to: .c1)
        }
    }
    
    var kingStep: Move {
        switch self {
        case .blackKingSide:  return Move(from: .e8, to: .f8)
        case .blackQueenSide: return Move(from: .e8, to: .d8)
        case .whiteKingSide:  return Move(from: .e1, to: .f1)
        case .whiteQueenSide: return Move(from: .e1, to: .d1)
        }
    }
    
    var rook: Move {
        switch self {
        case .blackKingSide:  return Move(from: .h8, to: .f8)
        case .blackQueenSide: return Move(from: .a8, to: .d8)
        case .whiteKingSide:  return Move(from: .h1, to: .f1)
        case .whiteQueenSide: return Move(from: .a1, to: .d1)
        }
    }
    
    init?(move: MoveStruct) {
        switch move.hashValue {
        case MoveStruct(from: .e8, to: .g8).hashValue: self = .blackKingSide
        case MoveStruct(from: .e8, to: .c8).hashValue: self = .blackQueenSide
        case MoveStruct(from: .e1, to: .g1).hashValue: self = .whiteKingSide
        case MoveStruct(from: .e1, to: .c1).hashValue: self = .whiteQueenSide
        default: return nil
        }
    }
    
    init?(from: Space, to: Space) {
        switch from.rawValue {
        case Space.e1.rawValue:
            if to == .c1 {
                self = .whiteQueenSide
            } else if to == .g1 {
                self = .whiteKingSide
            }
            return nil
        case Space.e8.rawValue:
            if to == .c8 {
                self = .blackQueenSide
            } else if to == .g8 {
                self = .blackKingSide
            }
            return nil
        default: return nil
        }
    }
}

enum Color: String {
    case black = "b"
    case white = "w"
    
    var description: String {
        switch self {
        case .black: return "black"
        case .white: return "white"
        }
    }
    
    var opposite: Color {
        switch self {
        case .black: return .white
        case .white: return .black
        }
    }
    
    var sign: Int {
        switch self {
        case .black: return -1
        case .white: return 1
        }
    }
}

enum Piece: String {
    case blackPawn =   "p"
    case blackKnight = "n"
    case blackBishop = "b"
    case blackRook =   "r"
    case blackQueen =  "q"
    case blackKing =   "k"
    case whitePawn =   "P"
    case whiteKnight = "N"
    case whiteBishop = "B"
    case whiteRook =   "R"
    case whiteQueen =  "Q"
    case whiteKing =   "K"
    
    var description: String {
        switch self {
        case .blackPawn:   return "♟"
        case .blackKnight: return "♞"
        case .blackBishop: return "♝"
        case .blackRook:   return "♜"
        case .blackQueen:  return "♛"
        case .blackKing:   return "♚"
        case .whitePawn:   return "♙"
        case .whiteKnight: return "♘"
        case .whiteBishop: return "♗"
        case .whiteRook:   return "♖"
        case .whiteQueen:  return "♕"
        case .whiteKing:   return "♔"
        }
    }
    
    var color: Color {
        switch self {
        case .blackPawn, .blackKnight, .blackBishop, .blackRook, .blackQueen, .blackKing: return .black
        case .whitePawn, .whiteKnight, .whiteBishop, .whiteRook, .whiteQueen, .whiteKing: return .white
        }
    }
    
    var rookType: Piece? {
        switch self {
        case .whiteKing: return .whiteRook
        case .blackKing: return .blackRook
        default: return nil
        }
    }

    var value: Int {
        switch self {
        case .blackPawn, .whitePawn: return 1 * color.sign
        case .blackKnight, .whiteKnight, .blackBishop, .whiteBishop: return 3 * color.sign
        case .blackRook, .whiteRook: return 5 * color.sign
        case .blackQueen, .whiteQueen: return 9 * color.sign
        case .blackKing, .whiteKing: return 0 * color.sign
        }
    }
}
