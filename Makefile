V8DIR = ../../../v8/v8

verifier : verifier.cpp
	g++ -I$(V8DIR)/include -L$(V8DIR)/out/x64.release/obj -Wall -Werror -o verifier verifier.cpp -lv8_monolith -pthread
