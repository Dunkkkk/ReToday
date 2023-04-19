import SwiftUI
import Photos
import Combine

struct AirPlaneView: View {
    
    @ObservedObject var viewmodel: AirPlaneViewModel
    @ObservedObject var beforeViewmodel: TicketViewmodel
    @State var keyboardHeight: CGFloat = 0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
      
            BackGroundView(newImage: $viewmodel.currentPhoto.image,
                           isClosed: $viewmodel.isWindowClose) {
                ZStack {
                    RoundedRectangle(cornerRadius: 269)
                        .frame(width: 639.19, height: 848.88)
                        .foregroundColor(.white)
                        .opacity(0.01)
                        .onTapGesture {
                            viewmodel.changeTheNewPicture = ()
                        }
                    VStack {
                        ZStack {
                            Image("RealTicket")
                            VStack {
                                VStack(spacing: 10) {
                                    Text("\(String(viewmodel.currentYear)) .\(viewmodel.currentDate.dateToYYMMDD().m) .\(viewmodel.currentDate.dateToYYMMDD().d)" )
                                        .foregroundColor(Color(hex: "#B1B1B1")!)
                                        .font(.system(size: 24, weight: .bold, design: .default))
                                        .offset(y: -10)
                                    Text("")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24, weight: .bold, design: .default))
                                }
                                .offset(x: 14)
                            }
                            .onTapGesture {
                                beforeViewmodel.showDropdown = false
                                beforeViewmodel.sideTicketOffset = -5
                                beforeViewmodel.sideTicketOpacity = 1.0
                                beforeViewmodel.goNextView = false
                                beforeViewmodel.lineAnimation = false
                                presentationMode.wrappedValue.dismiss()
                            }
                            HStack {
                                Spacer()
                                Image("cloudUp1")
                                    .offset(x: 100, y: 100)
                            }
                        }
                        .offset(y: 30)
                        
                        Spacer()
                        VStack(spacing: 100) {
                            HStack {
                                Image("cloudUp1")
                                    .offset(x: -150)
                                Spacer()
                            }
                            ZStack {
                                Image("bottom")
                                VStack {
                                    ZStack {
                                        HStack(spacing: 30) {
                                            
                                            VStack {
                                                ZStack {
                                                    Image("imoticon 1")
                                                    HStack(spacing: 30) {
                                                        emoticons
                                                    }
                                                    .offset(y: -5)
                                                }
                                                .offset(x: 140, y:-30)
                                                .opacity(viewmodel.isCommentShowing ? 1 : 0.001)
                                                Image(viewmodel.isCommentShowing ? "Journalyellow" : "Journal")
                                                    .onTapGesture {
                                                        withAnimation {
                                                            viewmodel.isCommentShowing.toggle()
                                                        }
                                                    }
                                                    .offset(y: 5)
                                            }
                                            .offset(x:-117, y: -50)
                                            Spacer()
                                            Image(viewmodel.isCloudShowing ? "cloudblue" : "cloud")
                                                .brightness(viewmodel.isCommentShowing ? -0.3 : 0)
                                                .onTapGesture {
                                                    if !viewmodel.isCommentShowing {
                                                        withAnimation {
                                                            viewmodel.isCloudShowing.toggle()
                                                        }
                                                    }
                                                }
                                            Image(viewmodel.currentPhoto.hasHeart ? "Heartred" : "Heart")
                                                .onTapGesture { viewmodel.tapHeart.toggle() }
                                        }
                                        .offset(x: -10)
                                        if viewmodel.currentPhoto.hasCommnet == "" {
                                            TextField(text: $viewmodel.comment, prompt: Text("Add Comment")) {
                                                RoundedRectangle(cornerRadius: 15)
                                            }
                                            .frame(width: 800, height: 100)
                                            .offset(x: 19, y: 90)
                                        }
                                        else {
                                            Text(viewmodel.currentPhoto.hasCommnet)
                                                .frame(width: 800, height: 100)
                                                .offset(y: 90)
                                                .onTapGesture {
                                                    viewmodel.tapEdit = ()
                                                }
                                        }
                                        Image("Send")
                                            .offset(x: 370, y: 120)
                                            .onTapGesture {
                                                viewmodel.addComment = true
                                            }
                                    }
                                    .padding(.leading, 130)
                                    .padding(.trailing, 130)
                                    .offset(y: -55)
                                }
                            }
                        }
                        .offset(y: viewmodel.isCommentShowing ? -24 - keyboardHeight : 100)
                        .animation(.linear(duration: 0.5), value: viewmodel.addComment)
                        .onReceive(Publishers.keyboardHeight) { height in
                            withAnimation {
                                print(height)
                                if height == 0.0 {
                                    keyboardHeight = 0
                                }
                                else {
                                    self.keyboardHeight = height - 130
                                }
                            }
                        }
                        
                    }
                    if viewmodel.isCloudShowing {
                        ZStack {
                            ImageClouds(todayPhotos: viewmodel.cloudPhotos, animationStart: viewmodel.isCloudShowing){ selectedPhoto, idl in
                                
                                withAnimation {
                                    self.viewmodel.isCloudShowing = false
                                    self.viewmodel.isCommentShowing = true
                                }
                                let index = viewmodel.currentPhotos.firstIndex(where: { $0.id == "\(idl)"})!
                                
                                self.viewmodel.currentPhoto = viewmodel.currentPhotos[index]
                                
                                self.viewmodel.currentPhotsIndex = index
                                
                            }
                        }
                        
                    }
                }
                
            }
                           .navigationBarBackButtonHidden(true)
                           .onAppear{
                               viewmodel.appearYes() {
                                   print("temp")
                                   print(viewmodel.currentPhotos.first?.image)
                               }
                               
                           }
        
    }
    
    @ViewBuilder
    var emoticons: some View {
        ForEach(emoticon.allCases, id: \.id) { item in
            if item != .none {
                Image(item.image)
                    .onTapGesture {
                        viewmodel.emoticon = item
                    }
                    .opacity(emoticonOpcity(item: item))
                    .id(item.id)
            }
        }
    }
    
    func emoticonOpcity(item: emoticon) -> Double {
        if viewmodel.emoticon == item || viewmodel.emoticon == .none {
            return 1
        }
        return 0.4
    }
}
