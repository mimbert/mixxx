#
# Options, and path to libraries
#

# On Windows, select between WMME, DIRECTSOUND and ASIO.
# If ASIO is used, ensure that the path to the ASIO SDK 2 is set correctly below
WINPA = DIRECTSOUND

# Use this define if the visual subsystem should be included
DEFINES += __VISUALS__

# Path to ASIO SDK
ASIOSDK_DIR   = ../winlib/asiosdk2

#
# End of options
#

# PortAudio 
SOURCES += playerportaudio.cpp
HEADERS += playerportaudio.h
DEFINES += __PORTAUDIO__
PORTAUDIO_DIR = ../lib/portaudio-v18
SOURCES += $$PORTAUDIO_DIR/pa_common/pa_lib.c $$PORTAUDIO_DIR/pa_common/pa_convert.c
HEADERS += $$PORTAUDIO_DIR/pa_common/portaudio.h $$PORTAUDIO_DIR/pa_common/pa_host.h
INCLUDEPATH += $$PORTAUDIO_DIR/pa_common
unix:!macx:SOURCES += $$PORTAUDIO_DIR/pablio/ringbuffer.c $$PORTAUDIO_DIR/pa_unix_oss/pa_unix.c $$PORTAUDIO_DIR/pa_unix_oss/pa_unix_oss.c
unix:!macx:HEADERS += $$PORTAUDIO_DIR/pablio/ringbuffer.h $$PORTAUDIO_DIR/pa_unix_oss/pa_unix.h
unix:!macx:INCLUDEPATH += $$PORTAUDIO_DIR/pa_unix_oss
macx:SOURCES += $$PORTAUDIO_DIR/pablio/ringbuffer.c $$PORTAUDIO_DIR/pa_mac_core/pa_mac_core.c
macx:LIBS += -framework CoreAudio -framework AudioToolbox
macx:INCLUDEPATH += $$PORTAUDIO_DIR/pa_mac_core $$PORTAUDIO_DIR/pablio 
win32 {
    contains(WINPA, DIRECTSOUND) {
        message("Compiling Mixxx using DirectSound drivers")
        SOURCES += $$PORTAUDIO_DIR/pa_win_ds/dsound_wrapper.c $$PORTAUDIO_DIR/pa_win_ds/pa_dsound.c
        LIBS += dsound.lib
        INCLUDEPATH += $$PORTAUDIO_DIR/pa_win_ds
    }
    contains(WINPA, ASIO) {
        message("Compiling Mixxx using ASIO drivers")
        SOURCES += $$PORTAUDIO_DIR/pa_asio/pa_asio.cpp $$ASIOSDK_DIR/common/asio.cpp $$ASIOSDK_DIR/host/asiodrivers.cpp $$ASIOSDK_DIR/host/pc/asiolist.cpp
        HEADERS += $$ASIOSDK_DIR/common/asio.h $$ASIOSDK_DIR/host/asiodrivers.h $$ASIOSDK_DIR/host/pc/asiolist.h
        INCLUDEPATH += $$PORTAUDIO_DIR/pa_asio $$ASIOSDK_DIR/common $$ASIOSDK_DIR/host $$ASIOSDK_DIR/host/pc
        LIBS += winmm.lib
    }
    contains(WINPA, WMME) {
        error("TO use WMME drivers add appropriate files to the mixxx.pro file first")
    }
}

# OSS Midi (Working good, Linux specific)
unix:!macx:SOURCES += midiobjectoss.cpp
unix:!macx:HEADERS += midiobjectoss.h
unix:!macx:DEFINES += __OSSMIDI__

# Windows MIDI
win32:SOURCES += midiobjectwin.cpp
win32:HEADERS += midiobjectwin.h
win32:DEFINES += __WINMIDI__

# PortMidi (Not really working, Linux ALSA, Windows and MacOS X)
#SOURCES += midiobjectportmidi.cpp
#HEADERS += midiobjectportmidi.h
#DEFINES += __PORTMIDI__
#unix:LIBS += -lportmidi -lporttime
#win32:LIBS += ../lib/pm_dll.lib

# CoreMidi (Mac OS X)
macx:SOURCES += midiobjectcoremidi.cpp
macx:HEADERS += midiobjectcoremidi.h
macx:DEFINES += __COREMIDI__
macx:LIBS    += -framework CoreMIDI -framework CoreFoundation

# ALSA PCM (Not currently working, Linux specific)
#SOURCES += playeralsa.cpp
#HEADERS += playeralsa.h
#DEFINES += __ALSA__
#unix:LIBS += -lasound

# ALSA MIDI (Not currently working, Linux specific)
#SOURCES += midiobjectalsa.cpp
#HEADERS += midiobjectalsa.h
#DEFINES  += __ALSAMIDI__

