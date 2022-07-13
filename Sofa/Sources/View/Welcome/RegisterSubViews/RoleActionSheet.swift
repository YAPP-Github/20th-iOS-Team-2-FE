//
//  RoleActionSheet.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/09.
//

import SwiftUI
import Combine

public struct RoleActionSheet: View {
  @State var offset = Screen.maxHeight
  @Binding var isShowing: Bool
  @State var isDragging = false
  
  var items: [RoleActionSheetItem]
  var itemCount: Int = 0
  let heightToDisappear = Screen.maxHeight
  let cellHeight: CGFloat = 50
  let backgroundColor: Color
  let outOfFocusOpacity: CGFloat
  let minimumDragDistanceToHide: CGFloat
  let itemsSpacing: CGFloat
  
  public init(
    isShowing: Binding<Bool>,
    items: [RoleActionSheetItem],
    backgroundColor: Color = Color.white,
    outOfFocusOpacity: CGFloat = 0.7,
    minimumDragDistanceToHide: CGFloat = 150,
    itemsSpacing: CGFloat = 0
  ) {
    _isShowing = isShowing
    self.items = items
    self.itemCount = items.count
    self.backgroundColor = backgroundColor
    self.outOfFocusOpacity = outOfFocusOpacity
    self.minimumDragDistanceToHide = minimumDragDistanceToHide
    self.itemsSpacing = itemsSpacing
  }
  
  func hide() {
    offset = heightToDisappear
    isDragging = false
    isShowing = false
  }
  
  var topHalfMiddleBar: some View {
    Capsule()
      .frame(width: 48, height: 4)
      .foregroundColor(Color.black) // 색상
      .padding(.top, 8)
      .opacity(0.24)
  }
  
  var itemsView: some View {
    VStack (spacing: itemsSpacing){
      ForEach(0..<8) { index in
        
        items[index]
          .frame(height: cellHeight)
        
        Divider() // 구분선
      }
      //Text("").frame(height: 40) // Extra empty space
    }
  }
  
  func dragGestureOnChange(_ value: DragGesture.Value) {
    isDragging = true
    if value.translation.height > 0 {
      offset = value.location.y
      let diff = abs(value.location.y - value.startLocation.y)
      
      let conditionOne = diff > minimumDragDistanceToHide
      let conditionTwo = value.location.y >= 200
      
      if conditionOne || conditionTwo {
        hide()
      }
    }
  }
  
  var interactiveGesture: some Gesture {
    DragGesture()
      .onChanged({ (value) in
        dragGestureOnChange(value)
      })
      .onEnded({ (value) in
        isDragging = false
      })
  }
  
  var sheetView: some View {
    VStack {
      Spacer()
      VStack {
        topHalfMiddleBar
        itemsView
        Text("").frame(height: 10) // empty space
      }
      .background(Color.white)
      .cornerRadius(16)
      .offset(y: offset)
      .gesture(interactiveGesture)
      .onTapGesture {
        hide()
      }
    }
  }
  
  var bodyContet: some View {
    ZStack {
      sheetView
    }
    .ignoresSafeArea()
  }
  
  func onUpdateIsShowing(_ isShowing: Bool) {
    if isShowing && isDragging {
      return
    }
    
    DispatchQueue.main.async {
      offset = isShowing ? 0 : heightToDisappear
    }
  }
  
  public var body: some View {
    Group {
      if isShowing {
        bodyContet
      }
    }
    .animation(.default)
    .onReceive(Just(isShowing), perform: { isShowing in
      onUpdateIsShowing(isShowing)
    })
  }
}

struct RoleActionSheet_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      RoleActionSheet(isShowing: .constant(true),
                      items: [
                        RoleActionSheetItem(label: "아빠"),
                        RoleActionSheetItem(label: "엄마"),
                        RoleActionSheetItem(label: "할아버지"),
                        RoleActionSheetItem(label: "할머니"),
                        RoleActionSheetItem(label: "이들"),
                        RoleActionSheetItem(label: "딸"),
                        RoleActionSheetItem(label: "사위"),
                        RoleActionSheetItem(label: "며느리")
                      ],
                      outOfFocusOpacity: 0.2
      )
    }
  }
}
