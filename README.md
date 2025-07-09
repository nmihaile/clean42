### clean42

is a small c++ program that uses a custom striped down `_clean_script.sh` from [Cleaner_42](https://github.com/ombhd/Cleaner_42) and executes it after a countdown.

it cleans
`trash` `caches` `slack` `chrome` `vscode` `.DS_Store` `tmp files` `Keychain`
but it preservers your vscode windows.

### Configuration
go to the top of the `main.cpp`, there you can setup:
```c++
#define SLEEP_TIME 100	// time between cleaning in seconds
#define SLEEP_STEP 1	// countdown step time to print the remaining seconds
```


### Installation
```sh
git clone https://github.com/nmihaile/clean42 clean42
cd clean42
make
```

### Usage
```
./clean42
```
use `<ctrl-c>` to quit
