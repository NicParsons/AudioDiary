#  To Do

##  Bugs

* Play and Stop menu commands are always disabled
* Play and Stop menu commands don't work even if not disabled
* pressing space bar on the Recording button in the Today view activates the Play button
* something weird is going on with the selection of recordings – the keyboardShortcuts for the Play and Stop buttons seem to be working but the effect does not correlate with what is selected
* playback sometimes stops due to a weird error

##. Features

* show duration in RecordingRow
* Tab View for iOS
* syncing data with CoreData and CloudKit
* add other playback controls like pause, skip back, skip forward, speed, etc (might need now playing screen)
* ability to assign recording to a date other than creation date (i.e. allow assignment of calendarDate property)
* maybe recording detail view
* pretty calendar view to see all days for which there are recordings
* understand the weird messages being written to the console
* editing/trimming functions

##Commit Message

Re-architect data model, add iOS TabView, and refactor

* entirely re-architect the data model
* combine AudioRecorder and AudioPlayer classes into new Model class
* add Playback Controls menu to the menu bar
* factor out Play and StopPlaying buttons into their own views
* add Play and Stop items to the Playback Controls menu
* add FocusedValues extension to allow the menu bar items to detect what has focus in the UI
* try to work around limitation where EnvironmentObject not passed to menu bar commands
* add environment object to many Previews
* add TabView for iOS
* iOS and macOS both now have a HomeScreen View that is called from the main App struct on launch
* factor TodayViewLabel and ListViewLabel into their own views for use in the Sidebar and TabView

## Bug fixes

* fix: no confirmation dialog when deleting recording with delete key
* fix: unable to delete recordings with the delete key from the List view
* fix: deleting a currently playing recording from the edit menu or with the delete key will not stop playback
* the Model's delete() method will now call the stopPlaying() method if the deleted url matches the currently playing url

## Known issues

* Play and Stop menu commands are always disabled (they don't seem to be receiving the View's focus selection state)
* Play and Stop menu commands don't work even if not disabled
* pressing space bar on the Recording button in the Today view activates the Play button
* something weird is going on with the selection of recordings – the keyboardShortcuts for the Play and Stop buttons seem to be working but the effect does not correlate with what is selected
* playback sometimes stops due to a weird error
