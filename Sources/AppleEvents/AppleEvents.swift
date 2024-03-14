import AppleEventsC
import CoreServices
import Foundation

// Enforce minimum Swift version for all platforms and build systems.
#if swift(<5.5)
#error("AppleExtension doesn't support Swift versions below 5.5.")
#endif

/// Current AppleEvents version 1.0.1. Necessary since SPM doesn't use dynamic libraries. Plus this will be more accurate.
let version = "1.0.1"

public enum AppleEvent {
    case restart
    case shutDown
    case logOut
    case sleep
    case emptyTrash

    private var eventID: AEEventID {
        switch self {
        case .restart:
            return AEEventID(kAERestart)
        case .shutDown:
            return AEEventID(kAEShutDown)
        case .logOut:
            return AEEventID(kAEReallyLogOut)
        case .sleep:
            return AEEventID(kAESleep)
        case .emptyTrash:
            return AEEventID(kAEEmpty)
        }
    }

    public func perform() {
        SendAppleEventToSystemProcess(eventID)
    }
}
