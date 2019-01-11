//
//  Board.swift
//  Chess
//
//  Created by Jordan Doczy on 11/20/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import Foundation

class Board: NSCopying {
    
    private(set) var castleOptions = Set<CastleMoves>()
    private(set) var color: Color = .white
    private(set) var data = [Space: Piece]()
    private(set) var enPassant: Space?
    private(set) var halfMove: Int = 0
    private(set) var fullMove: Int = 0

    init(data: [Space: Piece], castleOptions: Set<CastleMoves>, color: Color, enPassant: Space?, halfMove: Int, fullMove: Int) {
        self.data = data
        self.enPassant = enPassant
        self.color = color
        self.castleOptions = castleOptions
        self.halfMove = halfMove
        self.fullMove = fullMove
    }

    func isCheckmatePossible() -> Bool {
        
        var whiteCount = 0
        var blackCount = 0
        
        for piece in data.values {
            switch(piece) {
            case .blackQueen, .whiteQueen, .blackRook, .whiteRook, .blackPawn, .whitePawn: return true
            case .whiteBishop, .whiteKnight:
                whiteCount += 1
                if whiteCount > 1 {
                    return true
                }
            case .blackBishop, .blackKnight:
                blackCount += 1
                if blackCount > 1 {
                    return true
                }
            default: break
            }
        }
        
        return false
    }

    func isCheckmate() -> Bool {
        return getValidMoves().count == 0 && isInCheck(color: color)
    }
    
    func choosePiece(color: Color) -> Piece {
        return color == .white ? .whiteQueen : .blackQueen
    }
    
    func clear() {
        data = [:]
        color = .white
        castleOptions = Set<CastleMoves>()
        enPassant = nil
    }

    func computerMove() {
        var currentValue = getBoardValue()
        let validMoves = getValidMoves()
        
        var bestMove = validMoves.randomElement()!
        
        validMoves.forEach { move in
            let board = copy() as! Board
            board.move(move)
            
            let value = board.getBoardValue()
            
            let isWhite = color == .white
            if board.isCheckmate()
                || isWhite && value > currentValue
                || value < currentValue {
                bestMove = move
                currentValue = value
            }
        }
        
        move(bestMove)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Board(data: data, castleOptions: castleOptions, color: color, enPassant: enPassant, halfMove: halfMove, fullMove: fullMove)
        return copy
    }
    
    func getBoardValue() -> Float {
        return Float(data.values.map { $0.value }.reduce(0, { x, y in x+y }))
    }
    
    func getKingPosition(for color: Color) -> Space? {
        let spaces = getSpaces(with: color)
        guard let kingPosition = (spaces.filter{ data[$0] == (color == .white ? Piece.whiteKing : Piece.blackKing) }.first) else {
            return nil
        }
        return kingPosition
    }
    
    static func getPawnMoves(at space: Space, color: Color) -> Set<Space> {
        let square = Constants.squares[space]
        let adjacentSpaces = square.adjacentSpaces
        var validSpaces = Set<Space>()
        
        let rank = square.rank
        let file = square.file
        
        switch color {
        case .black:
            validSpaces = Set(adjacentSpaces.filter { Constants.squares[$0].rank.rawValue < rank.rawValue })
            if rank == ._7 {
                validSpaces.insert(Space(rank: ._5, file: file))
            }
        case .white:
            validSpaces = Set(adjacentSpaces.filter { Constants.squares[$0].rank.rawValue > rank.rawValue })
            if rank == ._2 {
                validSpaces.insert(Space(rank: ._4, file: file))
            }
        }
        
        return validSpaces
    }

    func getPiece(at space: Space) -> Piece? {
        return data[space]
    }
    
    func getPieces(at rank: Rank) -> [Piece?] {
        let squares = Constants.squares
        let spaces = Constants.ranks[rank].sorted {
            squares[$0].file.rawValue < squares[$1].file.rawValue
        }
        return spaces.map{ getPiece(at: $0) }
    }

    var spaces = [String:Set<Space>]()
    func getPossibleSpaces(at space: Space) -> Set<Space>? {
        guard let piece = getPiece(at: space) else { return nil }
        
        let key = piece.rawValue + space.rawValue
        
        if let value = spaces[key] {
            return value
        }
        
        let squares = Constants.squares
        switch piece {
        case .whitePawn, .blackPawn:
            spaces[key] = Board.getPawnMoves(at: space, color: piece.color)
        case .whiteKnight, .blackKnight:
            spaces[key] = squares[space].knightMoves
        case .whiteBishop, .blackBishop:
            spaces[key] = squares[space].diagonalSpaces
        case .whiteRook, .blackRook:
            spaces[key] = squares[space].fileSpaces.union(squares[space].rankSpaces)
        case .whiteQueen, .blackQueen:
            spaces[key] = squares[space].fileSpaces.union(squares[space].rankSpaces).union(squares[space].diagonalSpaces)
        case .whiteKing:
            spaces[key] = squares[space].adjacentSpaces.union(castleOptions.map { $0.king.to }.filter {
                squares[$0].rank == ._1 })
        case .blackKing:
            spaces[key] = squares[space].adjacentSpaces.union(castleOptions.map { $0.king.to }.filter {
                squares[$0].rank == ._8 })
        }
        
        return spaces[key]
    }

