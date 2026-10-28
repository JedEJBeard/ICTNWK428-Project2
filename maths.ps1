# Student Number: S4228356
# Student Full Name: Jed Ernest John Beard
#
# maths.ps1 - Simple calculator for Windows

# Comment 1: The do-while loop keeps the calculator running until the user selects Exit
do {
    Write-Host ""
    Write-Host "===== Simple Calculator ====="
    Write-Host "1. Addition"
    Write-Host "2. Subtraction"
    Write-Host "3. Multiplication"
    Write-Host "4. Division"
    Write-Host "5. Exit"
    $option = Read-Host "Select an option (1-5)"

    # Comment 2: Selection checks the menu option the user entered is valid
    if ($option -eq "5") {
        Write-Host "Exiting calculator. Goodbye!"
    }
    elseif ($option -match '^[1-4]$') {
        $num1 = Read-Host "Enter the first number"
        $num2 = Read-Host "Enter the second number"
        $n1 = 0.0
        $n2 = 0.0
        $result = $null

        # Comment 3: Validate that both inputs are numbers before calculating
        if ((-not [double]::TryParse($num1, [ref]$n1)) -or (-not [double]::TryParse($num2, [ref]$n2))) {
            Write-Host "Error: please enter valid numbers."
        }
        else {
            # Perform the arithmetic operation the user selected
            switch ($option) {
                "1" { $result = $n1 + $n2; $symbol = "+" }
                "2" { $result = $n1 - $n2; $symbol = "-" }
                "3" { $result = $n1 * $n2; $symbol = "*" }
                "4" {
                    # Stop division by zero
                    if ($n2 -eq 0) {
                        Write-Host "Error: cannot divide by zero."
                    }
                    else {
                        $result = [math]::Round($n1 / $n2, 2)
                        $symbol = "/"
                    }
                }
            }

            if ($null -ne $result) {
                Write-Host "Result: $n1 $symbol $n2 = $result"
            }
        }
    }
    else {
        Write-Host "Invalid option. Please select a number from 1 to 5."
    }
} while ($option -ne "5")
