function report_github(){
    dialog --yesno "Can't start stream:\n"'"'"$(echo "$STREAM" | cut -d " " -f2-)"'"'".\nLogin to & create issue on GitHub?" 0 0
    [ $? -eq 0 ] && { 
        gh issue create --title "[Created by script] Can't start $(echo "$STREAM" | cut -d " " -f2-) stream" --body "$(echo "$STREAM" | cut -d " " -f1) may not exist anymore!" || echo "Install github-cli!"
    } && exit
}

tvlist=$(while read -r url name; do echo "$url $name"°"$name"°"$url"°; done < tvlist)

while true
do
    IFS="°"
    STREAM=$(dialog --backtitle "dialogtv.sh" --title "Stream list" --stdout --no-ok --no-cancel --item-help --default-item "$STREAM" --no-tags --menu "Select which stream you want to watch.\nIt might take a while to start." 0 0 0 \
    $tvlist)
    unset IFS
    mpv $(echo "$STREAM" | cut -d " " -f1)
    [ $? -eq 2 ] && report_github "$STREAM"
done
