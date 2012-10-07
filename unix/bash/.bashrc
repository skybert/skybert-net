##########################################################-*- sh -*- #
# Torstein's .bashrc file                                            #
######################################################################

######################################################################
# Dircolors variable
######################################################################
# eval `dircolors -b ~/.dir_colors`

######################################################################
# Terminal & shell
######################################################################
export PS1="\[\033[0;36m\]{\[\033[0;50m\]\w\[\033[0;36m\]} \[\033[0;32m\]what now... \[\033[0;39m\]"
export PS4='$0 line $LINENO: '
# Set the title of the terminal to the current state of affairs
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

# Eternal bash history
# export HISTTIMEFORMAT="%s "
export HISTTIMEFORMAT="%F %H:%M:%S "
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER \
               "$(history 1)" >> ~/.bash_eternal_history'

export TERM=rxvt-color

######################################################################
# Language settings
######################################################################
export LANG=en_GB.utf8
export LC_ALL=en_GB.utf8
export TZ='Europe/Oslo'

######################################################################
# keymapping file, it's set in .xinitrc, but something overrides it
######################################################################
# xmodmap .xmodmap

######################################################################
# Aliases
######################################################################
alias aterm='caterm -bg white -fg cyan -cr red -tint blue -tr +sb -sl 1000 -fn 7x14 -title $USERNAME@$HOSTNAME'
alias catbert='ssh catbert.escenic.com'
alias community='ssh -p 9022 escenic@81.0.178.121'
alias df='df -hT'
alias download='ssh download.escenic.com'
alias ef='/usr/local/bin/emacs -q -l $HOME/.emacs-fast'
alias emacs='emacsclient'
alias etmtest='ssh -p 9022 tipmanager@62.101.198.34'
alias get='wget -O - '
alias grep='grep -i --color'
alias hibernate='su -c "hibernate-disk --force" ; "xscreensaver-command -lock"'
alias idea='/opt/idea/bin/idea.sh'
alias javaemacs='/usr/bin/emacs -fn 7x14 -l .emacs-java'
alias leica='\ssh -2C -L9999:localhost:80 leica.doesntexist.org'
alias ls='ls -lh'
# alias mplayer='mplayer -vo gl'
# myget perl-Date-Calc* http://mirror.ii.uib.no/centos/5/os/SRPMS
alias myget="wget -r -nd -l 1 -A"
alias nautilus='nautilus --no-desktop --browser'
alias head='curl -I'
alias quanah='\ssh -2C -p 9022 -L9980:localhost:81 -R1122:localhost:22 login.skybert.net'
alias sdf='\ssh -2C tkj@freeshell.org'
alias skybert='\ssh -2C torstein@skybert.nu'
alias ssh='ssh -vC2'
alias tkjsetsvnkw='svn propset svn:keywords "Id Author HeadURL Date Revision"'
alias translate='translate -n'
alias varnishflush='varnishadm -T :6082 purge.url /'
alias vpn='echo "Update WRU :-)" ; sleep 2; su -c "openvpn $HOME/.vpn/escenic.ovpn"'
alias uprompt="unset PROMPT_COMMAND; export PS1='\u@\h \w$ '"
alias updatecatbert="
ssh catbert 'chmod -R +w public_html/presentations/' &&\
scp -r \
~/projects/escenic/branches/personal/torstein/src/main/html/presentations/ \
catbert:public_html/"
alias wallpaper='display -window root -backdrop ~/pictures/wallpaper'
# alias wallpaper='display -window root ~/graphics/wallpaper'
alias xterm='xterm -bg black -fg green -cr red -fn 7x14 -geometry 80x50'
alias rxvt='urxvt -bg black -fg "#AAD6B1" -cr red +sb'
alias urxvt='urxvt -bg black -fg "#AAD6B1" -cr red +sb'

######################################################################
# CVS settings
######################################################################
EDITOR=/usr/bin/emacs
CVSROOT=/var/lib/cvs
CVS_RSH=/usr/bin/ssh
CVS_HOME=$HOME/my_cvs
export EDITOR CVSROOT CVS_RSH

######################################################################
# Java section 
######################################################################
# export JAVA_HOME=/opt/jdk
export JAVA_HOME=/usr/lib/jvm/java-6-sun
export JDK_HOME=$JAVA_HOME
export ANT_HOME=$HOME/projects/escenic/tools/ant
# export ANT_HOME=/opt/ant
export ANT_OPTS="-Xmx1024m"
export MAVEN_HOME=/opt/maven
export MAVEN_OPTS="-Xmx1024m"
# export HTTPCLIENT_HOME=/opt/commons-httpclient
# export LOGGING_HOME=/opt/commons-logging
# export CODEC_HOME=/opt/commons-codec
# DB_DRIVERS_HOME=/opt/db_drivers

# export CLASSPATH=\
# .:\
# $JAVA_HOME/lib/tools.jar

######################################################################
# Setting the PATH variable
######################################################################
export PATH=\
$HOME/bin:\
$JAVA_HOME/bin:\
$MAVEN_HOME/bin:\
$ANT_HOME/bin:\
/bin:\
/usr/bin:\
/usr/local/bin:\
/usr/local/p4/bin:\
/usr/X11R6/bin:\
/usr/sbin:\
/opt/escenic/engine-4.3-2-geronimo/bin:\
/opt/escenic/engine-4.3-2-cochise/bin:\
/opt/escenic/engine-4.1-5-jppol/bin

# $ANT_HOME/bin:\

######################################################################
# Setting plugin path used by Netscape and Opera
######################################################################
export NPX_PLUGIN_PATH=/usr/lib/netscape/plugins

######################################################################
# Library path
######################################################################
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:\
/usr/local/lib:\
/usr/lib:\
/usr/lib/jni

######################################################################
# Oracle
######################################################################
export ORACLE_HOME=/home/oracle/app/oracle/product/11.1.0/db_1
export ORACLE_OWNER=oracle
export ORACLE_SID=orcl
export SQLPLUS=$ORACLE_HOME/bin/sqlplus
export ORACLE_HOME_LISTNER=$ORACLE_HOME
export LSNR=$ORACLE_HOME/bin/lsnrctl
export PATH=$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH

######################################################################
# Proxy settings
######################################################################
# http_proxy variable can be more annoying than anything else...
# export http_proxy=proxy.mycompany.com:3128

######################################################################
# Perforce
######################################################################
export P4CONFIG=~/.p4config

######################################################################
# VMware
######################################################################
export VMWARE_USE_SHIPPED_GTK=yes

######################################################################
# Citrix
######################################################################
export ICAROOT=/opt/citrix-client

######################################################################
# autpackage
######################################################################
[[ -f "/home/torstein/.config/autopackage/paths-bash" ]] && . "/home/torstein/.config/autopackage/paths-bash"

