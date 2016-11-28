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
        
        let board = Board(fen: "rnbqkbnr/pp1ppppp/8/2p5/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2") //rnb1kbnr/ppppqppp/8/8/8/4P3/PPPPNPPP/RNBQKB1R w KQkq e3 0 1
        let moves = board.getValidMoves().sorted { $0.from.rank.rawValue < $1.from.rank.rawValue }.sorted { $0.from.file.rawValue < $1.from.file.rawValue }
        print(moves)
        board.printBoard()
        //print("")
        //print(board.isInCheck())
        //print(board.isValidMove(Move(from: .e2, to: .f4), possibleMoves: nil))
    }
    
}

