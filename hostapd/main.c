/*
 * WPA Supplicant / Example program entrypoint
 * Copyright (c) 2003-2005, Jouni Malinen <j@w1.fi>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * Alternatively, this software may be distributed under the terms of BSD
 * license.
 *
 * See README and COPYING for more details.
 */

#include "utils/includes.h"
#include "ap/hostapd.h"
#include "init.h"

extern struct hostapd_iface * g_hostapd_iface;

int main(int argc, char *argv[])
{
	int ret = 1;
	size_t i;
	int debug = 0;

	if (hostapd_global_init(g_hostapd_iface))
		return -1;

	/* Initialize interfaces */

	g_hostapd_iface = hostapd_interface_init(NULL, debug);


	if (hostapd_global_run(g_hostapd_iface))
		goto out;

	ret = 0;

 out:
	/* Deinitialize all interfaces */
	
	hostapd_interface_deinit_free(g_hostapd_iface);
	os_free(g_hostapd_iface);
	g_hostapd_iface = NULL;

	hostapd_global_deinit();

	return ret;
}
