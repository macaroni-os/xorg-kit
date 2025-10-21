# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
USE_INPUT_DEVICES="
  input_devices_evdev
  input_devices_libinput
  input_devices_mouse
  input_devices_vmmouse
  input_devices_synaptics
  input_devices_wacom
"

IUSE_VIDEO_CARDS="
  video_cards_amdgpu
  video_cards_dummy
  video_cards_fbdev
  video_cards_nouveau
  video_cards_vesa
  video_cards_virtualbox
  video_cards_vmware
  video_cards_nvidia
"


DESCRIPTION="Meta package containing deps on all xorg drivers"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="${IUSE_VIDEO_CARDS} ${USE_INPUT_DEVICES}"
PDEPEND="input_devices_evdev? (
	  >=x11-base/xorg-server-21.1.18[udev]
	  x11-drivers/xf86-input-evdev
	)
	input_devices_libinput?    (
	  >=x11-base/xorg-server-21.1.18[udev]
	  x11-drivers/xf86-input-libinput
	)
	input_devices_mouse? ( x11-drivers/xf86-input-mouse )
	input_devices_vmmouse? ( x11-drivers/xf86-input-vmmouse )
	input_devices_synaptics? ( x11-drivers/xf86-input-synaptics )
	input_devices_wacom? ( x11-drivers/xf86-input-wacom )
	video_cards_amdgpu? ( x11-drivers/xf86-video-amdgpu )
	video_cards_dummy? ( x11-drivers/xf86-video-dummy )
	video_cards_fbdev? ( x11-drivers/xf86-video-fbdev )
	video_cards_nouveau? ( x11-drivers/xf86-video-nouveau )
	video_cards_nvidia? ( x11-drivers/nvidia-drivers )
	video_cards_vesa? ( x11-drivers/xf86-video-vesa )
	video_cards_virtualbox? ( x11-drivers/xf86-video-vbox )
	video_cards_vmware? ( x11-drivers/xf86-video-vmware )
	
"

# vim: filetype=ebuild
