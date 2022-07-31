//
//  ModalView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/05.
//

import SwiftUI
import SwiftUIPager

struct HistoryView: View {
  
  @Binding var isShowing: Bool
  @State private var isDragging = false
  
  @State private var curHeight: CGFloat = 400
  let minHeight: CGFloat = Screen.maxHeight / 2
  let maxHeight: CGFloat = Screen.maxHeight * 0.9
  
  var body: some View {
    ZStack(alignment: .bottom){
      if isShowing{
        VStack {
          Color.black
            .opacity(0)
        }
        .contentShape(Rectangle())
        .onTapGesture {
          self.isShowing = false
        }
        mainView
          .transition(.move(edge: .bottom))
          .onAppear{
//            UITabBar.hideTabBar(animated: false)
            self.animationFlag = true
            self.page.index = 0 // 처음 시작은 무조건 0번째부터
            
          }
          .onDisappear{
//            UITabBar.showTabBar(animated: true)
            self.page.index = 0 // 처음 시작은 무조건 0번째부터
          }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    .ignoresSafeArea()
    .animation(.easeInOut)
  }
  
  
  //MARK: - mainView
  @StateObject var page: Page = .first()
  @ObservedObject var historyViewModel = HistoryViewModel()
  @State private var animationFlag = true // 하단 Pager 버튼 Animation Control
  
  var numbers: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  
  var mainView: some View{
    VStack(alignment: .center) {
      
      ZStack(alignment: .center){
        Capsule()
          .frame(width: 48, height: 4)
          .foregroundColor(Color.black)
          .opacity(0.24)
      }
      .frame(height: 20)
      .frame(maxWidth: .infinity)
      .background(Color.white.opacity(0.00001))
      .gesture(dragGesture)
      
      ZStack(alignment: .center){
        VStack{
          HStack(alignment: .top){
            Image("lionprofile")
              .resizable()
              .frame(width: 51, height: 52.5)
              .padding(EdgeInsets(top: 10.5, leading: 14.5, bottom: 0, trailing: 8))
            VStack(alignment: .leading){
              HStack(alignment: .center){
                Text("\(historyViewModel.info.nickname)")
                  .font(.custom("Pretendard-Bold", size: 13))
                  .padding(EdgeInsets(top: 12, leading: 0, bottom: 4, trailing: 1))
                Text("\(historyViewModel.info.roleInFamily)")
                  .font(.custom("Pretendard-Medium", size: 12))
                  .padding(EdgeInsets(top: 1, leading: 8, bottom: 1, trailing: 8))
                  .background(Color(hex: "E8F5E9"))
                  .foregroundColor(Color(hex: "43A047"))
                  .cornerRadius(4)
                  .padding(EdgeInsets(top: 12, leading: 0, bottom: 4, trailing: 0))
                Spacer()
                if historyViewModel.history.count > 0{
                  Text("\(historyViewModel.history[page.index].descriptionDate)")
                    .font(.custom("Pretendard-Medium", size: 13))
                    .foregroundColor(Color(hex: "979696"))
                    .padding(.horizontal, 8)
                    .background(Color(hex: "F1F1F1"))
                    .cornerRadius(80)
                    .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
                }

                
              }
              .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 14.5))
            }// VStack
          }// HStack
          Divider()
            .overlay(Color(hex: "EDEADF"))
            .offset(x:0, y: 0)
          if historyViewModel.history.count == 0{
            VStack{
              Text("아직 인사를 건네기 전이에요.")
                .foregroundColor(Color.black).opacity(0.4)
                .font(.custom("Pretendard-Medium", size: 14))
                .padding(.top, 16)
              Spacer()
            }
          }
          //MARK: - Pager
          VStack{
            Pager(page: self.page,
                  data: self.historyViewModel.history.indices,
                  id: \.self) { index in
              
              self.pageView(historyViewModel.history[index])
              
            }
                  .contentLoadingPolicy(.eager)
            //                  .itemSpacing(10)
          }
          .offset(x: 0, y: 16)
          
          if historyViewModel.history.count > 0{
            HStack(alignment: .center){
              Button {
                withAnimation {
                  self.page.update(.previous)
                  self.animationFlag = false
                }
              } label: {
                Image(systemName: "chevron.left")
                  .font(.system(size: 20))
                  .foregroundColor(self.page.index <= 0 ? Color(hex: "C2C1C1"): Color(hex: "121619"))
              }
              
              Spacer()
              

              HStack{
                if !animationFlag{
                  Group{
                    Text("\(self.page.index+1)")
                    Text("/")
                      .foregroundColor(Color(hex: "C2C1C1"))
                    Text("\(historyViewModel.history.count)")
                      .foregroundColor(Color(hex: "C2C1C1"))
                  }
                  .font(.custom("Pretendard-Medium", size: 20))
                  .animationsDisabled()
                }else{
                  Group{
                    Text("\(self.page.index+1)")
                    Text("/")
                      .foregroundColor(Color(hex: "C2C1C1"))
                    Text("\(historyViewModel.history.count)")
                      .foregroundColor(Color(hex: "C2C1C1"))
                  }
                  .font(.custom("Pretendard-Medium", size: 20))
                }
                
              }

              
              Spacer()
              
              Button {
                withAnimation {
                  self.page.update(.next)
                  self.animationFlag = false
                }
              } label: {
                Image(systemName: "chevron.right")
                  .font(.system(size: 20))
                  .foregroundColor(self.page.index >= self.historyViewModel.history.count - 1 ? Color(hex: "C2C1C1"): Color(hex: "121619"))
              }
              
            }// Page Button
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
          }
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
        Rectangle()
          .cornerRadius(20, corners: [.topLeft, .topRight])
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
  func pageView(_ history: History) -> some View {
    Rectangle()
      .overlay(
        VStack(alignment: .center){
          Text("\(history.descriptionContent)")
            .font(.custom("Pretendard-Medium", size: 16))
            .foregroundColor(Color.black)
            .padding(.horizontal, 25)
          
          Spacer()
        }
      )
      .foregroundColor(Color.white)
      
  }
  
}

struct ModalView_Previews: PreviewProvider {
  static var previews: some View {
    HistoryView(isShowing: .constant(true))
  }
}
