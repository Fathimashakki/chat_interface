//
//  ContentView.swift
//  chat_interface
//
//  Created by Shakki on 16/05/25.
//

import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

struct ContentView: View {
    @State private var messages: [Message] = [
        Message(text: "Hello!", isUser: false),
        Message(text: "Hey there!", isUser: true)
    ]
    @State private var inputText: String = ""

    var body: some View {
        ZStack {
           
            LinearGradient(colors: [Color.indigo, Color.gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(messages) { message in
                            HStack {
                                if message.isUser { Spacer() }
                                Text(message.text)
                                    .padding()
                                    .background(message.isUser ? Color.white.opacity(0.3) : Color.black.opacity(0.2))
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                if !message.isUser { Spacer() }
                            }
                        }
                    }
                    .padding()
                }

                // Input field section with a "+" button
                HStack {
                    Button(action: addAttachment) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                    }

                    TextField("Type a message...", text: $inputText)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundColor(.white)
                        .placeholder(when: inputText.isEmpty, placeholder: "Type a message...")

                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                }
                .padding()
            }
        }
    }

    private func sendMessage() {
        guard !inputText.isEmpty else { return }
        messages.append(Message(text: inputText, isUser: true))
        inputText = ""
    }

    private func addAttachment() {
        // Placeholder action for attachment functionality
    }
}

// Custom modifier for placeholder styling
extension View {
    func placeholder(when shouldShow: Bool, placeholder: String) -> some View {
        ZStack(alignment: .leading) {
            if shouldShow {
                Text(placeholder)
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.horizontal, 10)
            }
            self
        }
    }
}

#Preview {
    ContentView()
}
