//
//  AlbumActionSheetCard.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/09.
//

import SwiftUI
import Combine

public struct ActionSheetCard: View {
  @State var offset = Screen.maxHeight
  @Binding var isShowing: Bool
  @State var isDragging = false
  
  var items: [ActionSheetCardItem]
  var itemCount: Int = 0
  let heightToDisappear = Screen.maxHeight
  let cellHeight: CGFloat = 50
  let backgroundColor: Color
  let outOfFocusOpacity: CGFloat
  let minimumDragDistanceToHide: CGFloat
  let itemsSpacing: CGFloat
  
  public init(
    isShowing: Binding<Bool>,
    items: [ActionSheetCardItem],
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
    UITabBar.hideTabBar()
  }
  
  var topHalfMiddleBar: some View {
    Capsule()
      .frame(width: 36, height: 5)
      .foregroundColor(Color.black) // 색상
      .padding(.vertical, 5.5)
      .opacity(0.2)
  }
  
  var itemsView: some View {
    VStack (spacing: itemsSpacing){
      ForEach(0..<3) { index in
        
        items[index]
          .frame(height: cellHeight)
        
        Divider() // 구분선 넣기
      }
      Text("").frame(height: 40) // Extra empty space
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
  
  var outOfFocusArea: some View {
    Group {
      if isShowing {
        GreyOutOfFocusView(opacity: outOfFocusOpacity) {
          UITabBar.toogleTabBarVisibility()
          self.isShowing = false
        }
      }
    }
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
      .cornerRadius(15)
      .offset(y: offset)
      .gesture(interactiveGesture)
      .onTapGesture {
        hide()
      }
    }
  }
  
  var bodyContet: some View {
    ZStack {
      outOfFocusArea
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

struct ActionSheetCard_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      ActionSheetCard(isShowing: .constant(true),
                      items: [
                        ActionSheetCardItem(systemIconName: "photo", label: "사진"),
                        ActionSheetCardItem(systemIconName: "camera", label: "카메라"),
                        ActionSheetCardItem(systemIconName: "waveform", label: "녹음")
                      ],
                      outOfFocusOpacity: 0.2
      )
    }
  }
}
