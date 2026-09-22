# Countdown Timer

A small single-window countdown timer for macOS. Pick hours, minutes and seconds,
press Start, and watch a progress ring count down. When time is up it plays an
alarm sound of your choosing (any audio file, picked through a standard file
dialog) or, if you have not chosen one, falls back to the system beep.

Built with Swift 6 and SwiftUI as a plain Swift Package. No dependencies.

## Why I built it

I wanted a dead-simple, full-screen-friendly countdown for timed classroom
activities: something I could put on a projector, start, and not think about
again until it rang. The timer apps I tried were either cluttered with ads,
wanted an account, or hid the one feature I cared about behind a subscription.
This one does exactly one thing. I built it on my own time.

## What this is not

- Not affiliated with any school or academy.
- Collects no data. There is no analytics, no telemetry, no account.
- Makes no network requests at all.

## Build & run

Requires macOS 15 and the Xcode command line tools (or Xcode) with a Swift 6
toolchain.

```bash
swift build
swift run CountdownTimer
```

## Author

Hyunsoo Ray Shin (Ray)

## License

MIT. See [LICENSE](LICENSE).
