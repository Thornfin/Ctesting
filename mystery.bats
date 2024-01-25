setup() {
    load 'bats/bats-support/load'
    load 'bats/bats-assert/load'
}

@test "Input is a palindrome" {
    run ./mystery "racecar"
    assert_success
    assert_output "racecar"
}

@test "Input is not a palindrome" {
    run ./mystery "hello"
    assert_success
    assert_output "?"
}

@test "Input is a palindrome with mixed case" {
    run ./mystery "RaceCar"
    assert_success
    assert_output "?"
}

@test "Input is a single character (always a palindrome)" {
    run ./mystery "a"
    assert_success
    assert_output "a"
}

@test "No input provided" {
    run ./mystery
    assert_success
    assert_output "Usage: ./mystery <string>"
}

@test "Input is an empty string (considered a palindrome)" {
    run ./mystery ""
    assert_success
    assert_output ""
}

@test "Input is a palindrome phrase with spaces" {
    run ./mystery "a man a plan a canal panama"
    assert_success
    assert_output "?"
}

