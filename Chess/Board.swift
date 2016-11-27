//
//  Board.swift
//  Chess
//
//  Created by Jordan Doczy on 11/20/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import Foundation

class Board {
    
    static var STANDARD_BOARD:String = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
    
    fileprivate var color:Color = .white
    fileprivate var castleOptions = Set<CastleMoves>()
    fileprivate var data = Array<Piece?>(repeating: nil, count: 64)
    fileprivate var enPassant:Space?
    
    init () {
        createFromFen(fen: Board.STANDARD_BOARD)
    }
    
    init(fen: String) {
        createFromFen(fen: fen)
    }
    
    func clear() {
        data = Array<Piece?>(repeating: nil, count: 64)
        color = .white
        castleOptions = Set<CastleMoves>()
        enPassant = nil
    }
    
    fileprivate func createFromFen(fen: String) {
        let parts = fen.components(separatedBy: " ")
        
        guard parts.count == 6 else {
            return
        }
        
        color = Color(rawValue: parts[1]) ?? .white
        enPassant = Space(rawValue: parts[3])
        
        let castles = parts[2]
        for castle in castles.characters {
            if let castleMove = CastleMoves(rawValue: String(castle)) {
                castleOptions.insert(castleMove)
            }
        }
        
        var rank: Rank = ._8
        let rows = parts[0].components(separatedBy: "/")
        for row in rows {
            var file: File = .a
            for character in row.characters {
                if let piece = Piece(rawValue: String(character)) {
                    let space = BoardHelper.getSpace(rank: rank, file: file)
                    setSpace(space, to: piece)
                    file = file.nextFile
                } else if let emptySpaces = Int(String(character)) {
                    file = File(rawValue: file.rawValue + emptySpaces) ?? .a
                }
                
                if file == .a {
                    rank = rank.previousRank
                }
            }
        }
    }
    
    fileprivate func getCastleMoves() -> Set<Space>? {
        return Set(castleOptions.map { $0.moves.king })
    }
    
    func getFen() -> String {
        let castleMoves = self.castleOptions.map { $0.rawValue }
        let castleOptions = castleMoves.count > 0 ? castleMoves.joined() : "-"
        let enPassant = self.enPassant?.rawValue ?? "-"
        
        var value = getFen(at: ._8) + "/"
        value += getFen(at: ._7) + "/"
        value += getFen(at: ._6) + "/"
        value += getFen(at: ._5) + "/"
        value += getFen(at: ._4) + "/"
        value += getFen(at: ._3) + "/"
        value += getFen(at: ._2) + "/"
        value += getFen(at: ._1)
        value += " \(color.rawValue)"
        value += " \(castleOptions)"
        value += " \(enPassant)"
        
        return value
    }
    
    fileprivate func getFen(at rank: Rank) -> String {
        let pieces = getPieces(at: rank)
        var value = ""
        var spaceCount = 0
        
        for piece in pieces {
            if let piece = piece {
                if spaceCount > 0 {
                    value += "\(spaceCount)"
                }
                value += piece.rawValue
                spaceCount = 0
            } else {
                spaceCount += 1
            }
        }
        
        if spaceCount > 0 {
            value += "\(spaceCount)"
        }

        return value
    }
    
    func getPiece(at space: Space) -> Piece? {
        return data[space.index]
    }
    
    func getPieces(at diagonal: Diagonal) -> [Piece?] {
        let spaces = diagonal.spaces.sorted { $0.file.rawValue < $1.file.rawValue }
        return spaces.map{ getPiece(at: $0) }
    }
    
    func getPieces(at file: File) -> [Piece?] {
        let spaces = file.spaces.sorted { $0.rank.rawValue < $1.rank.rawValue }
        return spaces.map{ getPiece(at: $0) }
    }
    
    func getPieces(at rank: Rank) -> [Piece?] {
        let spaces = rank.spaces.sorted { $0.file.rawValue < $1.file.rawValue }
        return spaces.map{ getPiece(at: $0) }
    }
    
    func getValidMoves(from: Space, piece: Piece) -> Set<Space> {
        var validMoves = BoardHelper.getValidMoves(at: from, piece: piece)
        if let castleMoves = getCastleMoves() {
            validMoves.formUnion(castleMoves)
        }
        return validMoves
    }

    func isEmpty(at space: Space) -> Bool {
        return getPiece(at: space) == nil
    }

    func isOccupiedByOpponent(at space: Space, myColor: Color) -> Bool {
        guard let piece = getPiece(at: space) else {
            return false
        }
        
        return piece.color != myColor
    }

    func isPathClearBetween(from: Space, to: Space) -> Bool {
        
        let origin = from.index < to.index ? from : to
        let destination = origin == from ? to : from
        
        let spaces: Set<Space>
        
        if from.rank == to.rank {
            spaces = from.rank.spaces
        } else if from.file == to.file {
            spaces = from.file.spaces
        } else if let diagonal = from.diagonals.intersection(to.diagonals).first {
            spaces = diagonal.spaces
        } else {
            return false
        }
        
        let isClear = spaces
            .filter {
                $0.index > origin.index
                && $0.index < destination.index
                && !isEmpty(at: $0) }
            .count == 0
        
        return isClear
    }
    
    func movePiece(from: Space, to: Space) -> Bool {
        guard let piece = getPiece(at: from),
            isEmpty(at: to) || isOccupiedByOpponent(at: to, myColor: piece.color),
            getValidMoves(from: from, piece: piece).contains(to) else {
                return false
        }
        
        if piece != .blackKnight && piece != .whiteKnight && !isPathClearBetween(from: from, to: to) {
            return false
        }
        
        switch piece {
        case .whitePawn, .blackPawn:
            if to == enPassant {
                if to.rank == ._3 {
                    setSpace(BoardHelper.getSpace(rank: ._4, file: to.file), to: nil)
                } else {
                    setSpace(BoardHelper.getSpace(rank: ._7, file: to.file), to: nil)
                }
            } else if from.file != to.file && !isOccupiedByOpponent(at: to, myColor: piece.color) {
                return false
            }
        case .whiteKing, .blackKing:
            if abs(from.file.rawValue - to.file.rawValue) == 2 {
                let rookFrom:Space, rookTo:Space
                
                switch to.file {
                case .g:
                    rookFrom = BoardHelper.getSpace(rank: to.rank, file: .h)
                    rookTo = BoardHelper.getSpace(rank: to.rank, file: .f)
                case .c:
                    rookFrom = BoardHelper.getSpace(rank: to.rank, file: .a)
                    rookTo = BoardHelper.getSpace(rank: to.rank, file: .d)
                default: return false
                }
                
                if !movePiece(from: rookFrom, to: rookTo) {
                    return false
                }
            }
        default:
            break
        }
        
        setSpace(to, to: piece)
        setSpace(from, to: nil)
        
        return true
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
        print( getPieces(at: rank).map { $0?.description ?? "[]" })
    }
    
    func setSpace(_ space: Space, to piece: Piece?) {
        data[space.index] = piece
    }
}
