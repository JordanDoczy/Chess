//
//  Board.swift
//  Chess
//
//  Created by Jordan Doczy on 11/20/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import Foundation

struct Move {
    var from: Space
    var to: Space
    
    init(from: Space, to: Space) {
        self.from = from
        self.to = to
    }
}

class Board: NSCopying {
    
    static let spaces: [Space] = [.a1, .a2, .a3, .a4, .a5, .a6, .a7, .a8,
                                  .b1, .b2, .b3, .b4,. b5, .b6, .b7, .b8,
                                  .c1, .c2, .c3, .c4,. c5, .c6, .c7, .c8,
                                  .d1, .d2, .d3, .d4,. d5, .d6, .d7, .d8,
                                  .e1, .e2, .e3, .e4,. e5, .e6, .e7, .e8,
                                  .f1, .f2, .f3, .f4,. f5, .f6, .f7, .f8,
                                  .g1, .g2, .g3, .g4,. g5, .g6, .g7, .g8,
                                  .h1, .h2, .h3, .h4,. h5, .h6, .h7, .h8]
    
    var castleOptions = Set<CastleMoves>()
    var color:Color = .white
    var data = [Space: Piece]()
    var enPassant:Space?
    var halfMove: Int = 0
    var fullMove: Int = 0

    var test =  Array<Piece?>(repeating: nil, count: 64);
    
    var blackPawns: UInt64   = 0
    var blackKnights: UInt64 = 0
    var blackBishops: UInt64 = 0
    var blackRooks: UInt64   = 0
    var blackQueen: UInt64   = 0
    var blackKing: UInt64    = 0

    var whitePawns: UInt64   = 0
    var whiteKnights: UInt64 = 0
    var whiteBishops: UInt64 = 0
    var whiteRooks: UInt64   = 0
    var whiteQueen: UInt64   = 0
    var whiteKing: UInt64    = 0
    
    var blackPieces: UInt64 {
        return blackPawns + blackKnights + blackBishops + blackRooks + blackQueen + blackKing
    }
    
    var whitePieces: UInt64 {
        return whitePawns + whiteKnights + whiteBishops + whiteRooks + whiteQueen + whiteKing
    }
    
    init() {
        
    }
    
    init(data: [Space: Piece], castleOptions: Set<CastleMoves>, color: Color, enPassant: Space?, halfMove: Int, fullMove: Int) {
        self.data = data
        self.enPassant = enPassant
        self.color = color
        self.castleOptions = castleOptions
        self.halfMove = halfMove
        self.fullMove = fullMove
    }
    
    func clear() {
        data = [:]
        color = .white
        castleOptions = Set<CastleMoves>()
        enPassant = nil
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Board(data: data, castleOptions: castleOptions, color: color, enPassant: enPassant, halfMove: halfMove, fullMove: fullMove)
        return copy
    }
    
    func getKingPosition(with color: Color) -> Space? {
        return color == .white ? Space(rawValue: whiteKing) : Space(rawValue: blackKing)
    }
    
    static func getPawnMoves(at space: Space, color: Color) -> UInt64 {
        return color == .black ? space.blackPawnMoves : space.whitePawnMoves
    }

    func getPiece(at space: Space) -> Piece? {
        
        if blackPawns & space.rawValue > 0 {
            return .blackPawn
        } else if blackKnights & space.rawValue > 0 {
            return .blackKnight
        } else if blackBishops & space.rawValue > 0 {
            return .blackBishop
        } else if blackRooks & space.rawValue > 0 {
            return .blackRook
        } else if blackQueen & space.rawValue > 0 {
            return .blackQueen
        } else if blackKing & space.rawValue > 0 {
            return .blackKing
        } else if whitePawns & space.rawValue > 0 {
            return .whitePawn
        } else if whiteKnights & space.rawValue > 0 {
            return .whiteKnight
        } else if whiteBishops & space.rawValue > 0 {
            return .whiteBishop
        } else if whiteRooks & space.rawValue > 0 {
            return .whiteRook
        } else if whiteQueen & space.rawValue > 0 {
            return .whiteQueen
        } else if whiteKing & space.rawValue > 0 {
            return .whiteKing
        }

        return nil
    }
    
