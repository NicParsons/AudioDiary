#  To Do

##  Bugs

* Play and Stop menu commands are always disabled
* Play and Stop menu commands don't work even if not disabled
* iOS Navigation title shows as Today even when Journal tab is active
* duration not formatted correctly if seconds are 0 e.g. 13 minutes will display as “13” rather than “13:00”, and 0 minutes 0 seconds will display as “0”
* start recording sound effect captured on recording if not using headphones

##. Features

* sync data with CoreData and CloudKit
* add other playback controls like skip back, skip forward, speed, etc (might need now playing screen)
* playback progress and recording progress
* show playback progress in/under RecordingRow
* ability to assign recording to a date other than creation date (i.e. allow assignment of calendarDate property)
* maybe recording detail view
* pretty calendar view to see all days for which there are recordings
* understand the weird messages being written to the console (.e. [aqme]        MEMixerChannel.cpp:1639  client <AudioQueueObject@0x139027e00; [0]; play> got error 2003332927 while sending format information)
* editing/trimming functions
* allow option of recording location of diary entry
* allow import of audio files by drag and drop and by copy paste

##Commit Message

Change menu items, add sound effects and keyboard shortcuts

* add keyboard shortcut command-o to trigger ImportButton
* place ImportButton in file menu
* remove RecordButton from file menu
* create new RecordOnlyButton and StopRecordingButton
* rename “PlayBack Controls” menu to “Controls” menu
* place RecordOnlyButton and StopRecordingButton in Controls menu and supply keyboard shortcuts
* add UI sounds for start and stop recording
* add CloudKit entitlement
* played around with CloudKit in ContentView which is not shown to user (created DiaryEntry entity)

##Known issues

* Start and stop recording sound effects captured on recording if not using headphones.
* Workaround: use headphones.