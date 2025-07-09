# clean42

is a small c++ program that uses a custom striped down and enhanced `_clean_cache.sh` script from [Cleaner_42](https://github.com/ombhd/Cleaner_42) and executes it after a countdown.

**It preservers your vscode windows.**

# it cleans
- `trash`
- `caches`
- `slack`
- `chrome`
- `vscode`
- `.DS_Store`
- `tmp files`
- `Keychain`


# Configuration
go to the top of the `main.cpp`, there you can setup:
```c++
#define SLEEP_TIME 100	// Time interval between cleaning cycles, in seconds
#define SLEEP_STEP 1	// Time decrement step for printing the countdown of remaining seconds
```


# Installation
```sh
git clone https://github.com/nmihaile/clean42 clean42
cd clean42
make
```


# Usage
```
./clean42
```
use `<ctrl-c>` to quit