# Visuals (Alpha)
contains(DEFINES, __VISUALS__) {
    message("Compiling with visual subsystem")
    SOURCES += mixxxvisual.cpp visual/visualbackplane.cpp visual/texture.cpp visual/guicontainer.cpp visual/signalvertexbuffer.cpp visual/visualbox.cpp visual/visualcontroller.cpp visual/guichannel.cpp visual/guisignal.cpp visual/light.cpp visual/material.cpp visual/picking.cpp visual/pickable.cpp visual/visualdata.cpp visual/visualdatasignal.cpp visual/visualdatamark.cpp visual/visualobject.cpp visual/fastvertexarray.cpp
    HEADERS += mixxxvisual.h visual/visualbackplane.h  visual/texture.h visual/guicontainer.h visual/signalvertexbuffer.h visual/visualbox.h visual/visualcontroller.h visual/guichannel.h visual/guisignal.h visual/light.h visual/material.h visual/picking.h visual/pickable.h visual/visualdata.h visual/visualdatasignal.h visual/visualdatamark.h visual/visualobject.h visual/fastvertexarray.h
    CONFIG += opengl
}

# Use NVSDK when building visuals (not tested recently)
#DEFINES += __NVSDK__
#win32:INCLUDEPATH += c:/Progra~1/NVIDIA~1/NVSDK/OpenGL/include/glh
#win32:LIBS += c:/Progra~1/NVIDIA~1/NVSDK/OpenGL/lib/debug/glut32.lib
#unix:INCLUDEPATH +=/usr/local/nvsdk/OpenGL/include/glh
#unix:DEFINES += UNIX
#unix:LIBS += -L/usr/local/nvsdk/OpenGL/lib/ -lnv_memory

SOURCES	+= configobject.cpp fakemonitor.cpp controlengine.cpp controlenginequeue.cpp controleventengine.cpp controleventmidi.cpp controllogpotmeter.cpp controlobject.cpp controlnull.cpp controlpotmeter.cpp controlpushbutton.cpp controlrotary.cpp controlttrotary.cpp controlbeat.cpp dlgchannel.cpp dlgplaycontrol.cpp dlgplaylist.cpp dlgmaster.cpp dlgcrossfader.cpp dlgsplit.cpp dlgpreferences.cpp dlgprefsound.cpp dlgprefmidi.cpp dlgprefplaylist.cpp dlgflanger.cpp enginebuffer.cpp enginebufferscale.cpp enginebufferscalelinear.cpp engineclipping.cpp enginefilterblock.cpp enginefilteriir.cpp engineobject.cpp enginepregain.cpp enginevolume.cpp main.cpp midiobject.cpp midiobjectnull.cpp mixxx.cpp mixxxdoc.cpp mixxxview.cpp player.cpp soundsource.cpp soundsourcemp3.cpp soundsourceoggvorbis.cpp monitor.cpp enginechannel.cpp enginemaster.cpp wknob.cpp wbulb.cpp wplaybutton.cpp wpushbutton.cpp wwheel.cpp wslider.cpp wpflbutton.cpp wplayposslider.cpp wtracktable.cpp wtracktableitem.cpp enginedelay.cpp engineflanger.cpp enginespectralfwd.cpp enginespectralback.cpp mathstuff.cpp readerextract.cpp readerextractwave.cpp readerextractfft.cpp readerextracthfc.cpp readerextractbeat.cpp readerevent.cpp rtthread.cpp windowkaiser.cpp probabilityvector.cpp reader.cpp tracklist.cpp trackinfoobject.cpp dlgtracklist.cpp
HEADERS	+= configobject.h fakemonitor.h controlengine.h controlenginequeue.h controleventengine.h controleventmidi.h controllogpotmeter.h controlobject.h controlnull.h controlpotmeter.h controlpushbutton.h controlrotary.h controlttrotary.h controlbeat.h defs.h dlgchannel.h dlgplaycontrol.h dlgplaylist.h dlgmaster.h dlgcrossfader.h dlgsplit.h dlgpreferences.h dlgprefsound.h dlgprefmidi.h dlgprefplaylist.h dlgflanger.h enginebuffer.h enginebufferscale.h enginebufferscalelinear.h engineclipping.h enginefilterblock.h enginefilteriir.h engineobject.h enginepregain.h enginevolume.h midiobject.h midiobjectnull.h mixxx.h mixxxdoc.h mixxxview.h player.h soundsource.h soundsourcemp3.h soundsourceoggvorbis.h monitor.h enginechannel.h enginemaster.h wknob.h wbulb.h wplaybutton.h wpushbutton.h wwheel.h wslider.h wpflbutton.h wplayposslider.h wtracktable.h wtracktableitem.h enginedelay.h engineflanger.h enginespectralfwd.h enginespectralback.h mathstuff.h readerextract.h readerextractwave.h readerextractfft.h readerextracthfc.h readerextractbeat.h readerevent.h rtthread.h windowkaiser.h probabilityvector.h reader.h  tracklist.h trackinfoobject.h dlgtracklist.h
#SOURCES += wslidervol.cpp
#HEADERS += wslidervol.h images/slidervoltest/lp1.h images/slidervoltest/lp2.h

