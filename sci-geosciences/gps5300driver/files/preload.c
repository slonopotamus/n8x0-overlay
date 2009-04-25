#define _GNU_SOURCE

#include <dlfcn.h>
#include <pwd.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>

typedef struct passwd* (*getpwnam_t)(const char*);

struct passwd *
getpwnam(const char *name) {
	static getpwnam_t real = NULL;
	if (!real)
		real = dlsym(RTLD_NEXT, "getpwnam");
	
	if (!strcmp(name, "user"))
	{
		const char*username = getenv("GPS5300DRIVER_USER");
		if (username)
			name = username;
	}
	
	return real(name);
}
