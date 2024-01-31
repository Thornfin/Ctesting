
load 'bats/bats-support/load'
load 'bats/bats-assert/load'

setup() {
    # Setup test environment
    # Define the names of your test input and output files
    TEST_INPUT="testInput.txt"
    TEST_OUTPUT="testOutput.txt"
    EXPECTED_OUTPUT="expectedOutput.txt"

    # Create a test input file with sample content
    # (Adjust the content according to what your decryption program expects)
    echo "Encrypted content" > "$TEST_INPUT"

    # Create an expected output file with the content you expect after decryption
    # (This should be the expected result of decrypting the test input)
    echo "Decrypted content" > "$EXPECTED_OUTPUT"
}

teardown() {
    # Cleanup test environment
    # Remove the test files after the test is done
    rm -f "$TEST_INPUT" "$TEST_OUTPUT" "$EXPECTED_OUTPUT"
}

@test "Decryption of large input" {
    # Ensure the TEST_INPUT points to your large input file
    TEST_INPUT="testInput.txt"
    TEST_OUTPUT="testOutput.txt"
    EXPECTED_OUTPUT="expectedOutput.txt" # Make sure this file has the expected output

    run ./decryption "$TEST_INPUT" "$TEST_OUTPUT"
    assert_success
    assert_file_equal "$TEST_OUTPUT" "$EXPECTED_OUTPUT"
}


@test "Decryption program test" {
    # Run the decryption program
    run ./decryption "$TEST_INPUT" "$TEST_OUTPUT"

    # Assert that the program exited successfully
    assert_success

    # Assert that the output of the decryption matches the expected output
    assert_file_equal "$TEST_OUTPUT" "$EXPECTED_OUTPUT"
}

@test "Decryption of standard input" {
    echo "Encrypted standard content" > "$TEST_INPUT"
    echo "Expected decrypted standard content" > "$EXPECTED_OUTPUT"
    
    run ./decryption "$TEST_INPUT" "$TEST_OUTPUT"
    assert_success
    assert_file_equal "$TEST_OUTPUT" "$EXPECTED_OUTPUT"
}


@test "Decryption of empty input" {
    echo -n > "$TEST_INPUT"  # Create an empty file
    echo "Expected output for empty input" > "$EXPECTED_OUTPUT"
    
    run ./decryption "$TEST_INPUT" "$TEST_OUTPUT"
    assert_success
    assert_file_equal "$TEST_OUTPUT" "$EXPECTED_OUTPUT"
}

@test "Decryption of large input" {
    base64 /dev/urandom | head -c 1000000 > "$TEST_INPUT"  # Generate a large file
    echo "Expected output for large input" > "$EXPECTED_OUTPUT"
    
    run ./decryption "$TEST_INPUT" "$TEST_OUTPUT"
    assert_success
    assert_file_equal "$TEST_OUTPUT" "$EXPECTED_OUTPUT"
}

@test "Decryption of invalid input" {
    echo "Invalid input content" > "$TEST_INPUT"
    echo "Expected output for invalid input" > "$EXPECTED_OUTPUT"
    
    run ./decryption "$TEST_INPUT" "$TEST_OUTPUT"
    assert_success
    assert_file_equal "$TEST_OUTPUT" "$EXPECTED_OUTPUT"
}

@test "Decryption with non-existing input file" {
    run ./decryption "non_existing_file.txt" "$TEST_OUTPUT"
    assert_failure
    # You can also check for a specific error message if your program provides one
}

@test "Decryption with file permission issues" {
    touch "$TEST_INPUT"
    chmod 000 "$TEST_INPUT"  # Remove all permissions
    run ./decryption "$TEST_INPUT" "$TEST_OUTPUT"
    assert_failure
    # Optionally check the error message
    chmod 644 "$TEST_INPUT"  # Restore permissions for cleanup
}

