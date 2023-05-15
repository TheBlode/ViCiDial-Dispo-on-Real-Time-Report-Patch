#!/bin/bash
# =============================================================================
# Script Name: Real Time Report Dispo Fix for ViCiDial
# 2023-05-15
# Written by Martin McCarthy
# Script Desciption
# Changelog;
# - 2023-01-02 - initial build.
# =============================================================================
echo "                 .88888888:."
echo "                88888888.88888."
echo "              .8888888888888888."
echo "              888888888888888888"
echo "              88  _ 88 _   88888"
echo "              88 88 88 88  88888"
echo "              88_88_::_88_:88888"
echo "              88:::,::,:::::8888"
echo "              88 :::::::::  8888"
echo "             .88   ::::     8:88."
echo "            8888             8:888."
echo "          .8888               888888."
echo "         .8888:..  .::.  ...: 8888888:."
echo "        .8888.      :        :: 88:88888"
echo "       .8888                   .888:8888."
echo "      888:8         .           888:88888"
echo "    .888:88        .:           888:88888:"
echo "    8888888.       ::           88:888888"
echo "     .::.888.      ::          .88888888"
echo "   .::::::.888.    ::         ::: 8888 .:."
echo "  ::::::::::.888             .::::::::::::"
echo "  ::::::::::::.8           .:8::::::::::::."
echo " .::::::::::::::.        .:888:::::::::::::"
echo " :::::::::::::::88:.__..:88888::::::::::: "
echo "    .:::::::::::88888888888.88::::::::: "
echo "          :::_:  --    - -    :_::::  "

echo "@@        /@@   @@@        @@@&@     @@&           ##(   ###                ##"
echo "@@@       @@@   @@@     @@@@@@&@@@  .@&@           (((                      (("
echo "@@@@     @@@    @@@   @@@@          .@@@     /(((( ((/   (((     (((((      (("
echo " @&@    @@&     @@&   &@@#          .@&@    //     ///   ///          //    //"
echo "  @@@  %@@@     @@@   @@@#          .@@@   //      //*   ///          //    //"
echo "  @@@@ @@@      @@@   &@@@          .@&@   **      ***   ***   **     **    **"
echo "   @@@@@@       @@@    @@@@@@@&@@@  .@@@    **    ****   ***   **    ***    **"
echo "    &@&@        &@@        @&@&@     @&&      ,,,   ,     ,      ,,,  ,,    ,,"
echo "                                                                              "
echo ""
echo "=================================================="
echo "Dispo Fix for Real-Time Report on ViCiDial"
echo "Written by The_Blode"
echo "2023-05-15"
echo ""
echo "This script will patch your ViCiDial installation"
echo "to fix the status of dispo on the real-time report"
echo "when agents are actually on live calls"
echo "=================================================="
echo "Please type in the file path of your ViCiDial admin directory"
echo "For example; /var/www/html/vicidial"
echo "-----------------------------------"
read line
echo "-----------------------------------"
# Check if the folder exists on the system
if [ ! -d "$line" ]; then
    echo "$line does not exist on this system."
    echo ""
    echo "Please re-run this script and choose a different folder."
    echo ""
    echo "For support, vicidial http://vicidial.org/VICIDIALforum/index.php"
    echo ""
    echo "Thanks!"
    exit 1
fi

# Check if the report file exists in the chosen folder
if [ ! -f "$line/AST_timeonVDADall.php" ]; then
    echo "AST_timeonVDADall.php does not exist in the directory."
    echo ""
    echo "Please verify the file exists and re-run this script."
    echo ""
    echo "For support, vicidial http://vicidial.org/VICIDIALforum/index.php"
    echo ""
    echo "Thanks!"
    exit 1
fi

# Ask the user would they like to apply the patch or not.
echo ""
echo "Would you like to apply the dispo patch to your installation? (Y/N)"
echo "-----------------------------------"
read choice
echo "-----------------------------------"
if [ "$choice" != "Y" ] && [ "$choice" != "y" ]; then
    echo "The patch was not applied."
    echo ""
    echo "For support, vicidial http://vicidial.org/VICIDIALforum/index.php"
    echo ""
    echo "Thanks!"
    exit 1
fi

# Check if a backup exists and ask the user if they want to restore it
if [ ! -f "$line/AST_timeonVDADall.php.backup" ]; then
    echo "Creating a backup of AST_timeonVDADall.php...please wait..."
    echo ""
    cp $line"/AST_timeonVDADall.php" $line"/AST_timeonVDADall.php.backup"
    echo "AST_timeonVDADall.php.backup has been created."
    echo ""
    echo "Applying patch..."
    echo ""
    sed '3558s/.*/\t\t\tif ($Alead_id\[$i\] \> 0 \&\& empty($Acallerid[$i]))/' $line/AST_timeonVDADall.php.backup > $line/AST_timeonVDADall.php
    echo "Patch successfully applied!"
    echo ""
    echo "Thanks for using this script."
    exit 0
else
    echo "AST_timeonVDADall.php.backup was found in the folder."
    echo ""
    echo "Looks like a patch was already applied."
    echo ""
    echo "Would you like to undo the patch? (Y/N)"
    echo "-----------------------------------"
    read choice
    echo "-----------------------------------"
    if [ "$choice" == "Y" ] || [ "$choice" == "y" ]; then
        echo "Restoring file to unpatched state...please wait..."
        echo ""
        rm -f $line"/AST_timeonVDADall.php"
        mv $line"/AST_timeonVDADall.php.backup" $line"/AST_timeonVDADall.php"
        rm -f $line"/AST_timeonVDADall.php.backup"
        echo "Done! Exiting."
        exit 0
    else
        echo "Nothing to do here...exiting!"
        exit 0
    fi
fi

exit 0