# libsamplerate
#INCLUDEPATH += ../lib/libsamplerate
#SOURCES += enginebufferscalesrc.cpp ../lib/libsamplerate/samplerate.c ../lib/libsamplerate/src_linear.c ../lib/libsamplerate/src_sinc.c ../lib/libsamplerate/src_zoh.c
#HEADERS += enginebufferscalesrc.h ../lib/libsamplerate/samplerate.h ../lib/libsamplerate/config.h ../lib/libsamplerate/common.h ../lib/libsamplerate/float_cast.h ../lib/libsamplerate/fastest_coeffs.h ../lib/libsamplerate/high_qual_coeffs.h ../lib/libsamplerate/mid_qual_coeffs.h 

# vbrheadersdk from Xing Technology
INCLUDEPATH += ../lib/vbrheadersdk
SOURCES += ../lib/vbrheadersdk/dxhead.c
HEADERS += ../lib/vbrheadersdk/dxhead.h

# Debug plotting through gplot API
#unix:DEFINES += __GNUPLOT__
#unix:INCLUDEPATH += ../lib/gplot
#unix:SOURCES += ../lib/gplot/gplot3.c
#unix:HEADERS += ../lib/gplot/gplot.h

# PowerMate support
SOURCES += powermate.cpp
HEADERS += powermate.h
unix:!macx:SOURCES += powermatelinux.cpp
unix:!macx:HEADERS += powermatelinux.h
win32:SOURCES += powermatewin.cpp
win32:HEADERS += powermatewin.h
win32:LIBS += setupapi.lib


unix {
  DEFINES += __UNIX__
  UI_DIR = .ui
  MOC_DIR = .moc
  OBJECTS_DIR = .obj
  SOURCES += soundsourceaudiofile.cpp
  HEADERS += soundsourceaudiofile.h
  LIBS += -lmad -lid3tag #/usr/local/lib/libmad.a  -lvorbisfile -lvorbis
  !macx:LIBS += -laudiofile #/usr/lib/libaudiofile.a
  LIBS += -lsrfftw -lsfftw
  INCLUDEPATH += . 
  QMAKE_CXXFLAGS += -Wall
    
#  Intel Compiler optimization flags
  QMAKE_CXXFLAGS += -rcd -tpp6 -xiMK # icc pentium III
#  QMAKE_CXXFLAGS += -rcd -tpp7 -xiMKW # icc pentium IV 
#  QMAKE_CXXFLAGS += -prof_gen # icc profiling
  QMAKE_CXXFLAGS += -prof_use # 

# GCC Compiler optimization flags
#  QMAKE_CXXFLAGS += -march=pentium3 -O3 -pipe
#  QMAKE_CFLAGS   += -march=pentium3 -O3 -pipe

  !macx:CONFIG_PATH = \"/usr/share/mixxx\"
}

win32 {
  DEFINES += __WIN__
  INCLUDEPATH += ../winlib ../winlib/id3lib ../lib/portaudio-v18 ../lib . 
  SOURCES += soundsourcesndfile.cpp
  HEADERS += soundsourcesndfile.h ../winlib/fftw.h ../winlib/rfftw.h
  LIBS += ../winlib/libmad.lib ../winlib/libid3tag.lib ../winlib/libsndfile.lib ../winlib/rfftw2st.lib ../winlib/fftw2st.lib ../winlib/vorbisfile_static_d.lib ../winlib/vorbis_static_d.lib ../winlib/ogg_static_d.lib
  QMAKE_CXXFLAGS += -GX
  QMAKE_LFLAGS += /NODEFAULTLIB:libcd /NODEFAULTLIB:libcmtd /NODEFAULTLIB:libc /NODEFAULTLIB:msvcrt
  #/NODEFAULTLIB:msvcrt.lib 
  CONFIG_PATH = \"config\"
}

macx {
  DEFINES += __MACX__
  LIBS += /usr/local/lib/libaudiofile.a -lz -framework Carbon -framework QuickTime
  CONFIG_PATH = \"./Contents/Resources/config/\" 
}

# gcc Profiling
#unix:QMAKE_CXXFLAGS_DEBUG += -pg
#unix:QMAKE_LFLAGS_DEBUG += -pg

# icc Profiling
#unix:QMAKE_CXXFLAGS_DEBUG += -qp -g
#unix:QMAKE_LFLAGS_DEBUG += -qp -g


DEFINES += CONFIG_PATH=$$CONFIG_PATH
FORMS	= dlgchanneldlg.ui dlgplaycontroldlg.ui dlgplaylistdlg.ui dlgmasterdlg.ui dlgcrossfaderdlg.ui dlgsplitdlg.ui dlgprefsounddlg.ui dlgprefmididlg.ui dlgprefplaylistdlg.ui dlgflangerdlg.ui dlgtracklistdlg.ui
unix:TEMPLATE         = app
win32:TEMPLATE       = vcapp
CONFIG	+= qt warn_off thread release 
DBFILE	= mixxx.db
LANGUAGE	= C++

#IMAGES	= filesave.xpm
