#  To Do – Audio Diary

##Bugs

* sometimes ghost entries show up in iOS
* start recording sound effect captured on recording if not using headphones (and VoiceOver speaking as well if VO is enabled)
* Downloading from iCloud is flaky – downloads seem to trigger but are not reflected in realtime, and downloads seem to complete between launches. Sometimes when choosing download the message printed to the console is that the file didn't start downloading.
* IOS sometimes doesn't remember selected tab between launches
* remote recordings not showing time stamp/duration (perhaps duration needs to be saved as part of data model rather than calculated on the fly)

##Features

* clean up duplication of duration in NowPlayingView and duplication between NowPlayingView and RecordingView
* swipe gestures should work even when VoiceOver is enabled - .accessibilityAddTraits(.allowsDirectInteraction) doesn't seem to work
* status of a recording or recording row should show the duration if it has been downloaded or a cloud image if it is remote
* add DatePicker to RecordingView to edit the calendar date
* allow Recordings to be exported and imported as complete .diaryEntries with all metadata, and to be opened directly in AudioDiary from Messages
* get ShareLink on macOS to display option to share with Messages
* Transcripts
* ability to take notes while listening to recording
* create view selection group to be inserted as a toolbar item containing radio buttons for transcript, notes and recording a reply, which wil take a binding to an enum representing the View state, which will determine which of those views is shown in the RecordingView
* consider accessibility action for download recording (perhaps not needed as can be downloaded when playing)
* add gestures e.g. swipe to delete to iOS
* Carousel view
* remove silences
* add property or computed property to model to return whether playback is paused (default false, set to true when pausing, set to false when playback did finish, or when it is stopped, or when playback starts)
* data model will not be aware if recording files have been deleted or moved since they were created -- will now remove missing recordings and automatically add new recordings in the expected directory but ideally should register for notifications if files moved and update data model accordingly
* the data model will not sync as we are using @AppStorage which is specific to the user's local machine
* should save JSON data to iCloud rather than @AppStorage
* should rename files when importing
* de-couple calendarDate property from creationDate of Recording
* improve quality of audio recording
* use SwiftData to sync
* ability to assign recording to a date other than creation date (i.e. allow assignment of calendarDate property) – perhaps this can be done by dragging diary entry to a different date in the journal view
* allow import of audio files by drag and drop and by copy paste
* CalendarList view should default to scrolled all the way to the bottom -- struggling to get this to work, even with ScrollViewReader, so as a workaround perhaps can list diary entries in reverse chronological order
* recording progress detail view that shows progress of recording with buttons to pause, resume, save/done
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