    func getPossibleMoves(at space: Space, for piece: Piece) -> UInt64 {
        switch piece {
        case .blackPawn: return space.blackPawnMoves
        case .whitePawn: return space.whitePawnMoves
        case .blackKnight, .whiteKnight: return space.knightMoves
        case .blackBishop, .whiteBishop: return space.bishopMoves
        case .blackRook, .whiteRook: return  space.rookMoves
        case .blackQueen, .whiteQueen: return space.queenMoves
        case .blackKing, .whiteKing: return space.kingMoves
        }
    }
    
    static func getSpace(rank: Rank, file: File) -> Space {
        return Space(rawValue: rank.spaces & file.spaces)!
    }
    
    static func convertToSpaces(from model: UInt64) -> [Space] {
        var spaces = [Space]()
        var space: UInt64 = 0b1
        for _ in 0..<64 {
            if model & space > 0 {
                spaces.append(Space(rawValue: space)!)
            }
            space = space << 1
        }
        return spaces
    }
    
    func getSpaces() -> (blackSpaces: [Space], whiteSpaces: [Space]) {
        var blackSpaces = [Space]()
        var whiteSpaces = [Space]()
        
        let blackPieces = self.blackPieces
        let whitePieces = self.whitePieces
        
        var space: UInt64 = 0b1
        for _ in 0..<64 {
            if blackPieces & space > 0 {
                blackSpaces.append(Space(rawValue: space)!)
            } else if whitePieces & space > 0 {
                whiteSpaces.append(Space(rawValue: space)!)
            }
            space = space << 1
        }

        return (blackSpaces: blackSpaces, whiteSpaces: whiteSpaces)
    }
    
    func getMoves() -> (blackMoves: Dictionary<Space,UInt64>, whiteMoves: Dictionary<Space,UInt64>) {
        var blackMoves = Dictionary<Space,UInt64>()
        var whiteMoves = Dictionary<Space,UInt64>()
        
        var position: UInt64 = 0b1
        for index in 0..<64 {
            let space = Board.spaces[index]
            
            if blackPawns & position > 0 {
                blackMoves[space] = getPossibleMoves(at: space, for: .blackPawn)
            } else if blackKnights & position > 0 {
                blackMoves[space] = getPossibleMoves(at: space, for: .blackKnight)
            } else if blackBishops & position > 0 {
                blackMoves[space] = getPossibleMoves(at: space, for: .blackBishop)
            } else if blackRooks & position > 0 {
                blackMoves[space] = getPossibleMoves(at: space, for: .blackRook)
            } else if blackQueen & position > 0 {
                blackMoves[space] = getPossibleMoves(at: space, for: .blackQueen)
            } else if blackKing & position > 0 {
                blackMoves[space] = getPossibleMoves(at: space, for: .blackKing)
            } else if whitePawns & position > 0 {
                whiteMoves[space] = getPossibleMoves(at: space, for: .whitePawn)
            } else if whiteKing & position > 0 {
                whiteMoves[space] = getPossibleMoves(at: space, for: .whiteKnight)
            } else if whiteBishops & position > 0 {
                whiteMoves[space] = getPossibleMoves(at: space, for: .whiteBishop)
            } else if whiteRooks & position > 0 {
                whiteMoves[space] = getPossibleMoves(at: space, for: .whiteRook)
            } else if whiteQueen & position > 0 {
                whiteMoves[space] = getPossibleMoves(at: space, for: .whiteQueen)
            } else if whiteKing & position > 0 {
                whiteMoves[space] = getPossibleMoves(at: space, for: .whiteKing)
            }
            
            position = position << 1
        }
        
        
        return (blackMoves: blackMoves, whiteMoves: whiteMoves)
    }
    
    func getSpaces(for piece: Piece) -> [Space] {
        switch (piece) {
        case .blackPawn:   return Board.convertToSpaces(from: blackPawns)
        case .blackKnight: return Board.convertToSpaces(from: blackKnights)
        case .blackBishop: return Board.convertToSpaces(from: blackBishops)
        case .blackRook:   return Board.convertToSpaces(from: blackRooks)
        case .blackQueen:  return Board.convertToSpaces(from: blackQueen)
        case .blackKing:   return Board.convertToSpaces(from: blackKing)
        case .whitePawn:   return Board.convertToSpaces(from: whitePawns)
        case .whiteKnight: return Board.convertToSpaces(from: whiteKnights)
        case .whiteBishop: return Board.convertToSpaces(from: whiteBishops)
        case .whiteRook:   return Board.convertToSpaces(from: whiteRooks)
        case .whiteQueen:  return Board.convertToSpaces(from: whiteQueen)
        case .whiteKing:   return Board.convertToSpaces(from: whiteKing)
        }
    }

