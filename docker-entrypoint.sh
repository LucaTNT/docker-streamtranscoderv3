#!/usr/bin/env bash
SOURCE_URL=${SOURCE_URL:?"The SOURCE_URL environment variable is required and cannot be empty"}
SERVER=${SERVER:?"The SERVER environment variable is required and cannot be empty"}
SERVER_PASSWORD=${SERVER_PASSWORD:?"The SERVER_PASSWORD environment variable is required and cannot be empty"}
SERVER_MOUNTPOINT=${SERVER_MOUNTPOINT:?"The SERVER_MOUNTPOINT environment variable is required and cannot be empty"}

SERVER_TYPE=${SERVER_TYPE:-Icecast2}
PORT=${PORT:-8000}
SERVER_STREAM_URL=${SERVER_STREAM_URL:-}
SERVER_NAME=${SERVER_NAME:-}
SERVER_DESCRIPTION=${SERVER_DESCRIPTION:-}
SERVER_GENRE=${SERVER_GENRE:-}
ENCODE=${ENCODE:-MP3}
BITRATE_NOMINAL=${BITRATE_NOMINAL:-128}
BITRATE_MIN=${BITRATE_MIN:-$BITRATE_NOMINAL}
BITRATE_MAX=${BITRATE_MAX:-$BITRATE_NOMINAL}
NUMBER_CHANNELS=${NUMBER_CHANNELS:-2}
SAMPLE_RATE=${SAMPLE_RATE:-44100}
LOG_LEVEL=${LOG_LEVEL:-2}

cat > streamTranscoder_0.cfg <<EOF
# The source URL for the broadcast. It must be in the form http://server:port/mountpoint.  For those servers without a mountpoint (Shoutcast) use http://server:port.
SourceURL=$SOURCE_URL
AutomaticReconnectSecs=10
AutoConnect=1
# Log Level 1 = LOG_ERROR, 2 = LOG_ERROR+LOG_INFO, 3 = LOG_ERROR+LOG_INFO+LOG_DEBUG
LogLevel=$LOG_LEVEL
# Log File
LogFile=streamTranscoder_0
# Number of encoders to use
NumEncoders=1
EOF

cat > streamTranscoder_1.cfg <<EOF
# Destination server details (to where you are encoding).  Valid server types : Shoutcast, Icecast, Icecast2
ServerType=$SERVER_TYPE
Server=$SERVER
Port=$PORT
ServerPassword=$SERVER_PASSWORD
ServerMountpoint=$SERVER_MOUNTPOINT
ServerStreamURL=$SERVER_STREAM_URL
ServerName=$SERVER_NAME
ServerDescription=$SERVER_DESCRIPTION
ServerGenre=$SERVER_GENRE
AutomaticReconnectSecs=10
AutoConnect=0
# Output codec selection (Valid selections : MP3, OggVorbis, Ogg FLAC, AAC, AAC Plus)
Encode=$ENCODE
# General settings (non-codec related).  Note : NumberChannels = 1 for MONO, 2 for STEREO
BitrateNominal=$BITRATE_NOMINAL
BitrateMin=$BITRATE_MIN
BitrateMax=$BITRATE_MAX
NumberChannels=$NUMBER_CHANNELS
Samplerate=$SAMPLE_RATE
# Ogg Vorbis specific settings.  Note: Valid settings for BitrateQuality flag are (Quality, Bitrate Management)
OggQuality=0
OggBitrateQualityFlag=Bitrate Management
# LAME specific settings.  Note: Setting the low/highpass freq to 0 will disable them.
LameCBRFlag=1
LameQuality=1
LameCopywrite=0
LameOriginal=0
LameStrictISO=0
LameDisableReservior=0
LameVBRMode=vbr_abr
LameLowpassfreq=0
LameHighpassfreq=0
LAMEPreset=0
# AAC (FAAC) specific settings.
AACQuality=100
AACCutoff=
# Save directory for archive streams
SaveDirectory=
# Flag which indicates if we are saving archives
SaveDirectoryFlag=0
# Log Level 1 = LOG_ERROR, 2 = LOG_ERROR+LOG_INFO, 3 = LOG_ERROR+LOG_INFO+LOG_DEBUG
LogLevel=$LOG_LEVEL
# Log File
LogFile=streamTranscoder_1
# Save Archives in WAV format
SaveAsWAV=0
# LAME Joint Stereo Flag
LAMEJointStereo=1
# YP (Stream Directory) Settings
ServerPublic=1
ServerIRC=
ServerAIM=
ServerICQ=
EOF

streamTranscoderv3