//
//  RoleActionSheetItem.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/08.
//

import SwiftUI

public struct RoleActionSheetItem: View {
  let id = UUID()
  let label: String
  let labelFont: Font
  let foregrounColor: Color
  let foregroundInactiveColor: Color
  let callback: (() -> ())?
  
  public init(
    label: String,
    labelFont: Font = Font.system(size: 16, weight: .semibold),
    foregrounColor: Color = Color.black,
    foregroundInactiveColor: Color = Color.black,
    callback: (() -> ())? = nil
  ) {
    self.label = label
    self.labelFont = labelFont
    self.foregrounColor = foregrounColor
    self.foregroundInactiveColor = foregroundInactiveColor
    self.callback = callback
  }
  
  var buttonView: some View {
    HStack(spacing: 0) {
      Text(label)
        .font(labelFont)
        .padding(.leading, 32)
        .padding(.vertical, 12)
      Spacer()
    }
  }
  
  public var body: some View {
    Group {
      if let callback = callback {
        Button(action: {
          callback()
        }) {
          buttonView
            .foregroundColor(foregrounColor)
        }
      }
      else {
        buttonView
          .foregroundColor(foregroundInactiveColor)
      }
    }
  }
}

struct RoleActionSheetItem_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      VStack(spacing: 0) {
        RoleActionSheetItem(label: "아빠")
        RoleActionSheetItem(label: "엄마")
        RoleActionSheetItem(label: "할아버지")
        RoleActionSheetItem(label: "할머니")
        RoleActionSheetItem(label: "이들")
        RoleActionSheetItem(label: "딸")
        RoleActionSheetItem(label: "사위")
        RoleActionSheetItem(label: "며느리")
      }
      .background(Color.white)
    }
    .background(Color.gray)
  }
}

