package provide app-install 1.0

# install.tcl --
#     Install PLplot
#

# exitInstall --
#     Quit the installation - with a message
#
# Arguments:
#     None
#
# Side effects:
#     Simply quit the program after displaying a message
#
proc exitInstall {} {

    tk_messageBox -icon info -message "Installation cancelled" -type ok -title "PLplot installation"

    exit
}

# replaceInstallDir --
#     Replace the string "INSTALLDIR" in the given file
#
# Arguments:
#     filename         Name of the file to be treated
#
# Side effects:
#     Replace the string
#
proc replaceInstallDir {filename} {
    global dir

    set infile [open $filename]
    set content [read $infile]
    close $infile

    set outfile [open $filename w]
    puts $outfile [string map [list INSTALLDIR $dir] $content]
    close $outfile
}

# selectInstallDir --
#     Select the installation directory
#
# Arguments:
#     None
#
# Side effects:
#     Sets variable dir
#
proc selectInstallDir {} {
    global dir

    set newdir [tk_chooseDirectory -initialdir $dir -title "Select installation directory"]
    if { $newdir != "" } {
        set dir [file nativename $newdir]
    }
}

# installPLplot --
#     Start the installation
#
# Arguments:
#     None
#
# Side effects:
#     Creates the installation directory (if necessary) and copies the files
#     then adjusts the two batch files.
#
proc installPLplot {} {
    global scriptdir
    global dir

    console show

    set appdir     [file join $scriptdir ".." "plplot"]
    set installdir [file normalize $dir]

    if { ! [file exists $installdir] } {
        file mkdir $installdir
    }
    set contents [glob -nocomplain [file join $installdir *]]
    if { [llength $contents] == 0 } {
        set dummyfile [open [file join $installdir dummy] "w"]
        close $dummyfile
    }

    foreach file [glob [file join $installdir *]] {
        puts "Deleting: $file"
        file delete -force $file
    }

    foreach file [glob [file join $appdir *]] {
        puts "Copying: $file"
        file copy -force $file $installdir
    }
    cd $installdir

    replaceInstallDir "plplot_vars.bat"
    replaceInstallDir "bin/fortpl.bat"

    tk_messageBox -icon info -message "Installation completed" -type ok -title "PLplot installation"
    exit
}

#
# Store the directory containing the script for later use
#
set scriptdir [file dirname [info script]]

#
# Set up the main (and only window)
#
set dir "c:\\plplot"

wm title . "PLplot - installation for Fortran"

grid [text .t -yscrollcommand ".y set"] [::ttk::scrollbar .y -orient vertical -command ".t yview"] -sticky news
grid [label .inbetween -text " "] -

frame .f1
frame .f2

grid [::ttk::label  .f1.label -text "Installation directory:"] \
     [::ttk::entry  .f1.dir -textvariable dir] \
     [::ttk::button .f1.select -text "Select" -command selectInstallDir] \
         -padx 4 -pady 4 -sticky news
grid columnconfigure .f1 1 -weight 1

grid [::ttk::label .f2.label1 -text " "] \
     [::ttk::button .f2.install -text Install -command installPLplot -width 10] \
     [::ttk::label .f2.label2 -text " "] \
     [::ttk::button .f2.cancel -text Cancel -command exitInstall -width 10] \
     [::ttk::label .f2.label3 -text " "] -padx 10 -pady 4 -sticky news
grid columnconfigure .f2 0 -weight 1
grid columnconfigure .f2 2 -weight 1
grid columnconfigure .f2 4 -weight 1

grid .f1 - -sticky news
grid .f2 - -sticky news

grid columnconfigure . 0 -weight 1
grid columnconfigure . 1 -weight 0
grid rowconfigure    . 1 -weight 0
grid rowconfigure    . 2 -weight 0

set infile  [open [file join $scriptdir .. "plplot" "readme.txt"]]
set content [read $infile]
close $infile

.t insert end $content
.t configure -state disabled

