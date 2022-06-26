#  To Do – Audio Diary

##Bugs

* in Today view, selection in RecordingsList is lost when playback is paused
* sometimes ghost entries show up in iOS
* start recording sound effect captured on recording if not using headphones (and VoiceOver speaking as well if VO is enabled)
* toolbar not visible on iOS
* Downloading from iCloud is flaky – downloads seem to trigger but are not reflected in realtime, and downloads seem to complete between launches. Sometimes when choosing download the message printed to the console is that the file didn't start downloading.
* IOS sometimes doesn't remember selected tab between launches
* Magic Tap gesture only works if focus is on Record or Import button -- if focus is on the list of recordings, the magic tap gesture will go through to the system and resume the system now playing audio

##Features

* data model will not be aware if recording files have been deleted or moved since they were created -- will now remove missing recordings and automatically add new recordings in the expected directory but ideally should register for notifications if files moved and update data model accordingly
* the data model will not sync as we are using @AppStorage which is specific to the user's local machine
* should save JSON data to iCloud rather than @AppStorage
* should rename files when importing
* de-couple calendarDate property from creationDate of Recording
* improve quality of audio recording
* sync data with CoreData and CloudKit
* share recordings/diary entries
* ability to assign recording to a date other than creation date (i.e. allow assignment of calendarDate property) – perhaps this can be done by dragging diary entry to a different date in the journal view
* allow import of audio files by drag and drop and by copy paste
* CalendarList view should default to scrolled all the way to the bottom -- struggling to get this to work, even with ScrollViewReader, so as a workaround perhaps can list diary entries in reverse chronological order
* add other playback controls like skip back, skip forward, speed, etc (might need now playing screen)
* playback progress and recording progress
* show playback progress in/under RecordingRow
* recording progress detail view that shows progress of recording with buttons to pause, resume, save/done
* maybe diary entry detail view
* pretty calendar view to see all days for which there are recordings
* editing/trimming functions
* allow option of recording location of diary entry
* add script to show TODOs and FIXMEs as compiler warnings
* perhaps RecordingRow could have swipe gesture to delete instead of delete button
* consider accessibility focus state -- where VO focus should be when views appear

##Console messages

* understand the weird messages being written to the console
* [aqme]        MEMixerChannel.cpp:1639  client <AudioQueueObject@0x139027e00; [0]; play> got error 2003332927 while sending format information)
* 2022-06-26 14:27:34.926984+1000 AudioDiary[41334:2712489] [AXRuntimeCommon] Unknown client: AudioDiary

##CoreData Warnings

* CoreData: warning: CoreData+CloudKit: -[NSCloudKitMirroringDelegate finishedAutomatedRequestWithResult:](2972): Finished request '<NSCloudKitMirroringExportRequest: 0x2828d6740> 5066F44B-3654-4D77-9CF1-B7457400B9EF' with result: <NSCloudKitMirroringResult: 0x283dcafa0> success: 0 madeChanges: 0 error: Error Domain=NSCocoaErrorDomain Code=134417 "Request '<NSCloudKitMirroringExportRequest: 0x2828d6740> 5066F44B-3654-4D77-9CF1-B7457400B9EF' was cancelled because there is already a pending request of type 'NSCloudKitMirroringExportRequest'." UserInfo={NSLocalizedFailureReason=Request '<NSCloudKitMirroringExportRequest: 0x2828d6740> 5066F44B-3654-4D77-9CF1-B7457400B9EF' was cancelled because there is already a pending request of type 'NSCloudKitMirroringExportRequest'.}
* [AXRuntimeCommon] Unknown client: AudioDiary

##Commit Message

