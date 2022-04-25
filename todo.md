#  To Do

##  Bugs

* also double tapping entries triggered delete and play
* Play and Stop menu commands are always disabled
* Play and Stop menu commands don't work even if not disabled
* duration not formatted correctly if seconds are 0 e.g. 13 minutes will display as “13” rather than “13:00”, and 0 minutes 0 seconds will display as “0”
* start recording sound effect captured on recording if not using headphones
* toolbar not visible on iOS
* downloading from iCloud is flaky – downloads seem to trigger but are not reflected in realtime, and downloads seem to complete between launches

##. Features

* add accessibility gesture/magic tap gesture for start and stop recording
* sync data with CoreData and CloudKit
* add other playback controls like skip back, skip forward, speed, etc (might need now playing screen)
* playback progress and recording progress
* show playback progress in/under RecordingRow
* ability to assign recording to a date other than creation date (i.e. allow assignment of calendarDate property) – perhaps this can be done by dragging diary entry to a different date in the journal view
* allow import of audio files by drag and drop and by copy paste
* play should resume from point at which recording paused
* IOS home screen should remember last selected tab
* CalendarList view should default to scrolled all the way to the bottom
* maybe recording detail view
* pretty calendar view to see all days for which there are recordings
* understand the weird messages being written to the console (.e. [aqme]        MEMixerChannel.cpp:1639  client <AudioQueueObject@0x139027e00; [0]; play> got error 2003332927 while sending format information)
* editing/trimming functions
* allow option of recording location of diary entry

##CoreData Warnings

* CoreData: warning: CoreData+CloudKit: -[NSCloudKitMirroringDelegate finishedAutomatedRequestWithResult:](2972): Finished request '<NSCloudKitMirroringExportRequest: 0x2828d6740> 5066F44B-3654-4D77-9CF1-B7457400B9EF' with result: <NSCloudKitMirroringResult: 0x283dcafa0> success: 0 madeChanges: 0 error: Error Domain=NSCocoaErrorDomain Code=134417 "Request '<NSCloudKitMirroringExportRequest: 0x2828d6740> 5066F44B-3654-4D77-9CF1-B7457400B9EF' was cancelled because there is already a pending request of type 'NSCloudKitMirroringExportRequest'." UserInfo={NSLocalizedFailureReason=Request '<NSCloudKitMirroringExportRequest: 0x2828d6740> 5066F44B-3654-4D77-9CF1-B7457400B9EF' was cancelled because there is already a pending request of type 'NSCloudKitMirroringExportRequest'.}
* CloudKit push notifications require the 'remote-notification' background mode in the info plist
* unable to import files on iOS: Error Domain=NSCocoaErrorDomain Code=257 

##Commit Message

