import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TimerViewModel()
    @StateObject private var alarmPlayer = AlarmPlayer()

    var body: some View {
        VStack(spacing: 24) {
            // Circular progress ring + time display
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 10)

                Circle()
                    .trim(from: 0, to: viewModel.progress)
                    .stroke(ringColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 0.05), value: viewModel.progress)

                VStack(spacing: 4) {
                    if viewModel.state == .idle {
                        TimePickerView(
                            hours: $viewModel.hours,
                            minutes: $viewModel.minutes,
                            seconds: $viewModel.seconds
                        )
                    } else {
                        Text(viewModel.displayTime)
                            .font(.system(size: 48, weight: .light, design: .monospaced))
                            .contentTransition(.numericText())

                        if viewModel.state == .finished {
                            Text("Time's up!")
                                .font(.headline)
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .frame(width: 240, height: 240)

            // Controls
            HStack(spacing: 16) {
                switch viewModel.state {
                case .idle:
                    Button("Start") {
                        viewModel.onFinished = { [weak alarmPlayer] in
                            alarmPlayer?.play()
                        }
                        viewModel.start()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.hours == 0 && viewModel.minutes == 0 && viewModel.seconds == 0)

                case .running:
                    Button("Pause") {
                        viewModel.pause()
                    }
                    .buttonStyle(.bordered)

                    Button("Reset") {
                        alarmPlayer.stop()
                        viewModel.reset()
                    }
                    .buttonStyle(.bordered)

                case .paused:
                    Button("Resume") {
                        viewModel.resume()
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Reset") {
                        alarmPlayer.stop()
                        viewModel.reset()
                    }
                    .buttonStyle(.bordered)

                case .finished:
                    Button("Reset") {
                        alarmPlayer.stop()
                        viewModel.reset()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .controlSize(.large)

            Divider()

            // Alarm sound selector
            HStack {
                Image(systemName: "speaker.wave.2")
                    .foregroundStyle(.secondary)

                Text(alarmPlayer.selectedFileName)
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if alarmPlayer.selectedFileURL != nil {
                    Button("Clear") {
                        alarmPlayer.clearSelection()
                    }
                    .buttonStyle(.borderless)
                    .foregroundStyle(.secondary)
                }

                Button("Choose Sound...") {
                    alarmPlayer.selectAlarmFile()
                }
            }
            .padding(.horizontal, 4)
        }
        .padding(32)
        .frame(width: 340)
    }

    private var ringColor: Color {
        switch viewModel.state {
        case .idle: .blue
        case .running: .blue
        case .paused: .orange
        case .finished: .red
        }
    }
}