    func getValidMoves() -> [Move] {
        let kingPosition = getKingPosition(with: color)
        let moves = getMoves().blackMoves
        let move = Move(from: .a1, to: .a2)
        moves.filter { $0
            return isValidMove(move, checks: [])}
        return []
        
        // print(kingPosition)
        
        //let checks = opponentOccupiedSpaces.flatMap { space in getPossibleMoves(at: space, for: getPiece(at: space)!).filter{ $0 == kingPosition }.map{ Move(from: space, to: $0) }}
        //return moves.filter { isValidMove($0, checks: checks) }
    }
    
    func isInCheck(checks: [Move]) -> Bool {
        return checks.filter { isValidMove($0, checks: []) }.count > 0
    }

    func isEmpty(at space: Space) -> Bool {
        return getPiece(at: space) == nil
    }

    func isOccupiedByOpponent(at space: Space, myColor: Color) -> Bool {
        guard let piece = getPiece(at: space) else {
            return false
        }
        
        return myColor == .white ? piece.color == .black : piece.color == .white
    }
    
    func isPathClearBetween(_ move: Move) -> Bool {
        return false
//        let origin = move.from < move.to ? move.from : move.to
//        let destination = origin == move.from ? move.to : move.from
//        
//        let spaces: Set<Space>
//        
//        if move.from.rank == move.to.rank {
//            spaces = move.from.rank.spaces
//        } else if move.from.file == move.to.file {
//            spaces = move.from.file.spaces
//        } else if let diagonal = move.from.diagonals.intersection(move.to.diagonals).first {
//            spaces = diagonal.spaces
//        } else {
//            return false
//        }
//        
//        let isClear = spaces
//            .filter {
//                $0.index > origin.index
//                    && $0.index < destination.index
//                    && !isEmpty(at: $0) }
//            .count == 0
//        
//        return isClear

    }
    
    func isPathClearBetween(from: Space, to: Space) -> Bool {
        return isPathClearBetween(Move(from: from, to: to))
    }
    
    public static var count = 0
    func isValidMove(_ move: Move, checks: [Move]) -> Bool {
        Board.count += 1
        guard let piece = getPiece(at: move.from), 
            isEmpty(at: move.to) || isOccupiedByOpponent(at: move.to, myColor: piece.color) else {
            return false
        }
        
        switch piece {
        case .blackPawn, .whitePawn:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            guard move.to == enPassant || (move.from.file == move.to.file && !isOccupiedByOpponent(at: move.to, myColor: piece.color)) else {
                return false
            }
            
            if (checks.count > 0) {
                let board = copy() as! Board
                board.move(move)
                return !board.isInCheck(checks: checks)
            }

            return true
        case .blackKnight, .whiteKnight:
            if (checks.count > 0) {
                let board = copy() as! Board
                board.move(move)
                return !board.isInCheck(checks: checks)
            }
            
            return true
        case .blackBishop, .whiteBishop:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            if (checks.count > 0) {
                let board = copy() as! Board
                board.move(move)
                return !board.isInCheck(checks: checks)
            }
            
            return true
        case .blackRook, .whiteRook:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            if (checks.count > 0) {
                let board = copy() as! Board
                board.move(move)
                return !board.isInCheck(checks: checks)
            }
            
            return true
        case .blackQueen, .whiteQueen:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            if (checks.count > 0) {
                let board = copy() as! Board
                board.move(move)
                return !board.isInCheck(checks: checks)
            }
            
            return true
        case .blackKing, .whiteKing:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            if abs(move.from.file.rawValue - move.to.file.rawValue) == 2 {
                let rookMove:Move
                
                switch move.to.file {
                case .g:
                    rookMove = Move(from: Board.getSpace(rank: move.to.rank, file: .h),
                                    to: Board.getSpace(rank: move.to.rank, file: .f))
                case .c:
                    rookMove = Move(from: Board.getSpace(rank: move.to.rank, file: .a),
                                    to: Board.getSpace(rank: move.to.rank, file: .d))
                default: return false
                }
                
                if !isValidMove(rookMove, checks: checks) {
                    return false
                }
            }
            
            if (checks.count > 0) {
                let board = copy() as! Board
                board.move(move)
                return !board.isInCheck(checks: checks)
            }
            
            return true
        }
    }

