//
//  Board.swift
//  Chess
//
//  Created by Jordan Doczy on 11/20/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import Foundation

typealias Move = (from: Space, to: Space)

class Board: NSCopying {
    
    private(set) var castleOptions = Set<CastleMoves>()
    private(set) var whitePieceLocations = Set<Space>()
    private(set) var blackPieceLocations = Set<Space>()
    private(set) var color: Color = .white
    private(set) var spaces:ArrayModel = ArrayModel() // [Space: Piece]()
    private(set) var enPassant: Space?
    private(set) var halfMove: Int = 0
    private(set) var fullMove: Int = 0

    init(spaces: [Space: Piece], castleOptions: Set<CastleMoves>, color: Color, enPassant: Space?, halfMove: Int, fullMove: Int) {
        // TODO: fix self.spaces = spaces
        self.enPassant = enPassant
        self.color = color
        self.castleOptions = castleOptions
        self.halfMove = halfMove
        self.fullMove = fullMove
        
        
        for space in spaces {
            setSpace(space.key, to: space.value)
        }
    }

    // TODO: update to allow choice
    func choosePiece(color: Color) -> Piece {
        return color == .white ? .whiteQueen : .blackQueen
    }
    
    func clear() {
        // TODO: fix spaces = [:]
        whitePieceLocations.removeAll()
        blackPieceLocations.removeAll()
        color = .white
        castleOptions = Set<CastleMoves>()
        enPassant = nil
    }

