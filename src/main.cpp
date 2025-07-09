
#include <iostream>
#include <chrono>
#include <thread>
#include <cstdlib> // For system call
#include <csignal>

#define SLEEP_TIME 100
#define SLEEP_STEP 1

#define DEFAULT		"\033[0m"
#define BOLD		"\033[1m"
#define LIGHTRED	"\033[91m"
#define LIGHTGREEN	"\033[92m"
#define LIGHTYELLOW	"\033[93m"

#define HIDE_CURSOR "\033[?25l"
#define SHOW_CURSOR "\033[?25h"
#define GO_UP "\033[A"
#define GO_DOWN "\033[B"
#define GO_TO_FRONT "\033[2K\033[1G"

size_t	count(bool doCount)
{
	static size_t count;

	if (doCount)
		++count;
	return count;
}

void goUp(int times)
{
	for (int i=0; i < times; ++i)
		std::cout << GO_UP;
}

void goDown(int times)
{
	for (int i=0; i < times; ++i)
		std::cout << GO_DOWN;
}

void printCleanedCount(int up, int down)
{
	size_t 		counted = count(false);
	std::string timesStr = " time";
	if (counted != 1)
		timesStr += 's';

	goUp(up);
	std::cout	<< GO_TO_FRONT
				<< "cleaned: "
				<< LIGHTGREEN << BOLD << counted
				<< DEFAULT << timesStr;
	goDown(down);
	std::cout << GO_TO_FRONT;
	std::cout.flush();
}

void printCounter(int i, int MAX) {
	if (i <= MAX / 10) {
		std::cout << LIGHTRED;
	} else if (i <= static_cast<int>(static_cast<float>(MAX) / 4.0f)) {
		std::cout << LIGHTYELLOW;
	} else {
		std::cout << DEFAULT;
	}
	std::cout << GO_TO_FRONT << i;
	std::cout.flush();
}

void	handleAbort(int signum)
{
	(void)signum;
	std::cout << "\033[2K\033[1G";
	std::cout.flush();

	std::signal(SIGINT,  SIG_DFL);
	std::signal(SIGQUIT, SIG_DFL);
	std::signal(SIGTERM, SIG_DFL);
	std::signal(SIGHUP,  SIG_DFL);
	std::signal(SIGKILL, SIG_DFL);
	
	std::cout << SHOW_CURSOR;
	printCleanedCount(2,2);
	exit(0);
}

int main(int ac, char **av) {

	int sleep_time = SLEEP_TIME;

	if (ac == 2) {
		try {
			sleep_time = std::stoi(av[1]);
		} catch (...) {
			std::cout << "whoops, sth went wrong" << std::endl;
			exit(1);
		}
	}

	std::signal(SIGINT,  handleAbort);
	std::signal(SIGQUIT, handleAbort);
	std::signal(SIGTERM, handleAbort);
	std::signal(SIGHUP,  handleAbort);
	std::signal(SIGKILL, handleAbort);

	std::cout << HIDE_CURSOR << "\n\n";
	std::cout.flush();

	printCleanedCount(2, 2);
    while (true) {
        // Execute your system call here
		std::cout << GO_UP << GO_TO_FRONT;
		std::cout.flush();
        std::system("./_clean_cache.sh");
		count(true);
		printCleanedCount(2, 2);

        // Sleep for 10 minutes
		std::cout << "\033[91m";
		int timer = sleep_time;
		while (timer > 0) {
			printCounter(timer, sleep_time);
			timer -= SLEEP_STEP;
        	std::this_thread::sleep_for(std::chrono::seconds(SLEEP_STEP));
			// std::cout << ".";
		}
		printCounter(0, sleep_time); std::this_thread::sleep_for(std::chrono::milliseconds(250));
		// std::cout << GO_TO_FRONT << DEFAULT;
		// std::cout.flush();
    }

	return 0;
}