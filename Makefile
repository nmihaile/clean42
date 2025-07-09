# Sources
SRC_FOLDERS	=	src \


VPATH		=	$(SRC_FOLDERS)


SRCS_NO_MAIN=	


SRCS		=	main.cpp $(SRCS_NO_MAIN)

# Includes
INCLUDES_DIRS	=	$(SRC_FOLDERS)
INCLUDE_FLAG	=	$(addprefix -I, $(INCLUDES_DIRS))

# Compilation
NAME		=	clean42
CPP			=	c++
CPPFLAGS	=	-Wall -Wextra -Werror -std=c++17 #-g -fsanitize=address

OBJS_DIR	=	obj
OBJS		=	$(addprefix $(OBJS_DIR)/, $(SRCS:.cpp=.o))

all: $(NAME)
	@echo "\033[92mexecute with: \033[1;92m"./$(NAME)"\033[0m"

$(NAME): $(OBJS)
	$(CPP) $(CPPFLAGS) $(INCLUDE_FLAG) $(OBJS) -o $(NAME)

$(OBJS_DIR)/%.o: %.cpp
	@mkdir -p $(dir $@)
	$(CPP) $(CPPFLAGS) $(INCLUDE_FLAG) -c $< -o $@

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAME)

re: fclean all

run: $(NAME)
	@./$(NAME)

r: run
s: run
start: run

debug: fclean
debug: CPPFLAGS += -g
debug: $(NAME)