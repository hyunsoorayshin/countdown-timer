import Foundation
import Combine

enum TimerState {
    case idle
    case running
    case paused
    case finished
}

@MainActor
final class TimerViewModel: ObservableObject {
    @Published var hours: Int = 0
    @Published var minutes: Int = 5
    @Published var seconds: Int = 0

    @Published var remainingSeconds: Double = 0
    @Published var totalSeconds: Double = 0
    @Published var state: TimerState = .idle

    var progress: Double {
        guard totalSeconds > 0 else { return 0 }
        return 1.0 - (remainingSeconds / totalSeconds)
    }

    var displayTime: String {
        let total = Int(ceil(remainingSeconds))
        let h = total / 3600
        let m = (total % 3600) / 60
        let s = total % 60
        if h > 0 {
            return String(format: "%d:%02d:%02d", h, m, s)
        }
        return String(format: "%02d:%02d", m, s)
    }

    private var timer: AnyCancellable?
    private var lastTick: Date?

    var onFinished: (() -> Void)?

    func start() {
        let total = Double(hours * 3600 + minutes * 60 + seconds)
        guard total > 0 else { return }

        if state == .idle || state == .finished {
            totalSeconds = total
            remainingSeconds = total
        }

        state = .running
        lastTick = Date()

        timer = Timer.publish(every: 0.05, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }

    func pause() {
        state = .paused
        timer?.cancel()
        timer = nil
    }

    func resume() {
        state = .running
        lastTick = Date()

        timer = Timer.publish(every: 0.05, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }

    func reset() {
        timer?.cancel()
        timer = nil
        state = .idle
        remainingSeconds = 0
        totalSeconds = 0
    }

    private func tick() {
        guard state == .running else { return }
        let now = Date()
        if let last = lastTick {
            remainingSeconds -= now.timeIntervalSince(last)
        }
        lastTick = now

        if remainingSeconds <= 0 {
            remainingSeconds = 0
            state = .finished
            timer?.cancel()
            timer = nil
            onFinished?()
        }
    }
}
