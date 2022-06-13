#  To Do

##Bugs

* double tapping entries, or pressing VO-space on macOS, triggers delete and/or play (both on iOS, just delete on macOS)
* start recording sound effect captured on recording if not using headphones
* toolbar not visible on iOS
* Downloading from iCloud is flaky – downloads seem to trigger but are not reflected in realtime, and downloads seem to complete between launches. Sometimes when choosing download the message printed to the console is that the file didn't start downloading.
* IOS doesn't remember selected tab between launches
* Magic Tap gesture only works if focus is on Record or Import button

##Features

* allow recordings to be deleted using the delete key in the CalendarList view on macOS
* data model will not be aware if recording files have been deleted or moved since they were created
* the data model will not sync as we are using @AppStorage which is specific to the user's local machine
* should save JSON data to icloud rather than @AppStorage
* improve quality of audio recording
* sync data with CoreData and CloudKit
* share recordings/diary entries
* ability to assign recording to a date other than creation date (i.e. allow assignment of calendarDate property) – perhaps this can be done by dragging diary entry to a different date in the journal view
* allow import of audio files by drag and drop and by copy paste
* CalendarList view should default to scrolled all the way to the bottom
* add other playback controls like skip back, skip forward, speed, etc (might need now playing screen)
* playback progress and recording progress
* show playback progress in/under RecordingRow
* recording progress detail view that shows progress of recording with buttons to pause, resume, save/done
* maybe diary entry detail view
* pretty calendar view to see all days for which there are recordings
* understand the weird messages being written to the console (.e. [aqme]        MEMixerChannel.cpp:1639  client <AudioQueueObject@0x139027e00; [0]; play> got error 2003332927 while sending format information)
* editing/trimming functions
* allow option of recording location of diary entry
* add script to show TODOs and FIXMEs as compiler warnings

##CoreData Warnings

* CoreData: warning: CoreData+CloudKit: -[NSCloudKitMirroringDelegate finishedAutomatedRequestWithResult:](2972): Finished request '<NSCloudKitMirroringExportRequest: 0x2828d6740> 5066F44B-3654-4D77-9CF1-B7457400B9EF' with result: <NSCloudKitMirroringResult: 0x283dcafa0> success: 0 madeChanges: 0 error: Error Domain=NSCocoaErrorDomain Code=134417 "Request '<NSCloudKitMirroringExportRequest: 0x2828d6740> 5066F44B-3654-4D77-9CF1-B7457400B9EF' was cancelled because there is already a pending request of type 'NSCloudKitMirroringExportRequest'." UserInfo={NSLocalizedFailureReason=Request '<NSCloudKitMirroringExportRequest: 0x2828d6740> 5066F44B-3654-4D77-9CF1-B7457400B9EF' was cancelled because there is already a pending request of type 'NSCloudKitMirroringExportRequest'.}
* [AXRuntimeCommon] Unknown client: AudioDiary

##Commit Message