    func getSpaces(with color: Color?) -> [Space] {
        return data.filter { $0.value.color == color }.map { $0.key }
    }

    func getValidMoves() -> [Move] {
        let spaces = getSpaces(with: color)
        return getValidMoves(for: spaces, with: color)
    }
    
    func getValidMoves(for space: Space) -> [Move] {
        guard let piece = getPiece(at: space) else { return [] }
        return getValidMoves(for: [space], with: piece.color)
    }
    
    var possibleMoves = [String:[Move]]()
    func getValidMoves(for spaces: [Space], with color: Color) -> [Move] {
        validMoves.removeAll()
        possibleChecks.removeAll()
        guard isCheckmatePossible() else { return [] }
        
        var moves = [Move]()
        for space in spaces {
            let key = space.rawValue + getPiece(at: space)!.rawValue
            if let possibleMoves = possibleMoves[key] {
                moves += possibleMoves
            } else {
                possibleMoves[key] = getPossibleSpaces(at: space)!.map {
                    Move(from: space, to: $0)
                }
                moves += possibleMoves[key]!
            }
        }
        return moves.filter { isValidMove($0) }
    }

    var possibleChecks = [Space: [Move]]()
    func getPossibleChecks(for color: Color) -> [Move] {
        guard let kingPosition = getKingPosition(for: color) else {
            return []
        }
        
        if let possibleChecks = possibleChecks[kingPosition] {
            return possibleChecks
        }
        
        var checks = [Move]()
        let opponentSpaces = getSpaces(with: color.opposite)
        for space in opponentSpaces {
            guard getPossibleSpaces(at: space)?.contains(kingPosition) ?? false else {
                return []
            }
            
            if isValidMove(Move(from: space, to: kingPosition)) {
                checks.append(Move(from: space, to: kingPosition))
            }
        }
        
        possibleChecks[kingPosition] = checks
        
        return checks
    }
    
    func isInCheck(color: Color) -> Bool {
        return getPossibleChecks(for: color).count > 0
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
    
    func isPathClearBetween(_ move: Move) -> Bool {
        let squares = Constants.squares
        let squareFrom = squares[move.from]
        let squareTo = squares[move.to]
        let origin = squareFrom.index < squareTo.index ? move.from : move.to
        let destination = origin == move.from ? move.to : move.from
        
        let spaces: Set<Space>

        if squareFrom.rank == squareTo.rank {
            spaces = squareFrom.rankSpaces
        } else if squareFrom.file == squareTo.file {
            spaces = squareFrom.fileSpaces
        } else if let diagonal = squareFrom.diagonals.intersection(squareTo.diagonals).first {
            spaces = Diagonals.getSpaces(diagonal: diagonal)
        } else {
            return false
        }

        let originIndex = squares[origin].index
        let destinationIndex = squares[destination].index
        let isClear = spaces.filter { space in
            squares[space].index > originIndex
                && squares[space].index  < destinationIndex
                && !isEmpty(at: space)
            }.count == 0

        return isClear

    }
    
    func isPathClearBetween(from: Space, to: Space) -> Bool {
        return isPathClearBetween(Move(from: from, to: to))
    }
    
    var validMoves = [Move:Bool]()
    func isValidMove(_ move: Move) -> Bool {

        if let hasMove = validMoves[move] {
            return hasMove
        }
        
//        guard let piece = getPiece(at: move.from),
//            isEmpty(at: move.to) || isOccupiedByOpponent(at: move.to, myColor: piece.color) else {
//                validMoves[move] = false
//                return validMoves[move]!
//        }
        
        guard let piece = getPiece(at: move.from) else {
                validMoves[move] = false
                return validMoves[move]!
        }
        
        // TODO: investigate speed performance
//        if let toPiece = getPiece(at: move.to) {
//            if toPiece.color == color {
//                validMoves[move] = false
//                return validMoves[move]!
//            }
//        }

        return false
        



        let board = copy() as! Board
        
        let squares = Constants.squares
        let squareFrom = squares[move.from]
        let squareTo = squares[move.to]

        switch piece {
        case .blackPawn, .whitePawn:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                validMoves[move] = false
                return validMoves[move]!
            }

            guard move.to == enPassant
                || (squareFrom.file != squareTo.file && isOccupiedByOpponent(at: move.to, myColor: piece.color))
                || (squareFrom.file == squareTo.file && isEmpty(at: move.to)) else {
                validMoves[move] = false
                return validMoves[move]!
            }
            
            board.move(move)
            validMoves[move] = !board.isInCheck(color: color)
            return validMoves[move]!
            
        case .blackKnight, .whiteKnight:
            board.move(move)
            validMoves[move] = !board.isInCheck(color: color)
            return validMoves[move]!
            
        case .blackBishop, .whiteBishop, .blackRook, .whiteRook, .blackQueen, .whiteQueen:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                validMoves[move] = false
                return validMoves[move]!
            }
            
            board.move(move)
            validMoves[move] = !board.isInCheck(color: color)
            return validMoves[move]!
            
        case .blackKing, .whiteKing:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                validMoves[move] = false
                return validMoves[move]!
            }
            
