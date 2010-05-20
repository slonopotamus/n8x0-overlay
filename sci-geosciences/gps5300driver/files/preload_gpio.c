/*
 * Copyright 2009 Luke Dashjr <luke_n8x0_gps5300driver@dashjr.org>
 * Licensed for redistribution as-is;
 * contact me if you want something more permissive
 */

#define _GNU_SOURCE

#include <assert.h>
#include <dlfcn.h>
#include <stdlib.h>
#include <sys/types.h>
#include <regex.h>

typedef int (*system_t)(const char*);

static regex_t reCmd;

static
void
ljr_preload_gpio_init() {
	assert(!regcomp(&reCmd, "echo \\(in\\)\\?active >/sys/devices/platform/gpio-switch/gps_\\(reset\\|wakeup\\)/state", REG_NOSUB));
}

void
__attribute__ ((destructor))
ljr_preload_gpio_finish() {
	regfree(&reCmd);
}

int
system(const char *command) {
	static system_t real = NULL;
	if (!real)
	{
		real = dlsym(RTLD_NEXT, "system");
		ljr_preload_gpio_init();
	}
	
	if (!regexec(&reCmd, command, 0, NULL, 0))
	{
		char*envname;
		if (command[5] == 'a')
		{
			if (command[29] == 'w')
				envname = "GPS5300_CMD_ACTIVATE_WAKEUP";
			else
				envname = "GPS5300_CMD_ACTIVATE_RESET";
		}
		else
		{
			if (command[31] == 'w')
				envname = "GPS5300_CMD_DEACTIVATE_WAKEUP";
			else
				envname = "GPS5300_CMD_DEACTIVATE_RESET";
		}
		const char*subcmd = getenv(envname);
		if (subcmd)
			command = subcmd;
	}
	
	return real(command);
}
