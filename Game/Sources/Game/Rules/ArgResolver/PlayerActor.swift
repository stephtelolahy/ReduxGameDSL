//
//  PlayerActor.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

let playerActor: ArgPlayerResolver
= { _, _, ctx in
    .identified([ctx.actor])
}
