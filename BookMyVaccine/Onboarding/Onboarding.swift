//
//  Onboarding.swift
//  BookMyVaccine
//
//  Created by Aviral Yadav on 21/02/21.
//

import SwiftUI

struct Onboarding: View {
    let titles = ["Map", "Choose", "Confirm", "Show QR Code"]
    let bodies = ["Select the nearest hospitals \n near you", "Choose your slot,date \n and your vaccine type","Confirm once you are finished \n Cheer up you're gonna get vaccinated", "Once Confirmed, we'll generate a QR code for you \n for contactless entry to your venue \n Yayy!!"]
    @State var slide = 0
    @ObservedObject var currentGiver: currentUser
    @Binding var login: Bool

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: Login(currentGiver: currentGiver, login: $login)) {
                        Text("Login")
                            .fontWeight(.bold)
                    }
                }.padding([.trailing, .top], 30)
                Spacer()
                if slide == 0 {
                    Rectangle().fill(Color.clear).frame(height: 60)
                    Text("HELLLOOOOO!!!!!")
                        .fontWeight(.bold)
                        .font(.body)
                        .padding(.bottom, 5)
                        .padding(.top,22)
                        .offset(y:90)
                    
                }
                else {
                Text(titles[slide-1])
                    .fontWeight(.heavy)
                    .font(.title)
                    .padding(.bottom, 20)
                Text(bodies[slide-1])
                    .fontWeight(.regular)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                }
                ImageSlider(slide: $slide).offset(y:-20)
                NavigationLink(destination: Register(currentGiver: currentGiver, login: $login)) {
                    HStack {
                        Text("Sign up")
                            .fontWeight(.heavy)
                            .frame(width: 210, height: 30, alignment: .center)
                            .foregroundColor(.white)
                            .padding(.all)
                            .background(Color.blue)
                            .cornerRadius(16)
                    }
                }
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct ImageSlider: View {
    @Binding var slide : Int
    var body: some View {
        ZStack {
            PagerView(pageCount: 5, currentIndex: $slide) {
            Image("bookmyvaccine")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
            Image("map")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
            Image("choose")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
            Image("confirm")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
            Image("qrcode")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
            }.frame(height: 350)
            VStack {
                Spacer()
                HeaderBar(capsuleColor: Color(hex: "#E8E8E8"), highlightColor: Color(hex: "#3E6E79"),slide: $slide, total: 5)
            }.frame(width: 350, height: 350)
        }
    }
}

struct PagerView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content

    @GestureState private var translation: CGFloat = 0

    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                self.content.frame(width: geometry.size.width)
            }
            .frame(width: geometry.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
            .offset(x: self.translation)
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }.onEnded { value in
                    let offset = value.translation.width / geometry.size.width
                    let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                    self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                }
            )
        }
    }
}
