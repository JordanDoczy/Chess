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
    
    init?(description: String) {
        switch(description) {
        case File.a.description: self = .a
        case File.b.description: self = .b
        case File.c.description: self = .c
        case File.d.description: self = .d
        case File.e.description: self = .e
        case File.f.description: self = .f
        case File.g.description: self = .g
        case File.h.description: self = .h
        default: return nil
        }
    }
    
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

enum Space: Int, Equatable, CaseIterable {
    case a1 = 0
    case a2
    case a3
    case a4
    case a5
    case a6
    case a7
    case a8
    case b1
    case b2
    case b3
    case b4
    case b5
    case b6
    case b7
    case b8
    case c1
    case c2
    case c3
    case c4
    case c5
    case c6
    case c7
    case c8
    case d1
    case d2
    case d3
    case d4
    case d5
    case d6
    case d7
    case d8
    case e1
    case e2
    case e3
    case e4
    case e5
    case e6
    case e7
    case e8
    case f1
    case f2
    case f3
    case f4
    case f5
    case f6
    case f7
    case f8
    case g1
    case g2
    case g3
    case g4
    case g5
    case g6
    case g7
    case g8
    case h1
    case h2
    case h3
    case h4
    case h5
    case h6
    case h7
    case h8
    
    init(rank: Rank, file: File) {
        self = Space(rawValue: ((file.rawValue-1) * 8) + rank.rawValue-1)!
    }
    
    init?(name: String) {
        guard name.count == 2,
            let rankIndex = Int("\(name.last!)"),
            let rank = Rank(rawValue: rankIndex),
            let file = File(description: "\(name.first!)") else {
            return nil
        }

        self = Space(rank: rank, file: file)
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
