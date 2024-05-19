//
//  TutorialView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 25.02.2024.
//

import Foundation
import SwiftUI
import SafariServices


private let lessonsArray = [lessons1, lessons2, lessons3, lessons4, lessons5]
private let dtpArray = [lessons6, lessons7, lessons8, lessons9]

struct TutorialView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Руководство")
                        .foregroundStyle(.white)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    ScrollView {
                        VStack(spacing: 10) {
                            HStack{
                                Text("В случае ДТП")
                                    .foregroundStyle(.white)
                                    .font(.title2)
                                    .bold()
                                Spacer()
                            }
                            .padding(.bottom)
                            ForEach(dtpArray, id: \.id) { lesson in
                                NavigationLink(destination: LessonDetailView(lesson: lesson)) {
                                    TutorialRow(lesson: lesson)
                                }
                            }
                        }
                        .padding()
                        
                        VStack(spacing: 10) {
                            HStack{
                                Text("Неисправность автомобиля")
                                    .foregroundStyle(.white)
                                    .font(.title2)
                                    .bold()
                                Spacer()
                            }
                            .padding(.bottom)
                            ForEach(lessonsArray, id: \.id) { lesson in
                                NavigationLink(destination: LessonDetailView(lesson: lesson)) {
                                    TutorialRow(lesson: lesson)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct LessonDetailView: View {
    let lesson: Lesson
    @State private var isPresentSafariView = false
    
    var body: some View {
        VStack{
            ScrollView{
                VStack {
                    Text(lesson.title)
                        .font(.title)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .bold()
                    HStack{
                        Text(lesson.content)
                            .foregroundStyle(.white)
                            .padding(.bottom)
                        Spacer()
                    }

                    Spacer()
                    Button("Смотреть видео") {
                        isPresentSafariView = true
                    }
                    .fullScreenCover(isPresented: $isPresentSafariView) {
                        SafariViewController(url: URL(string: lesson.link)!)
                            .ignoresSafeArea()
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 60)
                    .foregroundStyle(.white)
                    .bold()
                    .background(Color.black)
                    .clipShape(.buttonBorder)
                    
                }
            }
            .padding()
        }
        .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
        
    }
}

struct TutorialRow: View {
    let lesson: Lesson
    
    var body: some View {
        HStack {
            Image(lesson.image)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.trailing)
            Text("\(lesson.title)")
                .font(.system(size: 20))
                .bold()
                .foregroundStyle(.white)
                .lineLimit(1)
            
            Spacer()
        }
        .padding()
        .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
        .clipShape(.buttonBorder)
    }
    
}

struct SafariViewController: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}

#Preview {
    TutorialView()
}

