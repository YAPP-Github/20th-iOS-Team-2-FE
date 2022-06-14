//
//  View.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/14.
//

import Foundation
import SwiftUI

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View { // View의 일부분만 Corneradious를 줄 수 있는 Extension
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


