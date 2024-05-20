import Foundation
import SwiftUI
import Combine

struct OnboardingView: View {
    var images: [String] = ["first", "second", "third", "fourth", "last"]
    var goToAddScreen: () -> Void
    
    @State private var currentPage: Int = 0
    @ObservedObject var countTimer: CountTimer = CountTimer(items: 5, interval: 8.0)
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image(self.images[self.currentPage])
                    .resizable()
                    .padding(.top, 30)
                    .padding(.bottom, 5)
                    .padding()
                
                HStack(alignment: .center, spacing: 4) {
                    ForEach(self.images.indices, id: \.self) { image in
                        LoadingBar(progress: min(max(CGFloat(self.countTimer.progress) - CGFloat(image), 0.0), 1.0))
                            .frame(width: nil, height: 2, alignment: .leading)
                            .animation(.linear)
                    }
                }
                .padding()
                
                HStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.countTimer.advancePage(by: -1)
                            self.currentPage = self.countTimer.currentPage
                        }
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.countTimer.advancePage(by: 1)
                            self.currentPage = self.countTimer.currentPage
                        }
                }
                
                if currentPage == 0 {
                    VStack{
                        Spacer()
                        Button {
                            withAnimation(.snappy) {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            VStack {
                                Text("Пропустить")
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 175, height: 60)
                            .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                            .clipShape(.buttonBorder)
                        }
                    }
                }
                
                if currentPage == 4 {
                    VStack{
                        Spacer()
                        Button {
                            withAnimation(.snappy) {
                                self.presentationMode.wrappedValue.dismiss()
                                goToAddScreen()
                            }
                        } label: {
                            VStack {
                                Text("Добавить авто")
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 175, height: 60)
                            .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                            .clipShape(.buttonBorder)
                        }
                    }
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        self.countTimer.pause()
                    }
                    .onEnded { _ in
                        self.countTimer.resume()
                    }
            )
            .onAppear {
                self.countTimer.start()
                self.currentPage = self.countTimer.currentPage
            }
            .onReceive(self.countTimer.$progress) { progress in
                self.currentPage = self.countTimer.currentPage
            }
        }
        .background(Color(red: 0.76, green: 0.77, blue: 0.78))
    }
}