    func computerMove() {
        var currentValue = getBoardValue()
        let validMoves = getValidMoves()
        
        var bestMove = validMoves.randomElement()!
        
        for move in validMoves {
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
        //  TODO: fix      let copy = Board(spaces: spaces, castleOptions: castleOptions, color: color, enPassant: enPassant, halfMove: halfMove, fullMove: fullMove)
        let copy = Board(spaces: [:], castleOptions: castleOptions, color: color, enPassant: enPassant, halfMove: halfMove, fullMove: fullMove)
        return copy
    }
    
    func getBoardValue() -> Float {
        return 0 // TODO: fix Float(spaces.model.compactMap { $0 }.reduce(0, { x, y in x+y }))
    }
    
    func getKingPosition(for color: Color) -> Space? {
        let spacesOfColor = getSpaces(with: color)
        guard let kingPosition = (spacesOfColor.filter{ spaces[$0] == (color == .white ? Piece.whiteKing : Piece.blackKing) }.first) else {
            return nil
        }
        return kingPosition
    }

    func getPiece(at space: Space) -> Piece? {
        return spaces[space]
    }
    
    func getPieces(at rank: Rank) -> [Piece?] {
        let squares = Constants.squares
        let spaces = Constants.ranks[rank].sorted {
            squares[$0].file.rawValue < squares[$1].file.rawValue
        }
        return spaces.map{ getPiece(at: $0) }
    }
    
    var possibleChecks = [Space: [Move]]()
    func getPossibleChecks(for color: Color, at targetSpace: Space? = nil) -> [Move] {
        guard let targetSpace = targetSpace ?? getKingPosition(for: color) else {
            return []
        }
        
        if let possibleChecks = possibleChecks[targetSpace] {
            return possibleChecks
        }
        
        var checks = [Move]()
        let opponentSpaces = getSpaces(with: color.opposite)
        for space in opponentSpaces {
            let piece = getPiece(at: space)!
            let possibleSpaces = Board.getPossibleSpaces(for: piece, at: space)
            if isValidMove(for: piece, from: space, to: targetSpace, performIsInCheck: false, possibleSpaces: possibleSpaces) {
                let move = Move(from: space, to: targetSpace)
                checks.append(move)
            }
        }
        
        possibleChecks[targetSpace] = checks
        
        return checks
    }
    
    func getSpaces(with color: Color) -> Set<Space> {
        return color == .white ? whitePieceLocations : blackPieceLocations
    }
    
    func getValidMovesOptimized() -> [Move] {
        possibleChecks.removeAll()
        guard isCheckmatePossible() else { return [] }
        
        var validMoves = [Move]()
        let spaces = getSpaces(with: color)
        for space in spaces {
            let piece = getPiece(at: space)!
            let possibleSpaces = Board.getPossibleSpaces(for: piece, at: space)
            for possibleSpace in possibleSpaces {
                if isValidMove(for: piece, from: space, to: possibleSpace, performIsInCheck: true) {
                    validMoves.append((from: space, to: possibleSpace))
                }
            }
        }
        
        return validMoves
    }
    
    func getValidMoves(performIsInCheck: Bool = true) -> [Move] {
        let spaces = getSpaces(with: color)
        return getValidMoves(for: spaces, performIsInCheck: performIsInCheck)
    }
    
    func getValidMoves(for spaces: Set<Space>, performIsInCheck: Bool = true) -> [Move] {
        possibleChecks.removeAll()
        guard isCheckmatePossible() else { return [] }
        
        var validMoves = [Move]()
        for space in spaces {
            let moves = getValidMoves(for: space, performIsInCheck: performIsInCheck)
            validMoves += moves
        }
        
        return validMoves
    }
    
    func getValidMoves(for space: Space, performIsInCheck: Bool = true) -> [Move] {
        guard let piece = getPiece(at: space) else { return [] }
        return getValidMoves(for: piece, at: space, performIsInCheck: performIsInCheck)
    }
    
    func getValidMoves(for piece: Piece, at space: Space, performIsInCheck: Bool = true) -> [Move] {
        return getValidMoves(for: piece, at: space, with: Board.getPossibleSpaces(for: piece, at: space), performIsInCheck: performIsInCheck)
    }
    
    func getValidMoves(for piece: Piece, at space: Space, with possibleSpaces: Set<Space>, performIsInCheck: Bool = true) -> [Move] {
        var validMoves = [Move]()
        for possibleSpace in possibleSpaces {
            if isValidMove(for: piece, from: space, to: possibleSpace, performIsInCheck: performIsInCheck) {
                validMoves.append((from: space, to: possibleSpace))
            }
        }
        
        return validMoves
    }

    func isCheckmate() -> Bool {
        return getValidMoves().count == 0 && isInCheck(color: color)
    }
    
    func isCheckmatePossible() -> Bool {
        var whiteCount = 0
        var blackCount = 0
        
        for piece in spaces.model {
            if let piece = piece {
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
        }
        
        return false
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
    
    func isPathClearBetween(from: Space, to: Space) -> Bool {
        let squares = Constants.squares
        let squareFrom = squares[from]
        let squareTo = squares[to]
        let origin = squareFrom.index < squareTo.index ? from : to
        let destination = origin == from ? to : from
        
        var spaces: Set<Space>
        
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

    func isValidMove(for piece: Piece, from: Space, to: Space, performIsInCheck: Bool = true, possibleSpaces: Set<Space>? = nil) -> Bool {
        guard isEmpty(at: to) || isOccupiedByOpponent(at: to, myColor: piece.color) else {
            return false
        }

        if let possibleSpaces = possibleSpaces {
            guard possibleSpaces.contains(to) else {
                return false
            }
        }

        let squareFrom = Constants.squares[from]
        let squareTo = Constants.squares[to]

        // TODO: testing
        return true

        switch piece {
        case .blackPawn, .whitePawn:
            guard isPathClearBetween(from: from, to: to) else { return false }
            
            guard to == enPassant
                || (squareFrom.file != squareTo.file && isOccupiedByOpponent(at: to, myColor: piece.color))
                || (squareFrom.file == squareTo.file && isEmpty(at: to)) else {
                    return false
            }
        case .blackKnight, .whiteKnight:
            break
        case .blackBishop, .whiteBishop, .blackRook, .whiteRook, .blackQueen, .whiteQueen:
            guard isPathClearBetween(from: from, to: to) else { return false }
        case .blackKing, .whiteKing:
            guard isPathClearBetween(from: from, to: to) else { return false }
            
            if let castleMove = CastleMoves(from: from, to: to), castleOptions.contains(castleMove) {
                guard isValidMove(for: piece, from: from, to: castleMove.kingStep.to, performIsInCheck: performIsInCheck),
                    !isInCheck(color: color), // currently in check
                    isValidMove(for: piece.rookType!, from: castleMove.rook.from, to: castleMove.rook.to, performIsInCheck: performIsInCheck) else {
                        return false
                }
            }
        }
        
        if performIsInCheck { // test if will be in check
            let board = copy() as! Board
            board.move(from: from, to: to)
            return !board.isInCheck(color: color) // retain current color
        }
        
        return true
    }
    
    func move(from: Space, to: Space) {
        func enPassantCapture(_ space: Space) {
            let square = Constants.squares[space]
            if square.rank == ._3 {
                setSpace(Space(rank: ._4, file: square.file), to: nil)
            } else {
                setSpace(Space(rank: ._7, file: square.file), to: nil)
            }
        }
        
        guard var piece = getPiece(at: from) else {
            return
        }
        
        let currentEnPassant = enPassant
        
        enPassant = nil
        
        if !isEmpty(at: to) {
            halfMove = 0
        } else {
            halfMove += 1
        }
        
        let squares = Constants.squares
        let squareTo = squares[to]
        let squareFrom = squares[from]
        
        switch piece {
        case .whitePawn, .blackPawn:
            if to == currentEnPassant {
                enPassantCapture(to)
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
            switch from {
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
            switch Move(from: from, to: to) { // TODO: remove Move cast
            case CastleMoves.blackKingSide.king:
                self.move(CastleMoves.blackKingSide.rook)
            case CastleMoves.blackQueenSide.king:
                self.move(CastleMoves.blackQueenSide.rook)
            default:
                break
            }
            castleOptions = castleOptions.filter { squares[$0.king.to].rank == ._1 }
        case .whiteKing:
            switch Move(from: from, to: to) { // TODO: remove Move cast
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
        
        setSpace(to, to: piece)
        setSpace(from, to: nil)
        color = color.opposite
        
        if color == .white {
            fullMove += 1
        }
    }
    
    func move(_ move: Move) {
        self.move(from: move.from, to: move.to)
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

        if let color = piece?.color {
            switch color {
            case .white:
                whitePieceLocations.insert(space)
            case .black:
                blackPieceLocations.insert(space)
            }
        } else {
            whitePieceLocations.remove(space)
            blackPieceLocations.remove(space)
        }

        spaces[space] = piece
    }
}

extension Board {
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
    
    static func getPossibleSpaces(for piece: Piece, at space: Space) -> Set<Space> {
        
//        let squares = Constants.squares
//        let key = piece.rawValue + "\(space.rawValue)"
//
//        if let value = Constants.possibleSpaces[key] {
//            return value
//        }
        
        switch piece {
        case .whitePawn, .blackPawn:
            return Board.getPawnMoves(at: space, color: piece.color)
        case .whiteKnight, .blackKnight:
            return Constants.squares[space].knightSpaces
        case .whiteBishop, .blackBishop:
            return Constants.squares[space].diagonalSpaces
        case .whiteRook, .blackRook:
            let square = Constants.squares[space]
            return square.fileSpaces.union(square.rankSpaces)
        case .whiteQueen, .blackQueen:
            let square = Constants.squares[space]
            return square.fileSpaces.union(square.rankSpaces).union(square.diagonalSpaces)
        case .whiteKing:
            return Constants.squares[space].adjacentSpaces.union(CastleMoves.getSpaces(for: .white).king)
        case .blackKing:
            return Constants.squares[space].adjacentSpaces.union(CastleMoves.getSpaces(for: .black).king)
        }
        
        //return Constants.possibleSpaces[key]!
    }
    
    
    static func getPossibleSpaces2(for piece: Piece, at space: Space) -> Set<Int> {
        switch piece {
        case .whitePawn, .blackPawn:
            return Constants.squaresNormalized[space].adjacentSpaces
        case .whiteKnight, .blackKnight:
            return Constants.squaresNormalized[space].knightSpaces
        case .whiteBishop, .blackBishop:
            return Constants.squaresNormalized[space].diagonalSpaces
        case .whiteRook, .blackRook:
            return Constants.squaresNormalized[space].rookSpaces
        case .whiteQueen, .blackQueen:
            return Constants.squaresNormalized[space].queenSpaces
        case .whiteKing:
            return Constants.squaresNormalized[space].whiteKingSpaces
        case .blackKing:
            return Constants.squaresNormalized[space].blackKingSpaces
        }
    }
}

func == (lhs: Space, rhs: Space) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

func ~=(lhs: Move, rhs: Move) -> Bool {
    return lhs.from ~= rhs.from && lhs.to ~= rhs.to
}
