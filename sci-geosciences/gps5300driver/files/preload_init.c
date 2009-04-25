#define _GNU_SOURCE

#include <dlfcn.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

static struct sockaddr_un ctrl_sau = {
	AF_UNIX,
	"/var/lib/gps/gps_driver_ctrl\0",
};
#define CTRL_SCK_PATH ctrl_sau.sun_path

static int ctrl_sck = -1;

typedef int (*bind_t)(int, const struct sockaddr*, socklen_t);

int
bind(int sockfd, const struct sockaddr*addr, socklen_t addrlen) {
	static bind_t real = NULL;
	if (!real)
		real = dlsym(RTLD_NEXT, "bind");
	
	int rv = real(sockfd, addr, addrlen);
	
	if (
	    addr &&
	    addr->sa_family == AF_FILE &&
	    !strcmp(CTRL_SCK_PATH,
	            ((struct sockaddr_un*)addr)->sun_path
	           ) &&
	    getenv("GPS5300_SELFINIT") &&
	    1
	)
		ctrl_sck = sockfd;
	
	return rv;
}

typedef int (*listen_t)(int, int);

int
listen(int sockfd, int backlog) {
	static listen_t real = NULL;
	if (!real)
		real = dlsym(RTLD_NEXT, "listen");
	
	int rv = real(sockfd, backlog);
	
	if (sockfd == ctrl_sck && !fork())
	{
		// Child process :)
		
		int sck;
		char initcmd[] = "P 3\n";
		
		sck = socket(PF_FILE, SOCK_STREAM, 0);
		if (sck < 0)
			exit(1);
		if (connect(sck, &ctrl_sau, sizeof ctrl_sau))
			exit(1);
		write(sck, initcmd, sizeof initcmd);
		close(sck);
		
		exit(0);
	}
	
	return rv;
}
