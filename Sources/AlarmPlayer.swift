import AppKit
import AVFoundation

@MainActor
final class AlarmPlayer: ObservableObject {
    @Published var selectedFileURL: URL?
    @Published var selectedFileName: String = "System Default"

    private var audioPlayer: AVAudioPlayer?

    func selectAlarmFile() {
        let panel = NSOpenPanel()
        panel.title = "Select Alarm Sound"
        panel.allowedContentTypes = [.mp3, .audio]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false

        guard panel.runModal() == .OK, let url = panel.url else { return }
        selectedFileURL = url
        selectedFileName = url.lastPathComponent
    }

    func clearSelection() {
        selectedFileURL = nil
        selectedFileName = "System Default"
    }

    func play() {
        guard let url = selectedFileURL else {
            NSSound.beep()
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            NSSound.beep()
        }
    }

    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}
