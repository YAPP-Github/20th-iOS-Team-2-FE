//
//  ModalView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/05.
//

import SwiftUI
import SwiftUIPager

struct ModalView: View {
  
  @Binding var isShowing: Bool
  @State private var isDragging = false
  
  @State private var curHeight: CGFloat = 400
  let minHeight: CGFloat = Screen.maxHeight / 2
  let maxHeight: CGFloat = Screen.maxHeight * 0.9
  
  
  
  var body: some View {
    ZStack(alignment: .bottom){
      if isShowing{
        Color.black
          .opacity(0.7)
          .onTapGesture {
            isShowing = false
          }
        mainView
          .transition(.move(edge: .bottom))
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    .ignoresSafeArea()
    .animation(.easeInOut)
  }
  
  
  //MARK: -mainView
  @StateObject var page: Page = .first()
  var numbers: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  
  var mainView: some View{
    VStack(alignment: .center) {
      
      ZStack(alignment: .center){
        Capsule()
          .frame(width: 48, height: 4)
          .foregroundColor(Color.black)
          .opacity(0.24)
      }
      .frame(height: 40)
      .frame(maxWidth: .infinity)
      .background(Color.white.opacity(0.00001))
      .gesture(dragGesture)
      
      ZStack(alignment: .center){
        VStack{
          HStack(alignment: .top){
            Image("lionprofile")
              .frame(width: 51, height: 52.5)
              .padding(EdgeInsets(top: 10.5, leading: 10.5, bottom: 27, trailing: 14.5))
            VStack(alignment: .leading){
              HStack(alignment: .center){
                Text("별명")
                  .font(.custom("Pretendard-Bold", size: 13))
                  .padding(EdgeInsets(top: 12, leading: 0, bottom: 4, trailing: 1))
                Text("관계")
                  .font(.custom("Pretendard-Medium", size: 12))
                  .padding(EdgeInsets(top: 1, leading: 8, bottom: 1, trailing: 8))
                  .background(Color(hex: "E8F5E9"))
                  .foregroundColor(Color(hex: "43A047"))
                  .cornerRadius(4)
                  .padding(EdgeInsets(top: 12, leading: 0, bottom: 4, trailing: 0))
                Spacer()
                Text("2022-12-25")
                  .font(.custom("Pretendard-Medium", size: 13))
                  .foregroundColor(Color(hex: "979696"))
                  .padding(.horizontal, 8)
                  .background(Color(hex: "F1F1F1"))
                  .cornerRadius(80)
                  .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
                
              }
              .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
            }// VStack
          }// HStack
          Divider()
            .overlay(Color(hex: "EDEADF"))
            .offset(x:0, y: -30)
          //MARK: - Pager
          VStack{
            Pager(page: self.page,
                  data: self.numbers,
                  id: \.self) {
              self.pageView($0)

            }
                  .contentLoadingPolicy(.eager)
//                  .itemSpacing(10)
          }
          .offset(x: 0, y: -20)
          HStack(alignment: .center){
            Button {
              print("left")
              withAnimation {
                  self.page.update(.previous)
              }
            } label: {
              Image(systemName: "chevron.left")
                .font(.system(size: 20))
                .foregroundColor(self.page.index <= 0 ? Color(hex: "C2C1C1"): Color(hex: "121619"))
            }
            
            Spacer()
            
//            Text("\(self.page.index + 1) / \(numbers.count)")
//              .font(.custom("Pretendard-Medium", size: 20))
            HStack{
              Group{
                Text("\(self.page.index+1)")
                Text("/")
                  .foregroundColor(Color(hex: "C2C1C1"))
                Text("\(numbers.count)")
                  .foregroundColor(Color(hex: "C2C1C1"))
              }
              .font(.custom("Pretendard-Medium", size: 20))
              .animationsDisabled()
            }
            
            Spacer()
            
            Button {
              print("right")
              withAnimation {
                  self.page.update(.next)
              }
            } label: {
              Image(systemName: "chevron.right")
                .font(.system(size: 20))
                .foregroundColor(self.page.index >= self.numbers.count - 1 ? Color(hex: "C2C1C1"): Color(hex: "121619"))
            }
            
          }// Page Button
          .padding(.vertical, 16)
          .padding(.horizontal, 24)
          Spacer()
            .frame(height: 34)
        }//VStack

        
      }
      .frame(maxHeight: .infinity)
    }
    .frame(height: curHeight)
    .frame(maxWidth: .infinity)
    .background(
      ZStack{
        RoundedRectangle(cornerRadius: 20)
        Rectangle()
          .frame(height: curHeight / 2)
      }
        .foregroundColor(.white)
    )
    .animation(isDragging ? nil : .easeInOut(duration: 0.45))
  }
  
  @State private var prevDragTranslation = CGSize.zero
  
  var dragGesture: some Gesture{
    DragGesture(minimumDistance: 0, coordinateSpace: .global)
      .onChanged { val in
        if !isDragging {
          isDragging = true
        }
        
        let dragAmount = val.translation.height - prevDragTranslation.height
        
        if curHeight > maxHeight || curHeight < minHeight{
          curHeight -= dragAmount / 6
        }
        else{
          curHeight -= dragAmount
        }
        
        prevDragTranslation = val.translation
      }
      .onEnded { val in
        prevDragTranslation = .zero
        isDragging = false
        if curHeight > minHeight + 35 {
          curHeight = maxHeight
        }
        else if curHeight < minHeight - 35{
          isShowing = false
          curHeight = minHeight
        }
        else{
          curHeight = minHeight
        }
      }
  }
  
  //MARK: - pageView
  func pageView(_ number: Int) -> some View {
    Rectangle()
      .overlay(
        VStack{
          Text("\(number) \(number) \(number) \(number) 지구는 우리 은하의 오리온자리 나선팔에 위치한 태양계를 구성하는 행성 중 하나로, 태양의 세 번째 궤도를 돌고 있다. 현재까지 과학적으로 알려진 바로는, 생명체와 지성체가 세운 문명이 존재하는 것이 입증된 유일한 천체로 인류가 살아 숨쉬다.")
            .font(.custom("Pretendard-Medium", size: 16))
            .foregroundColor(Color.black)
            .padding(.horizontal, 26)

          Spacer()
        }
      )
      .foregroundColor(Color.white)

  }
  
}

struct ModalView_Previews: PreviewProvider {
  static var previews: some View {
    ModalView(isShowing: .constant(true))
  }
}
