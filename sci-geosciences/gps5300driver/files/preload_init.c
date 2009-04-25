#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>

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
	    !strcmp("/var/lib/gps/gps_driver_ctrl",
	            ((struct sockaddr_un*)addr)->sun_path
	           ) &&
	    getenv("GPS5300_SELFINIT") &&
	    !fork()
	)
	{
		// Child process :)
		
		int sck;
		char initcmd[] = "P 3\n";
		
		sck = socket(PF_UNIX, SOCK_DGRAM, 0);
		if (sck < 0)
			exit(1);
		connect(sck, addr, addrlen) &&
			exit(1);
		write(sck, initcmd, sizeof initcmd);
		close(sck);
		
		exit(0);
	}
	
	return rv;
}