    func move(_ move: Move) {
        
        func enPassantCapture(_ space: Space) {
            if space.rank == ._3 {
                setSpace(Board.getSpace(rank: ._4, file: space.file), to: nil)
            } else {
                setSpace(Board.getSpace(rank: ._7, file: space.file), to: nil)
            }
        }

        guard let piece = getPiece(at: move.from) else {
            return
        }
        
        let currentEnPassant = enPassant
        
        enPassant = nil
        
        if !isEmpty(at: move.to) {
            halfMove = 0
        } else {
            halfMove += 1
        }
        
        switch piece {
        case .whitePawn, .blackPawn:
            if move.to == currentEnPassant {
                enPassantCapture(move.to)
            } else if abs(move.to.rank.rawValue - move.from.rank.rawValue) == 2 {
                enPassant = move.to
            }
            
            halfMove = 0
            
        case .whiteRook, .blackRook:
            switch move.from {
            case CastleMoves.blackKingSide.rook.from:
                castleOptions.remove(CastleMoves.blackKingSide)
            case CastleMoves.blackQueenSide.rook.to:
                castleOptions.remove(CastleMoves.blackQueenSide)
            case CastleMoves.whiteKingSide.rook.from:
                castleOptions.remove(CastleMoves.whiteKingSide)
            case CastleMoves.whiteQueenSide.rook.to:
                castleOptions.remove(CastleMoves.whiteQueenSide)
            default:
                break
            }
        case .whiteKing, .blackKing:
            switch move {
            case CastleMoves.blackKingSide.king:
                self.move(CastleMoves.blackKingSide.rook)
            case CastleMoves.blackQueenSide.king:
                self.move(CastleMoves.blackQueenSide.rook)
            case CastleMoves.whiteKingSide.king:
                self.move(CastleMoves.whiteKingSide.rook)
            case CastleMoves.whiteQueenSide.king:
                self.move(CastleMoves.whiteQueenSide.rook)
            default:
                break
            }
            castleOptions.removeAll()
        default:
            break
        }
        
        setSpace(move.to, to: piece)
        setSpace(move.from, to: nil)
        color = color.opposite
        
        if color == .white {
            fullMove += 1
        }
    }
    
    func printBoard() {
        printRank(rank: ._8)
        printRank(rank: ._7)
        printRank(rank: ._6)
        printRank(rank: ._5)
        printRank(rank: ._4)
        printRank(rank: ._3)
        printRank(rank: ._2)
        printRank(rank: ._1)
    }

    func printRank(rank: Rank) {
        let spaces = Board.convertToSpaces(from: rank.spaces)
        print(spaces.enumerated().map { (index, element) in "[\(getPiece(at: element)?.symbol ?? "　")]" })
    }
    
    func setSpace(_ space: Space, to piece: Piece?) {
        if let piece = piece {
            switch (piece) {
            case .blackPawn:
                blackPawns += space.rawValue
            case .blackKnight:
                blackKnights += space.rawValue
            case .blackBishop:
                blackBishops += space.rawValue
            case .blackRook:
                blackRooks += space.rawValue
            case .blackQueen:
                blackQueen = space.rawValue
            case .blackKing:
                blackKing = space.rawValue
            case .whitePawn:
                whitePawns += space.rawValue
            case .whiteKnight:
                whiteKnights += space.rawValue
            case .whiteBishop:
                whiteBishops += space.rawValue
            case .whiteRook:
                whiteRooks += space.rawValue
            case .whiteQueen:
                whiteQueen = space.rawValue
            case .whiteKing:
                whiteKing = space.rawValue
            }
        } else {
            blackPawns   &= ~space.rawValue
            blackKnights &= ~space.rawValue
            blackBishops &= ~space.rawValue
            blackRooks   &= ~space.rawValue
            blackQueen   &= ~space.rawValue
            blackKing    &= ~space.rawValue
            whitePawns   &= ~space.rawValue
            whiteKnights &= ~space.rawValue
            whiteBishops &= ~space.rawValue
            whiteRooks   &= ~space.rawValue
            whiteQueen   &= ~space.rawValue
            whiteKing    &= ~space.rawValue
        }
    }
}

func == (lhs: Space, rhs: Space) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

func ~=(lhs: Move, rhs: Move) -> Bool {
    return lhs.from ~= rhs.from && lhs.to ~= rhs.to
}
