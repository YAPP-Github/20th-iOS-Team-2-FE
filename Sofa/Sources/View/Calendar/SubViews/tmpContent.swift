//
//  tmpContent.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/07.
//

import SwiftUI

struct tmpContent: View {

    @State var selection: String =  "#4CAF50"

    var body: some View {
        VStack {
            tmpView(selection: $selection)

            RoundedRectangle(cornerRadius: 25, style: .continuous)
            .fill(Color(hex: selection))
                .padding()
        }
    }
}

struct tmpContent_Previews: PreviewProvider {
    static var previews: some View {
        tmpContent()
    }
}
