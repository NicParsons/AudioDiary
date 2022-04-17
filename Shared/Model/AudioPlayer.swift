import Foundation
import Combine
import AVFoundation

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
	var audioPlayer: AVAudioPlayer!
	@Published var isPlaying = false

	func startPlaying(_ audio: URL) {
		if isPlaying { stopPlaying() }

print("About to play \(audio).")

		#if os(iOS)
		let playbackSession = AVAudioSession.sharedInstance()
		do {
					try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
				} catch {
					print("Couldn't play over the device's loud speaker.")
				}
		#endif

		do {
					audioPlayer = try AVAudioPlayer(contentsOf: audio)
			audioPlayer.delegate = self
					audioPlayer.play()
			DispatchQueue.main.async {
				self.isPlaying = true
			} // main queue
			print("Started playing \(audio).")
				} catch {
					print("Playback failed.")
				}
	} // func

	func stopPlaying() {
		print("Stopping playback.")
		audioPlayer.stop()
		DispatchQueue.main.async {
			self.isPlaying = false
		}
		print("Playback stopped.")
	} // func

	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
			if flag {
				DispatchQueue.main.async {
					self.isPlaying = false
				} // main queue
			} // end if
		} // func
} // class

//  AudioPlayer.swift
//  AudioDiary
//  Created by Nicholas Parsons on 17/4/2022.
