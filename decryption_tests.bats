#!/usr/bin/env bats

load 'bats/bats-support/load'
load 'bats/bats-assert/load'

setup() {
    gcc -o decryption decryption.c
    TEST_TMPDIR=$(mktemp -d)
}

teardown() {
    rm -rf "$TEST_TMPDIR"
}

@test "Decryption with valid input and output files" {
    echo "DEF abc" > "$TEST_TMPDIR/input.txt"  # Encrypted content
    ./decryption "$TEST_TMPDIR/input.txt" "$TEST_TMPDIR/output.txt"
    run cat "$TEST_TMPDIR/output.txt"
    assert_output "ABC xyz"  # Expected decrypted content
}

@test "Preserve non-alphabetical characters and case" {
    echo "DEF! abc 123" > "$TEST_TMPDIR/input.txt"  # Encrypted content with non-alphabetic characters
    ./decryption "$TEST_TMPDIR/input.txt" "$TEST_TMPDIR/output.txt"
    run cat "$TEST_TMPDIR/output.txt"
    assert_output "ABC! xyz 123"  # Decrypted content should preserve non-alphabetical characters and numbers
}

@test "Handle empty input file" {
    touch "$TEST_TMPDIR/input.txt"  # Create an empty file
    ./decryption "$TEST_TMPDIR/input.txt" "$TEST_TMPDIR/output.txt"
    run cat "$TEST_TMPDIR/output.txt"
    assert_output ""  # Expect empty output
}

@test "Error when input file does not exist" {
    run ./decryption "nonexistent.txt" "$TEST_TMPDIR/output.txt"
    assert_failure  # Expect the command to fail
    assert_output --partial "Error opening file"  # Expect error message about file opening
}

@test "Error when no arguments are provided" {
    run ./decryption
    assert_failure  # Expect the command to fail
    assert_output --partial "Usage: ./decryption <inputfile> <outputfile>"  # Expect usage message
}

@test "Error when only one argument is provided" {
    run ./decryption "$TEST_TMPDIR/input.txt"
    assert_failure  # Expect the command to fail
    assert_output --partial "Usage: ./decryption <inputfile> <outputfile>"  # Expect usage message
}

@test "Check line length limit" {
    # Generate an input file with a line of more than 80 characters
    echo "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" > "$TEST_TMPDIR/input.txt"

    # Run the decryption program with the input file and an output file
    run ./decryption "$TEST_TMPDIR/input.txt" "$TEST_TMPDIR/output.txt"

    # Assert that the decryption program failed (exit status is not 0)
    assert_failure

    # Optionally, you can check for a specific error message output
    # assert_output --partial "Error: the number of characters exceeds 80 on a line."
}


@test "Decryption of wrap-around characters (Z becomes C etc.)" {
    echo "ZAB" > "$TEST_TMPDIR/input.txt"  # Encrypted content with wrap-around
    ./decryption "$TEST_TMPDIR/input.txt" "$TEST_TMPDIR/output.txt"
    run cat "$TEST_TMPDIR/output.txt"
    assert_output "WXY"  # Expected decrypted content with wrap-around
}

