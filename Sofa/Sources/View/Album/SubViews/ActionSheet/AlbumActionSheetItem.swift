//
//  AlbumActionSheetItem.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/08.
//

import SwiftUI

public struct ActionSheetCardItem: View {
  let id = UUID()
  let systemIconName: String?
  let iconSize: CGFloat?
  let iconVerticalPadding: CGFloat?
  let iconLeadingPadding: CGFloat?
  let iconTrailingPadding: CGFloat?
  let label: String
  let foregrounColor: Color
  let foregroundInactiveColor: Color
  let callback: (() -> ())?
  
  public init(
    systemIconName: String? = nil,
    iconSize: CGFloat? = nil,
    iconVerticalPadding: CGFloat? = nil,
    iconLeadingPadding: CGFloat? = nil,
    iconTrailingPadding: CGFloat? = nil,
    label: String,
    foregrounColor: Color = Color.black,
    foregroundInactiveColor: Color = Color.black,
    callback: (() -> ())? = nil
  ) {
    self.systemIconName = systemIconName
    self.iconSize = iconSize
    self.iconVerticalPadding = iconVerticalPadding
    self.iconLeadingPadding = iconLeadingPadding
    self.iconTrailingPadding = iconTrailingPadding
    self.label = label
    self.foregrounColor = foregrounColor
    self.foregroundInactiveColor = foregroundInactiveColor
    self.callback = callback
  }
  
  var icon: some View {
    Group {
      if let sfSymbolName = systemIconName {
        Image(systemName: sfSymbolName)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: iconSize ?? 24, height: iconSize ?? 24)
          .padding(.vertical, iconVerticalPadding)
          .padding(.leading, iconLeadingPadding ?? 32)
          .padding(.trailing, iconTrailingPadding ?? 10)
      }
    }
  }
  
  var buttonView: some View {
    HStack(spacing: 0) {
      icon
      Text(label)
        .font(.custom("Pretendard-Medium", size: 16))
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

struct ActionSheetCardItem_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      VStack(spacing: 0) {
        ActionSheetCardItem(systemIconName: "photo", label: "사진")
        ActionSheetCardItem(systemIconName: "camera", label: "카메라")
        ActionSheetCardItem(systemIconName: "waveform", label: "녹음")
      }
      .background(Color.white)
    }
    .background(Color.gray)
  }
}
