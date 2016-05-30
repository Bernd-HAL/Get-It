//
//  ViewController.swift
//  Youtube-dl-GUI
//
//  Created by Kevin De Koninck on 23/05/16.
//  Copyright © 2016 Kevin De Koninck. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    //input and output GUI elements
    @IBOutlet var inputURLS: NSTextView!
    @IBOutlet var outputWindow: NSTextView!
    
    //settings GUI elements
    @IBOutlet weak var maxFileSize: NSTextField!
    @IBOutlet weak var ignoreErrors: NSButton!
    @IBOutlet weak var pathChooser: NSPathCell!
    
    
    //audio tab
    @IBOutlet weak var extractAudio: NSButton!
    @IBOutlet weak var audioFormat: NSPopUpButton!
    @IBOutlet weak var audioQuality: NSPopUpButton!
    @IBOutlet weak var keepVideo: NSButton!
    
    //Video tab
    @IBOutlet weak var videoFormat: NSPopUpButton!
    @IBOutlet weak var downloadAllFormats: NSButton!
    @IBOutlet weak var preferFreeFormats: NSButton!
    @IBOutlet weak var skipDashManifest: NSButton!
    
    
    
    //playlist tab
    @IBOutlet weak var downloadPlaylist: NSButton!
    @IBOutlet weak var reversePlaylist: NSButton!
    @IBOutlet weak var flatPlaylist: NSButton!
    @IBOutlet weak var startAtVideo: NSTextField!
    @IBOutlet weak var stopAtVideo: NSTextField!
    @IBOutlet weak var downloadSpecificVideos: NSTextField!
    
    //authentication tab
    @IBOutlet weak var username: NSTextField!
    @IBOutlet weak var password: NSSecureTextField!
    @IBOutlet weak var twoFactorCode: NSSecureTextField!
    @IBOutlet weak var netrc: NSButton!
    @IBOutlet weak var videoPassword: NSSecureTextField!
    


    //will excecute when we psuh on the download-button
    @IBAction func downloadButton(sender: AnyObject) {
       
        //erase text from outputWindow
        outputWindow.textStorage!.mutableString.setString("")
        
        //get input URLs and devide them in an array
        let tempString = inputURLS.string!
        let inputURLS_array = tempString.characters.split{$0 == "\n"}.map(String.init) //array: inputURL[0] inputURL[1] ...
        
        
        
        
        /*
         
         General:
         --abort-on-error                 Abort downloading of further videos (in the playlist or the command line) if an error occurs
         -o, --output TEMPLATE
         

 
         src: https://github.com/MrS0m30n3/youtube-dl-gui/blob/master/youtube_dl_gui/optionsframe.py#L828
         
         
         VALID_VIDEO_FORMAT = ('0', '17', '36', '5', '34', '35', '43', '44', '45',
         '46', '18', '22', '37', '38', '160', '133', '134', '135', '136','137',
         '264', '138', '242', '243', '244', '247', '248', '271', '272', '82',
         '83', '84', '85', '100', '101', '102', '139', '140', '141', '171', '172')
         
         VALID_AUDIO_FORMAT = ('mp3', 'wav', 'aac', 'm4a', 'vorbis', 'opus')
         
         
         VALID_OUTPUT_FORMAT = ('title', 'id', 'custom')
         
         VALID_FILESIZE_UNIT = ('', 'k', 'm', 'g', 't', 'p', 'e', 'z', 'y')
         
         VALID_SUB_LANGUAGE = ('en', 'gr', 'pt', 'fr', 'it', 'ru', 'es', 'de')

 
        */
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
/*****************
* create command *
******************/
        
        var command = "export PATH=$PATH:/usr/local/bin && youtube-dl";
        
/*****************
*  Playlist tab  *
******************/
        
        //append "download playlist" to command
        if downloadPlaylist.state == 1 {
            command += " --yes-playlist"
        }
        else{
            command += " --no-playlist"
        }
        
        //append "download playlist in reverse" to command
        if reversePlaylist.state == 1 {
            command += " --playlist-reverse"
        }
        
        //append "flat playlist" to command
        if flatPlaylist.state == 1 {
            command += " --flat-playlist"
        }
        
        //append ""start at video" to command
        if !startAtVideo.stringValue.isEmpty {
            command += " --playlist-start \(startAtVideo.stringValue)"
        }
        
        //append "stop at video" to command
        if !stopAtVideo.stringValue.isEmpty {
            command += " --playlist-end \(stopAtVideo.stringValue)"
        }
        
        //append "download specific videos" to command
        if !downloadSpecificVideos.stringValue.isEmpty {
            command += " --playlist-items \(downloadSpecificVideos.stringValue)"
        }
        
        
/***********************
*  Authentication tab  *
************************/
        
        //append "username" to command
        if !username.stringValue.isEmpty {
            command += " --username \(username.stringValue)"
        }
        
        //append "password" to command
        if !password.stringValue.isEmpty {
            command += " --password \(password.stringValue)"
        }
        
        //append "2 factor authentication code" to command
        if !twoFactorCode.stringValue.isEmpty {
            command += " --twofactor \(twoFactorCode.stringValue)"
        }
        
        //append "video password" to command
        if !videoPassword.stringValue.isEmpty {
            command += " --video-password \(videoPassword.stringValue)"
        }
        
        //append "netrc" to command
        if netrc.state == 1 {
            command += " --netrc"
        }
        

/*****************
*   Audio tab    *
******************/
        
        //append extract audio to command
        if extractAudio.state == 1 {
            command += " --extract-audio"
        }
        
        //append audio format to command
        let audioFormatString = audioFormat.selectedItem?.title.characters.split{$0 == "\""}.map(String.init) //item to string
        command += " --audio-format \(audioFormatString![0])"
        
        //append audio quality to command
        let audioQualityString = audioQuality.selectedItem!.title.characters.split{$0 == "\""}.map(String.init) //item to string
        let audioQ = audioQualityString.first!.characters.first
        command += " --audio-quality \(audioQ!)"
        
        //append "keep video" to command
        if keepVideo.state == 1 {
            command += " --keep-video"
        }
 
/*****************
 *  Video tab    *
******************/
        
        //append "video format" to command
        let videoFormatString = videoFormat.selectedItem!.tag
        if videoFormatString > 0 {
            command += " --format \(videoFormatString)"
        }
        
        //append "download all formats" to command
        if downloadAllFormats.state == 1 {
            command += " --all-formats"
        }
        
        //append "prefer free formats" to command
        if preferFreeFormats.state == 1 {
            command += " --prefer-free-formats "
        }
        
        //append "skip dash manifest" to command
        if skipDashManifest.state == 1 {
            command += " --youtube-skip-dash-manifest"
        }
        
        
        
        
        
/*****************
*  General tab   *
******************/
        
        //append max file size to command
        if !maxFileSize.stringValue.isEmpty {
            command += " --max-filesize \(maxFileSize.stringValue)M"
        }

        //append ignore errors to command
        if ignoreErrors.state == 1 {
            command += " --ignore-errors"
        }

        //append output destination to command
        let pathString = pathChooser.URL?.path!.characters.split{$0 == "\""}.map(String.init) //item to string
        command += " -o \(pathString![0])/'%(title)s.%(ext)s'"
        
        //append input URLs to the command
        for url in inputURLS_array {
            command += " \(url)"
        }
        
        //display the used command
        outputWindow.insertText( "\nYour files will be downloaded with the following youtube-dl command:\n\n\t \(command) \n\n" )
        

        
        

        
        //the following code (from stackoverflow) will excecute the youtube-dl command and will add the output from the command
        //to the output window (real time output)
        // http://stackoverflow.com/questions/29548811/real-time-nstask-output-to-nstextview-with-swift
        
        var arguments:[String] = []
        arguments.append("-c")
        arguments.append( command )
        

        let task = NSTask()
        task.launchPath = "/bin/sh"
        task.arguments = arguments
        
        let pipe = NSPipe()
        task.standardOutput = pipe
        let outHandle = pipe.fileHandleForReading
        outHandle.waitForDataInBackgroundAndNotify()
        
        var obs1 : NSObjectProtocol!
        obs1 = NSNotificationCenter.defaultCenter().addObserverForName(NSFileHandleDataAvailableNotification,
                                                                       object: outHandle, queue: nil) {  notification -> Void in
                                                                        let data = outHandle.availableData
                                                                        if data.length > 0 {
                                                                            if let str = NSString(data: data, encoding: NSUTF8StringEncoding) {
                                                                                //print("got output: \(str)")
                                                                                //RECEIVED OUTPUT
                                                                                self.outputWindow.insertText( "\(str)" )
                                                                            
                                                                            }
                                                                            outHandle.waitForDataInBackgroundAndNotify()
                                                                        } else {
                                                                            //print("EOF on stdout from process")
                                                                            //self.outputWindow.insertText( "\nEOF on stdout from process" )
                                                                            NSNotificationCenter.defaultCenter().removeObserver(obs1)
                                                                        }
        }
        
        var obs2 : NSObjectProtocol!
        obs2 = NSNotificationCenter.defaultCenter().addObserverForName(NSTaskDidTerminateNotification,
                                                                       object: task, queue: nil) { notification -> Void in
                                                                        //print("terminated")
                                                                        self.outputWindow.insertText( "\n\nDONE.\n" )
                                                                        NSNotificationCenter.defaultCenter().removeObserver(obs2)
        }
        
        task.launch()
        
    }
    
    
    
    //this function will excecute once when the view has been loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set texts
       // inputURLS.insertText("\n\nInsert your URLs here. Seperate multiple URLS with a breakline (enter).")
        outputWindow.insertText( "\n\nThis will contain some debugging information when downloading your requested files.\n" )
        
        
  //      inputURLS.toolTip("Insert your URLs here. Seperate multiple URLS with a breakline (enter).")
        
        //Default value for the maximum file size is 15MB
        maxFileSize.stringValue = "15"
        
        //Delete default path
        pathChooser.pathComponentCells.removeAll()
        
        // TODO - set the default path to the user his downloads folder
        let username = system ("whoami")
        // pathChooser.URL?.path = "/"
        
        
    }

    
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    

}

