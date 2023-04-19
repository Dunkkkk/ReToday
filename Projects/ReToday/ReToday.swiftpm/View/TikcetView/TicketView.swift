//
//  TicketView.swift
//  
//
//  Created by changgyo seo on 2023/04/16.
//

import SwiftUI
import Combine

struct TicketView: View {
    
    @ObservedObject var viewmodel: TicketViewmodel = TicketViewmodel()
    
    var time  = Date()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("airplane window")
                Image("background")
                VStack {
                    Image("Where you go_")
                    Spacer()
                    Image("If you're ready for the trip, tear up your ticket")
                }
                .padding(.top, 114.62)
                .padding(.bottom, 129.82)
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.24)
                
                ZStack {
                    HStack(spacing: 0) {
                        ZStack {
                            Image("big ticket")
                            Text("\(time.dateToYYMMDD().y).\(time.dateToYYMMDD().m).\(time.dateToYYMMDD().d)")
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .foregroundColor(Color(hex: "#B1B1B1")!)
                                .offset(x: 50,y: -90)
                            
                            HStack {
                                Text(String(viewmodel.selectedYear))
                                    .font(.system(size: 48, weight: .bold, design: .default))
                                    .foregroundColor(Color(hex: "#868686")!)
                                
                                Image("Vector 1")
                                    .onTapGesture {
                                        withAnimation(.linear(duration: 1)) {
                                            viewmodel.showDropdown.toggle()
                                        }
                                    }
                                
                                Text(".\(time.dateToYYMMDD().m).\(time.dateToYYMMDD().d)")
                                    .font(.system(size: 48, weight: .bold, design: .default))
                                    .foregroundColor(Color(hex: "#868686")!)
                            }
                            .offset(x: 50)
                            Image("Line 3")
                                .offset(x: 312)
                                .opacity(viewmodel.lineAnimation ? 1 : 0)
                                .animation(.linear(duration: 1).repeatForever(), value: viewmodel.lineAnimation)
                                .onAppear { viewmodel.lineAnimation.toggle() }
                        }
                        ZStack{
                            Image("side ticket")
                            Text("MI " + "\(time.dateToYYMMDD().m)\(time.dateToYYMMDD().d)" )
                                .offset(y: 8)
                                .foregroundColor(Color(hex: "#B1B1B1")!)
                                .font(.system(size: 12, weight: .bold, design: .default))
                            Text("\(String(viewmodel.selectedYear)) .\(time.dateToYYMMDD().m) .\(time.dateToYYMMDD().d)")
                                .offset(y: 75)
                                .foregroundColor(Color(hex: "#B1B1B1")!)
                                .font(.system(size: 12, weight: .bold, design: .default))
                        }
                        .offset(x: -8, y: viewmodel.sideTicketOffset)
                        .opacity(viewmodel.sideTicketOpacity)
                        .gesture(
                            DragGesture()
                                .onChanged { g in
                                    if g.startLocation.y < g.location.y {
                                        viewmodel.sideTicketOffset += (g.location.y - g.startLocation.y) * 0.1
                                        viewmodel.sideTicketOpacity -= (g.location.y - g.startLocation.y) * 0.0001
                                        if viewmodel.sideTicketOffset > 100 {
                                            withAnimation(.linear(duration: 1.6)) {
                                                viewmodel.sideTicketOffset = 850
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.6){
                                                viewmodel.goNextView = true
                                            }
                                        }
                                    }
                                    else {
                                        viewmodel.sideTicketOffset -= (g.location.y - g.startLocation.y) * 0.1
                                        viewmodel.sideTicketOffset = max(viewmodel.sideTicketOffset, -5)
                                    }
                                }
                        )
                    }
                    if viewmodel.showDropdown {
                        section(selectedYear: $viewmodel.selectedYear)
                            .frame(width: 250, height: 495)
                            .offset(x: -30, y: 260)
                    }
                }
                NavigationLink(
                    destination: AirPlaneView(viewmodel: AirPlaneViewModel(year: viewmodel.selectedYear),beforeViewmodel: viewmodel),
                    isActive: $viewmodel.goNextView
                ) {
                    EmptyView()
                }
                
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

class TicketViewmodel: ObservableObject {
    
    var bag = Set<AnyCancellable>()
    
    @Published var selectedYear : Int = 2022
    @Published var showDropdown: Bool = false
    @Published var sideTicketOffset: CGFloat = -5
    @Published var sideTicketOpacity = 1.0
    @Published var goNextView: Bool = false
    @Published var lineAnimation = false
    
    init() {
        $selectedYear
            .eraseToAnyPublisher()
            .dropFirst()
            .sink { [weak self] year in
                guard let self = self else { return }
                
                print(year)
                
                self.showDropdown = false
            }
            .store(in: &bag)
    }
}
