#!/bin/bash
# Student Number: S4228356
# Student Full Name: Jed Ernest John Beard
#
# maths.sh - Simple calculator for Linux

# Comment 1: The while loop keeps the calculator running until the user selects Exit
while true
do
    echo ""
    echo "===== Simple Calculator ====="
    echo "1. Addition"
    echo "2. Subtraction"
    echo "3. Multiplication"
    echo "4. Division"
    echo "5. Exit"
    read -p "Select an option (1-5): " option || break

    # Comment 2: Selection checks the menu option the user entered is valid
    if [ "$option" == "5" ]; then
        echo "Exiting calculator. Goodbye!"
        break
    elif [[ "$option" =~ ^[1-4]$ ]]; then
        read -p "Enter the first number: " num1
        read -p "Enter the second number: " num2

        # Comment 3: Validate that both inputs are numbers (whole or decimal)
        if ! [[ "$num1" =~ ^-?[0-9]+([.][0-9]+)?$ ]] || ! [[ "$num2" =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
            echo "Error: please enter valid numbers."
            continue
        fi

        # Perform the arithmetic operation the user selected
        case $option in
            1)
                result=$(awk -v a="$num1" -v b="$num2" 'BEGIN {print a + b}')
                symbol="+"
                ;;
            2)
                result=$(awk -v a="$num1" -v b="$num2" 'BEGIN {print a - b}')
                symbol="-"
                ;;
            3)
                result=$(awk -v a="$num1" -v b="$num2" 'BEGIN {print a * b}')
                symbol="*"
                ;;
            4)
                # Stop division by zero
                if awk -v b="$num2" 'BEGIN {exit !(b == 0)}'; then
                    echo "Error: cannot divide by zero."
                    continue
                fi
                result=$(awk -v a="$num1" -v b="$num2" 'BEGIN {printf "%.2f", a / b}')
                symbol="/"
                ;;
        esac

        echo "Result: $num1 $symbol $num2 = $result"
    else
        echo "Invalid option. Please select a number from 1 to 5."
    fi
done
