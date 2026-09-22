import SwiftUI

struct TimePickerView: View {
    @Binding var hours: Int
    @Binding var minutes: Int
    @Binding var seconds: Int

    var body: some View {
        HStack(spacing: 4) {
            Picker("", selection: $hours) {
                ForEach(0..<24, id: \.self) { h in
                    Text("\(h)").tag(h)
                }
            }
            .frame(width: 60)
            Text("h")
                .foregroundStyle(.secondary)

            Picker("", selection: $minutes) {
                ForEach(0..<60, id: \.self) { m in
                    Text("\(m)").tag(m)
                }
            }
            .frame(width: 60)
            Text("m")
                .foregroundStyle(.secondary)

            Picker("", selection: $seconds) {
                ForEach(0..<60, id: \.self) { s in
                    Text("\(s)").tag(s)
                }
            }
            .frame(width: 60)
            Text("s")
                .foregroundStyle(.secondary)
        }
    }
}
