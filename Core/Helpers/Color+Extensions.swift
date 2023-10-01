//
//  Color+Extensions.swift
//  Core
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

extension Color {
    static var random: Self {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
