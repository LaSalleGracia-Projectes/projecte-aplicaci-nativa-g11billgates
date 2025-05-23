import SwiftUI
import AVKit
import PhotosUI
import AVFoundation

// MARK: - Views
struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showReportAlert = false
    @State private var showBlockAlert = false
    @State private var showDeleteAlert = false
    @State private var showImagePicker = false
    @State private var showVideoPicker = false
    @State private var showCamera = false
    @State private var showMediaOptions = false
    @State private var showReportOptions = false
    @State private var showBlockOptions = false
    @State private var showDeleteOptions = false
    @State private var showAgeRestrictionAlert = false
    @State private var selectedImage: UIImage?
    @State private var selectedVideoURL: URL?
    @State private var isRecording = false
    @State private var recordingTime: TimeInterval = 0
    @State private var audioRecorder: AVAudioRecorder?
    @State private var audioURL: URL?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var recordingTimer: Timer?
    
    let chatId: String
    let userId: String
    let userAge: Int
    let reportedUserId: String
    
    init(chatId: String, userId: String, userAge: Int, reportedUserId: String) {
        self.chatId = chatId
        self.userId = userId
        self.userAge = userAge
        self.reportedUserId = reportedUserId
        _viewModel = StateObject(wrappedValue: ChatViewModel(chatId: chatId, userId: userId, userAge: userAge, reportedUserId: reportedUserId))
    }
    
    var body: some View {
        VStack {
            // Header
            headerView
            
            // Messages
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.messages) { message in
                        MessageBubble(message: message, viewModel: viewModel)
                            .id(message.id)
                    }
                }
                .padding(.horizontal)
            }
            
            // Input area
            inputAreaView
        }
        .sheet(isPresented: $showImagePicker) {
            PhotosPicker(selection: $viewModel.selectedItem, matching: .images) {
                Text("Seleccionar imagen")
            }
        }
        .onChange(of: viewModel.selectedItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    await viewModel.sendImage(image)
                }
            }
        }
        .alert("Restricción de edad", isPresented: $viewModel.showAgeRestrictionAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Debes ser mayor de 18 años para acceder al chat")
        }
        .alert("Reportar usuario", isPresented: $showReportAlert) {
            Button("Cancelar", role: .cancel) { }
            Button("Reportar", role: .destructive) {
                Task {
                    await viewModel.reportUser()
                    dismiss()
                }
            }
        } message: {
            Text("¿Estás seguro de que quieres reportar a este usuario? Esta acción eliminará el chat y no podrás volver a hablar con él.")
        }
    }
    
    private var headerView: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20))
                    .foregroundColor(.primary)
            }
            .padding(.leading)
            
            Spacer()
            
            Text("Chat")
                .font(.title2)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button(action: {
                showReportAlert = true
            }) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.red)
            }
            .padding(.trailing)
        }
        .frame(height: 44)
        .background(Color(.systemBackground))
        .shadow(color: .black.opacity(0.1), radius: 5, y: 2)
    }
    
    private var inputAreaView: some View {
        VStack(spacing: 0) {
            // Recording indicator
            if viewModel.isRecording {
                HStack {
                    Image(systemName: "mic.fill")
                        .foregroundColor(.red)
                    Text(String(format: "%.1f\"", viewModel.recordingTime))
                        .font(.caption)
                    Spacer()
                    Button("Cancelar") {
                        viewModel.cancelRecording()
                    }
                    .foregroundColor(.red)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
            }
            
            HStack(spacing: 12) {
                // Media buttons
                HStack(spacing: 8) {
                    PhotosPicker(selection: $viewModel.selectedItem, matching: .images) {
                        Image(systemName: "photo")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                    }
                    
                    PhotosPicker(selection: $viewModel.selectedItem, matching: .videos) {
                        Image(systemName: "video")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {
                        if viewModel.isRecording {
                            viewModel.stopRecording()
                        } else {
                            viewModel.startRecording()
                        }
                    }) {
                        Image(systemName: viewModel.isRecording ? "stop.circle.fill" : "mic.circle")
                            .font(.system(size: 20))
                            .foregroundColor(viewModel.isRecording ? .red : .gray)
                    }
                }
                
                // Text input
                if !viewModel.isRecording {
                    TextField("Escribe un mensaje...", text: $viewModel.messageText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 8)
                    
                    // Send button
                    Button(action: {
                        Task {
                            await viewModel.sendMessage()
                        }
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.blue)
                    }
                    .disabled(viewModel.messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .shadow(color: .black.opacity(0.1), radius: 5, y: -2)
        }
    }
}

struct MessageBubble: View {
    let message: Message
    let viewModel: ChatViewModel
    @State private var isPlaying = false
    @State private var player: AVPlayer?
    
    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer()
            }
            
            VStack(alignment: message.isFromCurrentUser ? .trailing : .leading) {
                switch message.type {
                case .text:
                    Text(message.content)
                        .padding(12)
                        .background(message.isFromCurrentUser ? Color.blue : Color(.systemGray5))
                        .foregroundColor(message.isFromCurrentUser ? .white : .primary)
                        .cornerRadius(16)
                
                case .image:
                    if let url = URL(string: message.mediaURL ?? "") {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 200)
                                    .cornerRadius(12)
                            case .failure:
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                
                case .video:
                    if let url = URL(string: message.mediaURL ?? "") {
                        VideoPlayer(player: AVPlayer(url: url))
                            .frame(width: 200, height: 150)
                            .cornerRadius(12)
                            .onAppear {
                                player = AVPlayer(url: url)
                            }
                            .onDisappear {
                                player?.pause()
                                player = nil
                            }
                    }
                
                case .voice:
                    HStack {
                        Button(action: {
                            if let url = URL(string: message.mediaURL ?? "") {
                                if isPlaying {
                                    viewModel.stopAudio()
                                    isPlaying = false
                                } else {
                                    viewModel.playVoiceMessage(url)
                                    isPlaying = true
                                }
                            }
                        }) {
                            Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.blue)
                        }
                        
                        if let duration = message.duration {
                            Text(String(format: "%.1f\"", duration))
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(8)
                    .background(message.isFromCurrentUser ? Color.blue.opacity(0.1) : Color(.systemGray5))
                    .cornerRadius(12)
                }
                
                Text(message.timestamp)
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 4)
            }
            
            if !message.isFromCurrentUser {
                Spacer()
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ChatView(chatId: "1", userId: "2", userAge: 25, reportedUserId: "3")
}
