//
//  WelcomeView.swift
//  
//
//  Created by changgyo seo on 2023/04/16.
//

import SwiftUI

struct WelcomeView: View {
    
    @State var didLoad: Bool = false
    @State var onTap: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image("airplane window")
                Image("background1")
                Image("cloudUp1")
                    .position(x: didLoad ? 0 : 965, y: 233)
                    .animation(.linear(duration: 30).repeatForever(), value: didLoad)
                    .onTapGesture {
                        print("k")
                    }

                Image("cloudUp1")
                    .position(x: didLoad ? 1024 : 0, y: 1055)
                    .animation(.linear(duration: 30).repeatForever(), value: didLoad)
                    .onTapGesture {
                        print("s")
                    }

                VStack {
                    Image("logologo")
                    Spacer()
                    Image("welcomeWord")
                        .opacity(didLoad ? 1 : 0)
                        .animation(.linear(duration: 1).repeatForever(), value: didLoad)

                }
                .padding(.top, 114.62)
                .padding(.bottom, 129.82)
                if onTap {
                    TicketView()
                        .ignoresSafeArea()
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                }
            }
        }
        .onTapGesture {
            if !onTap {
                onTap.toggle()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            didLoad.toggle()
             
        }
    }
}

public struct section: View {
    
    @Binding var selectedYear: Int
    
    struct SectionHeader: View {
        let title: String
        var body: some View {
            Text(title)
        }
    }
    
    public var body: some View {
        List {
            Section(header: SectionHeader(title: "Year")) {
                ForEach(0...22, id: \.self) { index in
                    Text(String(2022 - index ))
                        .onTapGesture {
                            selectedYear = 2022 - index
                        }
                }
            }
        }
        .cornerRadius(20)
        .listStyle(PlainListStyle())
        .padding()
    }
}


struct previewwe: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