            if abs(squareFrom.file.rawValue - squareTo.file.rawValue) == 2 {
                let rookMove: Move
                
                switch squareTo.file {
                case .g:
                    guard isValidMove(Move(from: move.from, to: Space(rank: squareTo.rank, file: .f))) else {
                        validMoves[move] = false
                        return validMoves[move]!
                    }
                    
                    rookMove = Move(from: Space(rank: squareTo.rank, file: .h),
                                    to: Space(rank: squareTo.rank, file: .f))
                    
                case .c:
                    guard isValidMove(Move(from: move.from, to: Space(rank: squareTo.rank, file: .d))) else {
                        validMoves[move] = false
                        return validMoves[move]!
                    }
                    
                    rookMove = Move(from: Space(rank: squareTo.rank, file: .a),
                                    to: Space(rank: squareTo.rank, file: .d))
                default: return false
                }
                
                if !isValidMove(rookMove) {
                    validMoves[move] = false
                    return validMoves[move]!
                }
            }
            
            board.move(move)
            validMoves[move] = !board.isInCheck(color: color)
            return validMoves[move]!
        }
    }

    func move(_ move: Move) {
        
        func enPassantCapture(_ space: Space) {
            let square = Constants.squares[space]
            if square.rank == ._3 {
                setSpace(Space(rank: ._4, file: square.file), to: nil)
            } else {
                setSpace(Space(rank: ._7, file: square.file), to: nil)
            }
        }

        guard var piece = getPiece(at: move.from) else {
            return
        }
        
        let currentEnPassant = enPassant
        
        enPassant = nil
        
        if !isEmpty(at: move.to) {
            halfMove = 0
        } else {
            halfMove += 1
        }
        
        let squares = Constants.squares
        let squareTo = squares[move.to]
        let squareFrom = squares[move.from]
        
        switch piece {
        case .whitePawn, .blackPawn:
            if move.to == currentEnPassant {
                enPassantCapture(move.to)
            } else if abs(squareTo.rank.rawValue - squareFrom.rank.rawValue) == 2 {
                switch piece.color {
                case .white: enPassant = Space(rank: squareTo.rank.previousRank, file: squareTo.file)
                case .black: enPassant = Space(rank: squareTo.rank.nextRank, file: squareTo.file)
                }
            } else if squareTo.rank == ._1 || squareTo.rank == ._8 {
                piece = choosePiece(color: color)
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
        case .blackKing:
            switch move {
            case CastleMoves.blackKingSide.king:
                self.move(CastleMoves.blackKingSide.rook)
            case CastleMoves.blackQueenSide.king:
                self.move(CastleMoves.blackQueenSide.rook)
            default:
                break
            }
            castleOptions = castleOptions.filter { squares[$0.king.to].rank == ._1 }
        case .whiteKing:
            switch move {
            case CastleMoves.whiteKingSide.king:
                self.move(CastleMoves.whiteKingSide.rook)
            case CastleMoves.whiteQueenSide.king:
                self.move(CastleMoves.whiteQueenSide.rook)
            default:
                break
            }
            castleOptions = castleOptions.filter { squares[$0.king.to].rank == ._8 }
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
        print( getPieces(at: rank).map { $0?.description ?? "[]" })
    }
    
    func setSpace(_ space: Space, to piece: Piece?) {
        data[space] = piece
    }
}

func == (lhs: Space, rhs: Space) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

func ~=(lhs: Move, rhs: Move) -> Bool {
    return lhs.from ~= rhs.from && lhs.to ~= rhs.to
}
