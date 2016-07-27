ifeq ($(CONFIG_OS),y)
-include $(TOPDIR)/.config
CFLAGS += -I$(TOPDIR)/include
export CFLAGS CONFIG_OS
endif

all:
ifdef CONFIG_OS
ifeq ($(CONFIG_WIFI_STA),y)
	$(Q) $(MAKE) -C wpa_supplicant
endif
ifeq ($(CONFIG_WIFI_AP),y)
	$(Q) $(MAKE) -C hostapd
endif
	$(Q) cp -r libwifi.a $(TOPDIR)/lib/
else
	$(Q) $(MAKE) -C wpa_supplicant
	$(Q) $(MAKE) -C hostapd
endif

clean:
ifdef CONFIG_OS
ifeq ($(CONFIG_WIFI_STA),y)
	$(Q) $(MAKE) -C wpa_supplicant clean
endif
ifeq ($(CONFIG_WIFI_AP),y)
	$(Q) $(MAKE) -C hostapd clean
endif
else
	$(Q) $(MAKE) -C wpa_supplicant clean
	$(Q) $(MAKE) -C hostapd clean
endif

distclean:
ifdef CONFIG_OS
ifeq ($(CONFIG_WIFI_STA),y)
	$(Q) $(MAKE) -C wpa_supplicant distclean
endif
ifeq ($(CONFIG_WIFI_AP),y)
	$(Q) $(MAKE) -C hostapd distclean
endif
else
	$(Q) $(MAKE) -C wpa_supplicant distclean
	$(Q) $(MAKE) -C hostapd distclean
endif
